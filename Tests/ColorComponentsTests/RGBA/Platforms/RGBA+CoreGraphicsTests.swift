import XCTest
import XCHelpers
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

final class RGBA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
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
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
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
#else
        try skipUnavailableAPI()
#endif
    }

    func testCGColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let rgb = RGB<UInt8>(red: 0x40, green: 0x80, blue: 0xB0)
        let rgba = RGBA(rgb: rgb, alpha: 0x40)

        let opaqueColor = rgb.cgColor
        let alphaColor = rgba.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0x40 / 0xFF)
        XCTAssertEqual(opaqueColor.components,
                       [0x40 / 0xFF as CGFloat, 0x80 / 0xFF as CGFloat, 0xB0 / 0xFF as CGFloat, 1])
        XCTAssertEqual(alphaColor.components,
                       [0x40 / 0xFF as CGFloat, 0x80 / 0xFF as CGFloat, 0xB0 / 0xFF as CGFloat, 0x40 / 0xFF as CGFloat])
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
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.25, 0.5, 0.75, 0.5]))

        let rgb = RGB<UInt8>(cgColor)
        let rgba = RGBA<UInt8>(cgColor)

        XCTAssertEqual(rgb.red, .init(0.25 * 0xFF))
        XCTAssertEqual(rgba.red, .init(0.25 * 0xFF))
        XCTAssertEqual(rgb.green, .init(0.5 * 0xFF))
        XCTAssertEqual(rgba.green, .init(0.5 * 0xFF))
        XCTAssertEqual(rgb.blue, .init(0.75 * 0xFF))
        XCTAssertEqual(rgba.blue, .init(0.75 * 0xFF))
        XCTAssertEqual(rgba.alpha, .init(0.5 * 0xFF))
        XCTAssertNil(RGB<Int8>(exactly: cgColor))
        XCTAssertNil(RGBA<Int8>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorConvertingColorSpaces() throws {
#if canImport(CoreGraphics)
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
#else
        try skipUnavailableAPI()
#endif
    }
}
