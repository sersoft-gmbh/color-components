import XCTest
import ColorComponents

final class HSBA_RGBATests: XCTestCase {
    func testCreationFromRGBA_RedMax() {
        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let hsb = HSB(rgb: rgb)
        let hsba = HSBA(rgba: rgba)

        XCTAssertEqual(hsb.hue, 20 / 360, accuracy: .ulpOfOne) // 20 deg
        XCTAssertEqual(hsb.saturation, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.brightness, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, rgba.alpha)
    }

    func testCreationFromRGBA_GreenMax() {
        let rgb = RGB<Double>(red: 0.25, green: 0.5, blue: 0.125)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let hsb = HSB(rgb: rgb)
        let hsba = HSBA(rgba: rgba)

        XCTAssertEqual(hsb.hue, 100 / 360, accuracy: .ulpOfOne) // 100 deg
        XCTAssertEqual(hsb.saturation, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.brightness, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, rgba.alpha)
    }

    func testCreationFromRGBA_BlueMax() {
        let rgb = RGB<Double>(red: 0.25, green: 0.125, blue: 0.5)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let hsb = HSB(rgb: rgb)
        let hsba = HSBA(rgba: rgba)

        XCTAssertEqual(hsb.hue, 260 / 360, accuracy: .ulpOfOne) // 100 deg
        XCTAssertEqual(hsb.saturation, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.brightness, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, rgba.alpha)
    }

    func testCreationFromRGBA_DeltaZero() {
        let rgb = RGB<Double>(red: 0.5, green: 0.5, blue: 0.5)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let hsb = HSB(rgb: rgb)
        let hsba = HSBA(rgba: rgba)

        XCTAssertEqual(hsb.hue, 0)
        XCTAssertEqual(hsb.saturation, 0)
        XCTAssertEqual(hsb.brightness, 0.5)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, rgba.alpha)
    }

    func testCreationFromRGBA_MaxZero() {
        let rgb = RGB<Double>(red: 0, green: 0, blue: 0)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let hsb = HSB(rgb: rgb)
        let hsba = HSBA(rgba: rgba)

        XCTAssertEqual(hsb.hue, 0)
        XCTAssertEqual(hsb.saturation, 0)
        XCTAssertEqual(hsb.brightness, 0)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.alpha, rgba.alpha)
    }
}
