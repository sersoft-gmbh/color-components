#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import XCTest
import AppKit
import ColorComponents

final class HSBA_AppKitTests: XCTestCase {
    func testNSColorCreation() {
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
    }

    func testCreationFromNSColor() {
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
    }
}
#endif
