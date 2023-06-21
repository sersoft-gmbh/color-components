import XCTest
@testable import ColorComponents

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

    func testPlaygroundDescription() throws {
        let fltRGB = RGB<Double>(red: 0.5, green: 0.1, blue: 0.3)
        let fltRGBA = RGBA<Double>(rgb: fltRGB, alpha: 0.85)
        let intRGB = RGB<UInt8>(red: 0x98, green: 0x74, blue: 0x32)
        let intRGBA = RGBA<UInt8>(rgb: intRGB, alpha: 0xFA)

        let dummyRGB = RGB<DummyNumeric>(red: 1, green: 2, blue: 3)
        let dummyRGBA = RGBA<DummyNumeric>(rgb: dummyRGB, alpha: 0xFF)

        let fltOpaqueDesc = fltRGB.playgroundDescription
        let fltAlphaDesc = fltRGBA.playgroundDescription
        let intOpaqueDesc = intRGB.playgroundDescription
        let intAlphaDesc = intRGBA.playgroundDescription
        let dummyOpaqueDesc = dummyRGB.playgroundDescription
        let dummyAlphaDesc = dummyRGBA.playgroundDescription

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertEqual(fltOpaqueDesc as? _PlaygroundColor, fltRGB._playgroundColor)
        XCTAssertEqual(fltAlphaDesc as? _PlaygroundColor, fltRGBA._playgroundColor)
        XCTAssertEqual(intOpaqueDesc as? _PlaygroundColor, intRGB._playgroundColor)
        XCTAssertEqual(intAlphaDesc as? _PlaygroundColor, intRGBA._playgroundColor)
#else
        XCTAssertEqual(fltOpaqueDesc as? String, String(describing: fltRGB))
        XCTAssertEqual(fltAlphaDesc as? String, String(describing: fltRGBA))
        XCTAssertEqual(intOpaqueDesc as? String, String(describing: intRGB))
        XCTAssertEqual(intAlphaDesc as? String, String(describing: intRGBA))
#endif
        XCTAssertEqual(dummyOpaqueDesc as? String, String(describing: dummyRGB))
        XCTAssertEqual(dummyAlphaDesc as? String, String(describing: dummyRGBA))
    }
}
