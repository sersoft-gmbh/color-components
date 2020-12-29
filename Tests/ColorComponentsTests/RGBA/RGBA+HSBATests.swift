import XCTest
import ColorComponents

final class RGBA_HSBATests: XCTestCase {
    func testCreationFromHSBA_FirstPart() {
        let hsb = HSB<Double>(hue: 0.1, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let rgb = RGB(hsb: hsb)
        let rgba = RGBA(hsba: hsba)

        XCTAssertEqual(rgb.red, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.6, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.375, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsba.alpha)
    }

    func testCreationFromHSBA_SecondPart() {
        let hsb = HSB<Double>(hue: 0.3, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let rgb = RGB(hsb: hsb)
        let rgba = RGBA(hsba: hsba)

        XCTAssertEqual(rgb.red, 0.45, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.375, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsba.alpha)
    }

    func testCreationFromHSBA_ThirdPart() {
        let hsb = HSB<Double>(hue: 0.5, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let rgb = RGB(hsb: hsb)
        let rgba = RGBA(hsba: hsba)

        XCTAssertEqual(rgb.red, 0.375, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsba.alpha)
    }

    func testCreationFromHSBA_FourthPart() {
        let hsb = HSB<Double>(hue: 0.6, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let rgb = RGB(hsb: hsb)
        let rgba = RGBA(hsba: hsba)

        XCTAssertEqual(rgb.red, 0.375, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.525, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsba.alpha)
    }

    func testCreationFromHSBA_FifthPart() {
        let hsb = HSB<Double>(hue: 0.7, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let rgb = RGB(hsb: hsb)
        let rgba = RGBA(hsba: hsba)

        XCTAssertEqual(rgb.red, 0.45, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.375, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsba.alpha)
    }

    func testCreationFromHSBA_SixthPart() {
        let hsb = HSB<Double>(hue: 0.9, saturation: 0.5, brightness: 0.75)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

        let rgb = RGB(hsb: hsb)
        let rgba = RGBA(hsba: hsba)

        XCTAssertEqual(rgb.red, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.375, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.6, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, hsba.alpha)
    }
}
