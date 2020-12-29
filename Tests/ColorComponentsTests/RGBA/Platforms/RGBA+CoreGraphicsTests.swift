#if canImport(CoreGraphics)
import XCTest
import CoreGraphics
import ColorComponents

final class RGBA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreation() throws {
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let rgb = RGB<CGFloat>(red: 0.25, green: 0.5, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        let opaqueColor = rgb.cgColor
        let alphaColor = rgba.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0.25)
        XCTAssertEqual(opaqueColor.components, [0.25, 0.5, 0.75, 1])
        XCTAssertEqual(alphaColor.components, [0.25, 0.5, 0.75, 0.25])
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
    }

    func testCreationFromCGColor() throws {
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.25, 0.5, 0.75, 0.5]))

        let rgb = RGB<CGFloat>(cgColor)
        let rgba = RGBA<CGFloat>(cgColor)

        XCTAssertEqual(rgb.red, 0.25)
        XCTAssertEqual(rgba.red, 0.25)
        XCTAssertEqual(rgb.green, 0.5)
        XCTAssertEqual(rgba.green, 0.5)
        XCTAssertEqual(rgb.blue, 0.75)
        XCTAssertEqual(rgba.blue, 0.75)
        XCTAssertEqual(rgba.alpha, 0.5)
        XCTAssertNotNil(RGBA<CGFloat>(exactly: cgColor))
        XCTAssertNotNil(RGB<CGFloat>(exactly: cgColor))
        XCTAssertNil(RGB<InexactFloat>(exactly: cgColor))
        XCTAssertNil(RGBA<InexactFloat>(exactly: cgColor))
    }

    func testCreationFromCGColorConvertingColorSpaces() throws {
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.25, 0.5]))

        let rgb = RGB<CGFloat>(cgColor)
        let rgba = RGBA<CGFloat>(cgColor)

        XCTAssertEqual(rgb.red, 0.25)
        XCTAssertEqual(rgba.red, 0.25)
        XCTAssertEqual(rgb.green, 0.25)
        XCTAssertEqual(rgba.green, 0.25)
        XCTAssertEqual(rgb.blue, 0.25)
        XCTAssertEqual(rgba.blue, 0.25)
        XCTAssertEqual(rgba.alpha, 0.5)
    }
}
#endif
