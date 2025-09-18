import Testing
import Numerics
import ColorComponents

extension HSLATests {
    @Suite
    struct HSBATests {
        @Test
        func creationFromFloatingPointHSBA() {
            let hsb = HSB<Double>(hue: 0.1, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let hsl = HSL(hsb: hsb)
            let hsla = HSLA(hsba: hsba)

            #expect(hsl.hue.isApproximatelyEqual(to: 0.1, absoluteTolerance: .ulpOfOne))
            #expect(hsl.saturation.isApproximatelyEqual(to: 0.42857142857142855, absoluteTolerance: .ulpOfOne))
            #expect(hsl.luminance.isApproximatelyEqual(to: 0.5625, absoluteTolerance: .ulpOfOne))
            #expect(hsla.hsl == hsl)
            #expect(hsla.alpha == hsba.alpha)
        }

        @Test
        func creationFromIntegerHSBA() {
            let hsb = HSB<UInt8>(hue: 0xFA, saturation: 0x80, brightness: 0xB0)
            let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFA)

            let hsl = HSL(hsb: hsb)
            let hsla = HSLA(hsba: hsba)

            #expect(hsl.hue == 0xFA)
            #expect(hsl.saturation == 0x5B)
            #expect(hsl.luminance == 0x83)
            #expect(hsla.hsl == hsl)
            #expect(hsla.alpha == hsba.alpha)
        }
    }
}
