import Testing
@testable import ColorComponents

@Suite
struct ColorComponentsTests {
    @Test
    func clearColorCheck() {
        let bw = BW<UInt8>(white: 0x50)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0)

        let rgb = RGB<Double>(red: 0.5, green: 0.1, blue: 0.3)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0)
        let rgba2 = RGBA<Double>(rgb: rgb, alpha: 0.5)

        let hsb = HSB<Int>(hue: 0xFC, saturation: 0x5A, brightness: 0x3E)
        let hsba = HSBA<Int>(hsb: hsb, alpha: 0x23)

        #expect(bwa.isClearColor)
        #expect(rgba.isClearColor)
        #expect(!hsba.isClearColor)
        #expect(!rgba2.isClearColor)
    }

    @Test
    func brightColorCheck() {
        let bw = BW<Double>(white: 0.5)
        let bwa = BWA<Double>(bw: bw, alpha: 0)

        let rgb = RGB<Double>(red: 0.5, green: 0.1, blue: 0.3)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0)

        let hsb = HSB<Double>(hue: 0.75, saturation: 0.5, brightness: 0.25)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 1 / 3)

        #expect(!bw.isDarkColor)
        #expect(!bwa.isDarkColor)
        #expect(bw.isBrightColor)
        #expect(bwa.isBrightColor)
        #expect(rgb.isDarkColor)
        #expect(rgba.isDarkColor)
        #expect(!rgb.isBrightColor)
        #expect(!rgba.isBrightColor)
        #expect(hsb.isDarkColor)
        #expect(hsba.isDarkColor)
        #expect(!hsb.isBrightColor)
        #expect(!hsba.isBrightColor)
    }

    @Test
    func playgroundDescription() throws {
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
        #expect(fltOpaqueDesc as? _PlaygroundColor == fltRGB._playgroundColor)
        #expect(fltAlphaDesc as? _PlaygroundColor == fltRGBA._playgroundColor)
        #expect(intOpaqueDesc as? _PlaygroundColor == intRGB._playgroundColor)
        #expect(intAlphaDesc as? _PlaygroundColor == intRGBA._playgroundColor)
#else
        #expect(fltOpaqueDesc as? String == String(describing: fltRGB))
        #expect(fltAlphaDesc as? String == String(describing: fltRGBA))
        #expect(intOpaqueDesc as? String == String(describing: intRGB))
        #expect(intAlphaDesc as? String == String(describing: intRGBA))
#endif
        #expect(dummyOpaqueDesc as? String == String(describing: dummyRGB))
        #expect(dummyAlphaDesc as? String == String(describing: dummyRGBA))
    }
}
