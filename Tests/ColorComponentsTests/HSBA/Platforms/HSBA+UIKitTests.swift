import XCTest
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

final class HSBA_UIKitTests: XCTestCase {
    func testUIColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
        let hsb = HSB<CGFloat>(hue: 0.5, saturation: 0.25, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        let opaqueColor = UIColor(hsb)
        let alphaColor = UIColor(hsba)

        var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, hsb.hue)
        XCTAssertEqual(saturation, hsb.saturation)
        XCTAssertEqual(brightness, hsb.brightness)
        XCTAssertEqual(alpha, 1)
        (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, hsba.hue)
        XCTAssertEqual(saturation, hsba.saturation)
        XCTAssertEqual(brightness, hsba.brightness)
        XCTAssertEqual(alpha, hsba.alpha)
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

        let hsb = HSB<CGFloat>(color)
        let hsba = HSBA<CGFloat>(color)

        XCTAssertEqual(hsb.hue, hue)
        XCTAssertEqual(hsba.hue, hue)
        XCTAssertEqual(hsb.saturation, saturation)
        XCTAssertEqual(hsba.saturation, saturation)
        XCTAssertEqual(hsb.brightness, brightness)
        XCTAssertEqual(hsba.brightness, brightness)
        XCTAssertEqual(hsba.alpha, alpha)
        XCTAssertNil(HSB<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSB<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSB<InexactFloat>(exactly: color))
        XCTAssertNil(HSB<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testUIColorCreationWithInteger() throws {
#if canImport(UIKit)
        let hsb = HSB<UInt8>(hue: 0x80, saturation: 0x40, brightness: 0xB0)
        let hsba = HSBA(hsb: hsb, alpha: 0x40)

        let opaqueColor = UIColor(hsb)
        let alphaColor = UIColor(hsba)

        var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, .init(hsb.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(saturation, .init(hsb.saturation) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(brightness, .init(hsb.brightness) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(alpha, 1)
        (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, .init(hsba.hue) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(saturation, .init(hsba.saturation) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(brightness, .init(hsba.brightness) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(alpha, .init(hsba.alpha) / 0xFF, accuracy: .ulpOfOne)
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

        let hsb = HSB<UInt8>(color)
        let hsba = HSBA<UInt8>(color)

        XCTAssertEqual(hsb.hue, .init(hue * 0xFF))
        XCTAssertEqual(hsba.hue, .init(hue * 0xFF))
        XCTAssertEqual(hsb.saturation, .init(saturation * 0xFF))
        XCTAssertEqual(hsba.saturation, .init(saturation * 0xFF))
        XCTAssertEqual(hsb.brightness, .init(brightness * 0xFF))
        XCTAssertEqual(hsba.brightness, .init(brightness * 0xFF))
        XCTAssertEqual(hsba.alpha, .init(alpha * 0xFF))
        XCTAssertNil(HSB<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSB<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSB<Int8>(exactly: color))
        XCTAssertNil(HSB<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
