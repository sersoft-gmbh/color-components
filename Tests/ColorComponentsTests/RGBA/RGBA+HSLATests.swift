import XCTest
import ColorComponents

final class RGBA_HSLATests: XCTestCase {
    func testCreationFromHSLA() {
        let hsl = HSL<Double>(hue: 0.1, saturation: 0.5, luminance: 0.75)
        let hsla = HSLA<Double>(hsl: hsl, alpha: 0.9)

        let rgb = RGB(hsl: hsl)
        let rgba = RGBA(hsla: hsla)

        XCTAssertEqual(rgb.red, 0.875, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.775, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.625, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsla.alpha)
    }

    func testCreationFromHSLA_WithIntegers() {
        let hsl = HSL<UInt8>(hue: 0xFA, saturation: 0x80, luminance: 0xB0)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFA)

        let rgb = RGB(hsl: hsl)
        let rgba = RGBA(hsla: hsla)

        XCTAssertEqual(rgb.red, 0xD7)
        XCTAssertEqual(rgb.green, 0x88)
        XCTAssertEqual(rgb.blue, 0x91)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsla.alpha)
    }
}
