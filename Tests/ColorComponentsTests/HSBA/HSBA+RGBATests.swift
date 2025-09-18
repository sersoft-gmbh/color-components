import Testing
import Numerics
import ColorComponents

extension HSBATests {
    @Suite
    struct RGBATests {
        @Test
        func creationFromFloatingPointRGBAWithRedMax() {
            let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let hsb = HSB(rgb: rgb)
            let hsba = HSBA(rgba: rgba)

            #expect(hsb.hue.isApproximatelyEqual(to: 20 / 360, absoluteTolerance: .ulpOfOne)) // 20 deg
            #expect(hsb.saturation.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsb.brightness.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == rgba.alpha)
        }

        @Test
        func creationFromFloatingPointRGBAWithGreenMax() {
            let rgb = RGB<Double>(red: 0.25, green: 0.5, blue: 0.125)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let hsb = HSB(rgb: rgb)
            let hsba = HSBA(rgba: rgba)

            #expect(hsb.hue.isApproximatelyEqual(to: 100 / 360, absoluteTolerance: .ulpOfOne)) // 100 deg
            #expect(hsb.saturation.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsb.brightness.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == rgba.alpha)
        }

        @Test
        func creationFromFloatingPointRGBAWithBlueMax() {
            let rgb = RGB<Double>(red: 0.25, green: 0.125, blue: 0.5)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let hsb = HSB(rgb: rgb)
            let hsba = HSBA(rgba: rgba)

            #expect(hsb.hue.isApproximatelyEqual(to: 260 / 360, absoluteTolerance: .ulpOfOne)) // 100 deg
            #expect(hsb.saturation.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsb.brightness.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == rgba.alpha)
        }

        @Test
        func creationFromFloatingPointRGBAWithDeltaZero() {
            let rgb = RGB<Double>(red: 0.5, green: 0.5, blue: 0.5)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let hsb = HSB(rgb: rgb)
            let hsba = HSBA(rgba: rgba)

            #expect(hsb.hue == 0)
            #expect(hsb.saturation == 0)
            #expect(hsb.brightness == 0.5)
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == rgba.alpha)
        }

        @Test
        func creationFromFloatingPointRGBAWithMaxZero() {
            let rgb = RGB<Double>(red: 0, green: 0, blue: 0)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let hsb = HSB(rgb: rgb)
            let hsba = HSBA(rgba: rgba)

            #expect(hsb.hue == 0)
            #expect(hsb.saturation == 0)
            #expect(hsb.brightness == 0)
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == rgba.alpha)
        }

        @Test
        func creationFromIntegerRGBA() {
            let rgb = RGB<UInt8>(red: 0x10, green: 0x20, blue: 0x30)
            let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

            let hsb = HSB(rgb: rgb)
            let hsba = HSBA(rgba: rgba)

            #expect(hsb.hue == 148)
            #expect(hsb.saturation == 170)
            #expect(hsb.brightness == 48)
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == rgba.alpha)
        }
    }
}
