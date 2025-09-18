import Testing
import Numerics
import ColorComponents

extension HSBATests {
    @Suite
    struct HSLATests {
        @Test
        func creationFromFloatingPointHSLA() {
            let hsl = HSL<Double>(hue: 0.1, saturation: 0.5, luminance: 0.75)
            let hsla = HSLA<Double>(hsl: hsl, alpha: 0.9)

            let hsb = HSB(hsl: hsl)
            let hsba = HSBA(hsla: hsla)

            #expect(hsb.hue.isApproximatelyEqual(to: 0.1, absoluteTolerance: .ulpOfOne))
            #expect(hsb.saturation.isApproximatelyEqual(to: 0.2857142857142858, absoluteTolerance: .ulpOfOne))
            #expect(hsb.brightness.isApproximatelyEqual(to: 0.875, absoluteTolerance: .ulpOfOne))
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == hsla.alpha)
        }

        @Test
        func creationFromIntegerHSBA() {
            let hsl = HSL<UInt8>(hue: 0xFA, saturation: 0x80, luminance: 0xB0)
            let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFA)

            let hsb = HSB(hsl: hsl)
            let hsba = HSBA(hsla: hsla)

            #expect(hsb.hue == 0xFA)
            #expect(hsb.saturation == 0x5D)
            #expect(hsb.brightness == 0xD7)
            #expect(hsba.hsb == hsb)
            #expect(hsba.alpha == hsla.alpha)
        }
    }
}
