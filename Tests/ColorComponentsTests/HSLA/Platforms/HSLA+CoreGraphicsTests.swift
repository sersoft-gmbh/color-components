import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

final class HSLA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsl = HSL<CGFloat>(hue: 0.25, saturation: 0.5, luminance: 0.75)
        let hsla = HSLA(hsl: hsl, alpha: 0.25)

        let opaqueColor = hsl.cgColor
        let alphaColor = hsla.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0.25)
        XCTAssertEqual(opaqueColor.components, [0.75, 0.875, 0.625, 1])
        XCTAssertEqual(alphaColor.components, [0.75, 0.875, 0.625, 0.25])
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

        let hsl = HSL<CGFloat>(cgColor)
        let hsla = HSLA<CGFloat>(cgColor)

        XCTAssertEqual(hsl.hue, 0.25)
        XCTAssertEqual(hsla.hue, 0.25)
        XCTAssertEqual(hsl.saturation, HSL<CGFloat>(rgb: RGB(cgColor)).saturation)
        XCTAssertEqual(hsla.saturation, HSLA<CGFloat>(rgba: RGBA(cgColor)).saturation)
        XCTAssertEqual(hsl.brightness, 0.75)
        XCTAssertEqual(hsla.brightness, 0.75)
        XCTAssertEqual(hsla.alpha, 0.5)
        XCTAssertNotNil(HSLA<CGFloat>(exactly: cgColor))
        XCTAssertNotNil(HSL<CGFloat>(exactly: cgColor))
        XCTAssertNil(HSL<InexactFloat>(exactly: cgColor))
        XCTAssertNil(HSLA<InexactFloat>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCGColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsl = HSL<UInt8>(hue: 0x40, saturation: 0x80, luminance: 0xB0)
        let hsla = HSLA(hsl: hsl, alpha: 0x40)

        let opaqueColor = hsl.cgColor
        let alphaColor = hsla.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0x40 / 0xFF)
        XCTAssertEqual(opaqueColor.components, HSL<CGFloat>(hsl).cgColor.components)
        XCTAssertEqual(alphaColor.components, HSLA<CGFloat>(hsla).cgColor.components)
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

        let hsl = HSL<UInt8>(cgColor)
        let hsla = HSLA<UInt8>(cgColor)

        XCTAssertEqual(hsl.hue, .init(0.25 * 0xFF))
        XCTAssertEqual(hsla.hue, .init(0.25 * 0xFF))
        XCTAssertEqual(hsl.saturation, HSL<UInt8>(rgb: RGB(cgColor)).saturation)
        XCTAssertEqual(hsla.saturation, HSLA<UInt8>(rgba: RGBA(cgColor)).saturation)
        XCTAssertEqual(hsl.luminance, HSL(rgb: RGB(cgColor)).luminance)
        XCTAssertEqual(hsla.luminance, HSLA(rgba: RGBA(cgColor)).luminance)
        XCTAssertEqual(hsla.alpha, .init(0.5 * 0xFF))
        XCTAssertNotNil(try HSL<UInt8>(exactly: XCTUnwrap(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))))
        XCTAssertNotNil(try HSLA<UInt8>(exactly: XCTUnwrap(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))))
        XCTAssertNil(HSL<Int8>(exactly: cgColor))
        XCTAssertNil(HSLA<Int8>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }
}
