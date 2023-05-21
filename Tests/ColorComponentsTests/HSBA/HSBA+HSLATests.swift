import XCTest
import ColorComponents

final class HSBA_HSLATests: XCTestCase {
    func testCreationFromHSLA() {
        let hsl = HSL<Double>(hue: 0.1, saturation: 0.5, luminance: 0.75)
        let hsla = HSLA<Double>(hsl: hsl, alpha: 0.9)

        let hsb = HSB(hsl: hsl)
        let hsba = HSBA(hsla: hsla)

        XCTAssertEqual(hsb.hue, 0.1, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.saturation, 0.2857142857142858, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.brightness, 0.875, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, hsla.alpha)
    }

    func testCreationFromHSBA_WithIntegers() {
        let hsl = HSL<UInt8>(hue: 0xFA, saturation: 0x80, luminance: 0xB0)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFA)

        let hsb = HSB(hsl: hsl)
        let hsba = HSBA(hsla: hsla)

        XCTAssertEqual(hsb.hue, 0xFA)
        XCTAssertEqual(hsb.saturation, 0x5D)
        XCTAssertEqual(hsb.brightness, 0xD7)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, hsla.alpha)
    }
}
