import XCTest
import ColorComponents

final class HSLA_HSBATests: XCTestCase {
    func testCreationFromHSBA() {
        let hsb = HSB<Double>(hue: 0.1, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let hsl = HSL(hsb: hsb)
        let hsla = HSLA(hsba: hsba)

        XCTAssertEqual(hsl.hue, 0.1, accuracy: .ulpOfOne)
        XCTAssertEqual(hsl.saturation, 0.42857142857142855, accuracy: .ulpOfOne)
        XCTAssertEqual(hsl.luminance, 0.5625, accuracy: .ulpOfOne)
        XCTAssertEqual(hsla.hsl, hsl)
        XCTAssertEqual(hsla.alpha, hsba.alpha)
    }

    func testCreationFromHSBA_WithIntegers() {
        let hsb = HSB<UInt8>(hue: 0xFA, saturation: 0x80, brightness: 0xB0)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFA)

        let hsl = HSL(hsb: hsb)
        let hsla = HSLA(hsba: hsba)

        XCTAssertEqual(hsl.hue, 0xFA)
        XCTAssertEqual(hsl.saturation, 0x5B)
        XCTAssertEqual(hsl.luminance, 0x83)
        XCTAssertEqual(hsla.hsl, hsl)
        XCTAssertEqual(hsla.alpha, hsba.alpha)
    }
}
