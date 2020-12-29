import XCTest
import ColorComponents

final class ColorComponentsTests: XCTestCase {
    func testClearColorCheck() {
        let bw = BW<UInt8>(white: 0x50)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0)

        let rgb = RGB<Double>(red: 0.5, green: 0.1, blue: 0.3)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0)
        let rgba2 = RGBA<Double>(rgb: rgb, alpha: 0.5)

        let hsb = HSB<Int>(hue: 0xFC, saturation: 0x5A, brightness: 0x3E)
        let hsba = HSBA<Int>(hsb: hsb, alpha: 0x23)

        XCTAssertTrue(bwa.isClearColor)
        XCTAssertTrue(rgba.isClearColor)
        XCTAssertFalse(hsba.isClearColor)
        XCTAssertFalse(rgba2.isClearColor)
    }

    func testBrightColorCheck() {
        let bw = BW<Double>(white: 0.5)
        let bwa = BWA<Double>(bw: bw, alpha: 0)

        let rgb = RGB<Double>(red: 0.5, green: 0.1, blue: 0.3)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0)

        let hsb = HSB<Double>(hue: 0.75, saturation: 0.5, brightness: 0.25)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 1 / 3)

        XCTAssertFalse(bw.isDarkColor)
        XCTAssertFalse(bwa.isDarkColor)
        XCTAssertTrue(bw.isBrightColor)
        XCTAssertTrue(bwa.isBrightColor)
        XCTAssertTrue(rgb.isDarkColor)
        XCTAssertTrue(rgba.isDarkColor)
        XCTAssertFalse(rgb.isBrightColor)
        XCTAssertFalse(rgba.isBrightColor)
        XCTAssertTrue(hsb.isDarkColor)
        XCTAssertTrue(hsba.isDarkColor)
        XCTAssertFalse(hsb.isBrightColor)
        XCTAssertFalse(hsba.isBrightColor)
    }
}
