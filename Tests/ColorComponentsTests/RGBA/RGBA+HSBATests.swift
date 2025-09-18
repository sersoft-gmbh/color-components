import Testing
import Numerics
import ColorComponents

extension RGBATests {
    @Suite
    struct HSBATests {
        @Test
        func creationFromHSBA_FirstPart() {
            let hsb = HSB<Double>(hue: 0.1, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.6, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.375, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }

        @Test
        func creationFromHSBA_SecondPart() {
            let hsb = HSB<Double>(hue: 0.3, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red.isApproximatelyEqual(to: 0.45, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.375, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }

        @Test
        func creationFromHSBA_ThirdPart() {
            let hsb = HSB<Double>(hue: 0.5, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red.isApproximatelyEqual(to: 0.375, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }

        @Test
        func creationFromHSBA_FourthPart() {
            let hsb = HSB<Double>(hue: 0.6, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red.isApproximatelyEqual(to: 0.375, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.525, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }

        @Test
        func creationFromHSBA_FifthPart() {
            let hsb = HSB<Double>(hue: 0.7, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red.isApproximatelyEqual(to: 0.45, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.375, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }

        @Test
        func creationFromHSBA_SixthPart() {
            let hsb = HSB<Double>(hue: 0.9, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA<Double>(hsb: hsb, alpha: 0.9)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.375, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.6, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }

        @Test
        func creationFromHSBA_WithIntegers() {
            let hsb = HSB<UInt8>(hue: 0xFA, saturation: 0x80, brightness: 0xB0)
            let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFA)

            let rgb = RGB(hsb: hsb)
            let rgba = RGBA(hsba: hsba)

            #expect(rgb.red == 0xB0)
            #expect(rgb.green == 0x57)
            #expect(rgb.blue == 0x62)
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == hsba.alpha)
        }
    }
}
