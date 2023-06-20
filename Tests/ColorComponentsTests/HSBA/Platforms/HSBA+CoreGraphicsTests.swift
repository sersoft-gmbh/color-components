import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

final class HSBA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
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
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
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
#else
        try skipUnavailableAPI()
#endif
    }

    func testCGColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsb = HSB<UInt8>(hue: 0x40, saturation: 0x80, brightness: 0xB0)
        let hsba = HSBA(hsb: hsb, alpha: 0x40)

        let opaqueColor = hsb.cgColor
        let alphaColor = hsba.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0x40 / 0xFF)
        XCTAssertEqual(opaqueColor.components, HSB<CGFloat>(hsb).cgColor.components)
        XCTAssertEqual(alphaColor.components, HSBA<CGFloat>(hsba).cgColor.components)
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))

        let hsb = HSB<UInt8>(cgColor)
        let hsba = HSBA<UInt8>(cgColor)

        XCTAssertEqual(hsb.hue, .init(0.25 * 0xFF))
        XCTAssertEqual(hsba.hue, .init(0.25 * 0xFF))
        XCTAssertEqual(hsb.saturation, .init(0.505 * 0xFF))
        XCTAssertEqual(hsba.saturation, .init(0.505 * 0xFF))
        XCTAssertEqual(hsb.brightness, .init(0.75 * 0xFF))
        XCTAssertEqual(hsba.brightness, .init(0.75 * 0xFF))
        XCTAssertEqual(hsba.alpha, .init(0.5 * 0xFF))
        XCTAssertNotNil(try HSB<UInt8>(exactly: XCTUnwrap(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))))
        XCTAssertNotNil(try HSBA<UInt8>(exactly: XCTUnwrap(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))))
        XCTAssertNil(HSB<Int8>(exactly: cgColor))
        XCTAssertNil(HSBA<Int8>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }
}
