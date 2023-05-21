import XCTest
import ColorComponents

final class HSLA_RGBATests: XCTestCase {
    func testCreationFromRGBA() {
        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let hsl = HSL(rgb: rgb)
        let hsla = HSLA(rgba: rgba)

        XCTAssertEqual(hsl.hue, 20 / 360, accuracy: .ulpOfOne) // 20 deg
        XCTAssertEqual(hsl.saturation, 0.6, accuracy: .ulpOfOne)
        XCTAssertEqual(hsl.brightness, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsla.hsl, hsl)
        XCTAssertEqual(hsla.alpha, rgba.alpha)
    }

    func testCreationFromRGBAWithIntegers() {
        let rgb = RGB<UInt8>(red: 0x10, green: 0x20, blue: 0x30)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

        let hsl = HSL(rgb: rgb)
        let hsla = HSLA(rgba: rgba)

        XCTAssertEqual(hsl.hue, 148)
        XCTAssertEqual(hsl.saturation, 127)
        XCTAssertEqual(hsl.luminance, 32)
        XCTAssertEqual(hsla.hsl, hsl)
        XCTAssertEqual(hsla.alpha, rgba.alpha)
    }
}
