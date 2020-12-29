#if canImport(CoreGraphics)
import XCTest
import CoreGraphics
import ColorComponents

final class HSBA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreation() throws {
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsb = HSB<CGFloat>(hue: 0.25, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        let opaqueColor = hsb.cgColor
        let alphaColor = hsba.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0.25)
        XCTAssertEqual(opaqueColor.components, [0.5625, 0.75, 0.375, 1])
        XCTAssertEqual(alphaColor.components, [0.5625, 0.75, 0.375, 0.25])
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
    }

    func testCreationFromCGColor() throws {
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))

        let hsb = HSB<CGFloat>(cgColor)
        let hsba = HSBA<CGFloat>(cgColor)

        XCTAssertEqual(hsb.hue, 0.25)
        XCTAssertEqual(hsba.hue, 0.25)
        XCTAssertEqual(hsb.saturation, 0.5)
        XCTAssertEqual(hsba.saturation, 0.5)
        XCTAssertEqual(hsb.brightness, 0.75)
        XCTAssertEqual(hsba.brightness, 0.75)
        XCTAssertEqual(hsba.alpha, 0.5)
        XCTAssertNotNil(HSBA<CGFloat>(exactly: cgColor))
        XCTAssertNotNil(HSB<CGFloat>(exactly: cgColor))
        XCTAssertNil(HSB<InexactFloat>(exactly: cgColor))
        XCTAssertNil(HSBA<InexactFloat>(exactly: cgColor))
    }
}
#endif
