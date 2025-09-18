import Testing
import Numerics
import ColorComponents

extension HSLATests {
    @Suite
    struct RGBATests {
        @Test
        func creationFromFloatingPointRGBA() {
            let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let hsl = HSL(rgb: rgb)
            let hsla = HSLA(rgba: rgba)

            #expect(hsl.hue.isApproximatelyEqual(to: 20 / 360, absoluteTolerance: .ulpOfOne)) // 20 deg
            #expect(hsl.saturation.isApproximatelyEqual(to: 0.6, absoluteTolerance: .ulpOfOne))
            #expect(hsl.brightness.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsla.hsl == hsl)
            #expect(hsla.alpha == rgba.alpha)
        }

        @Test
        func creationFromIntegerRGBA() {
            let rgb = RGB<UInt8>(red: 0x10, green: 0x20, blue: 0x30)
            let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

            let hsl = HSL(rgb: rgb)
            let hsla = HSLA(rgba: rgba)

            #expect(hsl.hue == 148)
            #expect(hsl.saturation == 127)
            #expect(hsl.luminance == 32)
            #expect(hsla.hsl == hsl)
            #expect(hsla.alpha == rgba.alpha)
        }
    }
}
