import XCTest
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

final class HSBA_AppKitTests: XCTestCase {
    func testNSColorCreationWithFloatingPoint() throws {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let hsb = HSB<CGFloat>(hue: 0.25, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        let opaqueColor = NSColor(hsb)
        let alphaColor = NSColor(hsba)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, hsba.alpha)
        XCTAssertEqual(opaqueColor.hueComponent, hsb.hue)
        XCTAssertEqual(alphaColor.hueComponent, hsba.hue)
        XCTAssertEqual(opaqueColor.saturationComponent, hsb.saturation)
        XCTAssertEqual(alphaColor.saturationComponent, hsba.saturation)
        XCTAssertEqual(opaqueColor.brightnessComponent, hsb.brightness)
        XCTAssertEqual(alphaColor.brightnessComponent, hsba.brightness)
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

        let hsb = HSB<CGFloat>(color)
        let hsba = HSBA<CGFloat>(color)

        XCTAssertEqual(hsb.hue, color.hueComponent)
        XCTAssertEqual(hsba.hue, color.hueComponent)
        XCTAssertEqual(hsb.saturation, color.saturationComponent)
        XCTAssertEqual(hsba.saturation, color.saturationComponent)
        XCTAssertEqual(hsb.brightness, color.brightnessComponent)
        XCTAssertEqual(hsba.brightness, color.brightnessComponent)
        XCTAssertEqual(hsba.alpha, color.alphaComponent)
        XCTAssertNil(HSB<InexactFloat>(exactly: color))
        XCTAssertNil(HSBA<InexactFloat>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testNSColorCreationWithInteger() throws {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let hsb = HSB<UInt8>(hue: 0x40, saturation: 0x80, brightness: 0xB0)
        let hsba = HSBA(hsb: hsb, alpha: 0x40)

        let opaqueColor = NSColor(hsb)
        let alphaColor = NSColor(hsba)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, .init(hsba.alpha) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.hueComponent, .init(hsb.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.hueComponent, .init(hsba.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.saturationComponent, .init(hsb.saturation) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.saturationComponent, .init(hsba.saturation) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.brightnessComponent, .init(hsb.brightness) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.brightnessComponent, .init(hsba.brightness) / 0xFF, accuracy: .ulpOfOne)
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

        let hsb = HSB<UInt8>(color)
        let hsba = HSBA<UInt8>(color)

        XCTAssertEqual(hsb.hue, .init(color.hueComponent * 0xFF))
        XCTAssertEqual(hsba.hue, .init(color.hueComponent * 0xFF))
        XCTAssertEqual(hsb.saturation, .init(color.saturationComponent * 0xFF))
        XCTAssertEqual(hsba.saturation, .init(color.saturationComponent * 0xFF))
        XCTAssertEqual(hsb.brightness, .init(color.brightnessComponent * 0xFF))
        XCTAssertEqual(hsba.brightness, .init(color.brightnessComponent * 0xFF))
        XCTAssertEqual(hsba.alpha, .init(color.alphaComponent * 0xFF))
        XCTAssertNil(HSB<Int8>(exactly: color))
        XCTAssertNil(HSBA<Int8>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }
}
