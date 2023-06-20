import XCTest
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

final class RGBA_AppKitTests: XCTestCase {
    func testNSColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let rgb = RGB<CGFloat>(red: 0.25, green: 0.5, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        let opaqueColor = NSColor(rgb)
        let alphaColor = NSColor(rgba)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, rgba.alpha)
        XCTAssertEqual(opaqueColor.redComponent, rgb.red)
        XCTAssertEqual(alphaColor.redComponent, rgba.red)
        XCTAssertEqual(opaqueColor.greenComponent, rgb.green)
        XCTAssertEqual(alphaColor.greenComponent, rgba.green)
        XCTAssertEqual(opaqueColor.blueComponent, rgb.blue)
        XCTAssertEqual(alphaColor.blueComponent, rgba.blue)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)

        let rgb = RGB<CGFloat>(color)
        let rgba = RGBA<CGFloat>(color)

        XCTAssertEqual(rgb.red, color.redComponent)
        XCTAssertEqual(rgba.red, color.redComponent)
        XCTAssertEqual(rgb.green, color.greenComponent)
        XCTAssertEqual(rgba.green, color.greenComponent)
        XCTAssertEqual(rgb.blue, color.blueComponent)
        XCTAssertEqual(rgba.blue, color.blueComponent)
        XCTAssertEqual(rgba.alpha, color.alphaComponent)
        XCTAssertNil(RGB<InexactFloat>(exactly: color))
        XCTAssertNil(RGBA<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testNSColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let rgb = RGB<UInt8>(red: 0x40, green: 0x80, blue: 0xB0)
        let rgba = RGBA(rgb: rgb, alpha: 0x40)

        let opaqueColor = NSColor(rgb)
        let alphaColor = NSColor(rgba)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, .init(rgba.alpha) / 0xFF)
        XCTAssertEqual(opaqueColor.redComponent, .init(rgb.red) / 0xFF)
        XCTAssertEqual(alphaColor.redComponent, .init(rgba.red) / 0xFF)
        XCTAssertEqual(opaqueColor.greenComponent, .init(rgb.green) / 0xFF)
        XCTAssertEqual(alphaColor.greenComponent, .init(rgba.green) / 0xFF)
        XCTAssertEqual(opaqueColor.blueComponent, .init(rgb.blue) / 0xFF)
        XCTAssertEqual(alphaColor.blueComponent, .init(rgba.blue) / 0xFF)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)

        let rgb = RGB<UInt8>(color)
        let rgba = RGBA<UInt8>(color)

        XCTAssertEqual(rgb.red, .init(color.redComponent * 0xFF))
        XCTAssertEqual(rgba.red, .init(color.redComponent * 0xFF))
        XCTAssertEqual(rgb.green, .init(color.greenComponent * 0xFF))
        XCTAssertEqual(rgba.green, .init(color.greenComponent * 0xFF))
        XCTAssertEqual(rgb.blue, .init(color.blueComponent * 0xFF))
        XCTAssertEqual(rgba.blue, .init(color.blueComponent * 0xFF))
        XCTAssertEqual(rgba.alpha, .init(color.alphaComponent * 0xFF))
        XCTAssertNil(RGB<Int8>(exactly: color))
        XCTAssertNil(RGBA<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
