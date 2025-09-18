import Testing
import Numerics
import ColorComponents

extension RGBATests {
    @Suite
    struct HSLATests {
        @Test
        func creationFromFloatingPointHSLA() {
            let hsl = HSL<Double>(hue: 0.1, saturation: 0.5, luminance: 0.75)
            let hsla = HSLA<Double>(hsl: hsl, alpha: 0.9)

            let rgb = RGB(hsl: hsl)
            let rgba = RGBA(hsla: hsla)

            #expect(rgb.red.isApproximatelyEqual(to: 0.875, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.775, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.625, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsla.alpha)
        }

        @Test
        func creationFromIntegerHSLA() {
            let hsl = HSL<UInt8>(hue: 0xFA, saturation: 0x80, luminance: 0xB0)
            let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFA)

            let rgb = RGB(hsl: hsl)
            let rgba = RGBA(hsla: hsla)

            #expect(rgb.red == 0xD7)
            #expect(rgb.green == 0x88)
            #expect(rgb.blue == 0x91)
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsla.alpha)
        }
    }
}
