import XCTest
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

final class HSLA_AppKitTests: XCTestCase {
    func testNSColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let hsl = HSL<CGFloat>(hue: 0.25, saturation: 0.5, luminance: 0.75)
        let hsla = HSLA(hsl: hsl, alpha: 0.25)

        let opaqueColor = NSColor(hsl)
        let alphaColor = NSColor(hsla)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, hsla.alpha)
        XCTAssertEqual(opaqueColor.hueComponent, hsl.hue, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.hueComponent, hsla.hue, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.saturationComponent, HSB(hsl: hsl).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.saturationComponent, HSBA(hsla: hsla).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.brightnessComponent, hsl.brightness)
        XCTAssertEqual(alphaColor.brightnessComponent, hsla.brightness)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color: NSColor
        if #available(macOS 10.12, *) {
            color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
        } else {
            color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
        }

        let hsl = HSL<CGFloat>(color)
        let hsla = HSLA<CGFloat>(color)

        XCTAssertEqual(hsl.hue, color.hueComponent)
        XCTAssertEqual(hsla.hue, color.hueComponent)
        XCTAssertEqual(hsl.saturation, HSL<CGFloat>(hsb: HSB(color)).saturation)
        XCTAssertEqual(hsla.saturation, HSLA<CGFloat>(hsba: HSBA(color)).saturation)
        XCTAssertEqual(hsl.brightness, color.brightnessComponent)
        XCTAssertEqual(hsla.brightness, color.brightnessComponent)
        XCTAssertEqual(hsla.alpha, color.alphaComponent)
        XCTAssertNil(HSL<InexactFloat>(exactly: color))
        XCTAssertNil(HSLA<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testNSColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let hsl = HSL<UInt8>(hue: 0x40, saturation: 0x80, luminance: 0xB0)
        let hsla = HSLA(hsl: hsl, alpha: 0x40)

        let opaqueColor = NSColor(hsl)
        let alphaColor = NSColor(hsla)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, .init(hsla.alpha) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.hueComponent, .init(hsl.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.hueComponent, .init(hsla.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.saturationComponent, HSB<CGFloat>(opaqueColor).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.saturationComponent, HSBA<CGFloat>(alphaColor).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.brightnessComponent, HSB<CGFloat>(opaqueColor).brightness, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.brightnessComponent, HSBA<CGFloat>(alphaColor).brightness, accuracy: .ulpOfOne)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color: NSColor
        if #available(macOS 10.12, *) {
            color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
        } else {
            color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
        }

        let hsl = HSL<UInt8>(color)
        let hsla = HSLA<UInt8>(color)

        XCTAssertEqual(hsl.hue, .init(color.hueComponent * 0xFF))
        XCTAssertEqual(hsla.hue, .init(color.hueComponent * 0xFF))
        XCTAssertEqual(hsl.saturation, HSL<UInt8>(hsb: HSB(color)).saturation, accuracy: 1)
        XCTAssertEqual(hsla.saturation, HSLA<UInt8>(hsba: HSBA(color)).saturation, accuracy: 1)
        XCTAssertEqual(hsl.luminance, HSL(hsb: HSB(color)).luminance)
        XCTAssertEqual(hsla.luminance, HSLA(hsba: HSBA(color)).luminance)
        XCTAssertEqual(hsla.alpha, .init(color.alphaComponent * 0xFF))
        XCTAssertNil(HSL<Int8>(exactly: color))
        XCTAssertNil(HSLA<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
