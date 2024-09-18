import XCTest
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

final class HSLA_UIKitTests: XCTestCase {
    func testUIColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
        let hsl = HSL<CGFloat>(hue: 0.5, saturation: 0.25, luminance: 0.75)
        let hsla = HSLA(hsl: hsl, alpha: 0.25)

        let opaqueColor = UIColor(hsl)
        let alphaColor = UIColor(hsla)

        var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, hsl.hue)
        XCTAssertEqual(saturation, HSB(hsl: hsl).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(brightness, HSB(hsl: hsl).brightness)
        XCTAssertEqual(alpha, 1)
        (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, hsla.hue)
        XCTAssertEqual(saturation, HSBA(hsla: hsla).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(brightness, HSBA(hsla: hsla).brightness)
        XCTAssertEqual(alpha, hsla.alpha)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromUIColorWithFloatingPoint() throws {
#if canImport(UIKit)
        let hue: CGFloat = 0.5
        let saturation: CGFloat = 0.25
        let brightness: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

        let hsl = HSL<CGFloat>(color)
        let hsla = HSLA<CGFloat>(color)

        XCTAssertEqual(hsl.hue, hue)
        XCTAssertEqual(hsla.hue, hue)
        XCTAssertEqual(hsl.saturation, HSL<CGFloat>(hsb: HSB(color)).saturation)
        XCTAssertEqual(hsla.saturation, HSLA<CGFloat>(hsba: HSBA(color)).saturation)
        XCTAssertEqual(hsl.luminance, HSL(hsb: HSB(color)).luminance)
        XCTAssertEqual(hsla.luminance, HSLA(hsba: HSBA(color)).luminance)
        XCTAssertEqual(hsla.alpha, alpha)
        XCTAssertNil(HSL<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSL<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSL<InexactFloat>(exactly: color))
        XCTAssertNil(HSL<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testUIColorCreationWithInteger() throws {
#if canImport(UIKit)
        let hsl = HSL<UInt8>(hue: 0x80, saturation: 0x40, luminance: 0xB0)
        let hsla = HSLA(hsl: hsl, alpha: 0x40)

        let opaqueColor = UIColor(hsl)
        let alphaColor = UIColor(hsla)

        var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, .init(hsl.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(saturation, HSB<CGFloat>(hsl: HSL(hsl)).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(brightness, HSB<CGFloat>(hsl: HSL(hsl)).brightness, accuracy: .ulpOfOne)
        XCTAssertEqual(alpha, 1)
        (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, .init(hsla.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(saturation, HSBA<CGFloat>(hsla: HSLA(hsla)).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(brightness, HSBA<CGFloat>(hsla: HSLA(hsla)).brightness, accuracy: .ulpOfOne)
        XCTAssertEqual(alpha, .init(hsla.alpha) / 0xFF, accuracy: .ulpOfOne)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromUIColorWithInteger() throws {
#if canImport(UIKit)
        let hue: CGFloat = 0.5
        let saturation: CGFloat = 0.25
        let brightness: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

        let hsl = HSL<UInt8>(color)
        let hsla = HSLA<UInt8>(color)

        XCTAssertEqual(hsl.hue, .init(hue * 0xFF))
        XCTAssertEqual(hsla.hue, .init(hue * 0xFF))
        XCTAssertEqual(hsl.saturation, HSL<UInt8>(hsb: HSB(color)).saturation, accuracy: 1)
        XCTAssertEqual(hsla.saturation, HSLA<UInt8>(hsba: HSBA(color)).saturation, accuracy: 1)
        XCTAssertEqual(hsl.luminance, HSL(hsb: HSB(color)).luminance)
        XCTAssertEqual(hsla.luminance, HSLA(hsba: HSBA(color)).luminance)
        XCTAssertEqual(hsla.alpha, .init(alpha * 0xFF))
        XCTAssertNil(HSL<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSL<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSL<Int8>(exactly: color))
        XCTAssertNil(HSL<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
