import Testing
import Numerics
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

extension HSLATests {
    @Suite(.enabled(if: .uiKitAvailable))
    struct UIKitTests {
        @Test
        func uiColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
            let hsl = HSL<CGFloat>(hue: 0.5, saturation: 0.25, luminance: 0.75)
            let hsla = HSLA(hsl: hsl, alpha: 0.25)

            let opaqueColor = UIColor(hsl)
            let alphaColor = UIColor(hsla)

            var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if (compiler(>=6.2))
            #expect(unsafe opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue == hsl.hue)
            #expect(saturation.isApproximatelyEqual(to: HSB(hsl: hsl).saturation, absoluteTolerance: .ulpOfOne))
            #expect(brightness == HSB(hsl: hsl).brightness)
            #expect(alpha == 1)
            (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
#if (compiler(>=6.2))
            #expect(unsafe alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue == hsla.hue)
            #expect(saturation.isApproximatelyEqual(to: HSBA(hsla: hsla).saturation, absoluteTolerance: .ulpOfOne))
            #expect(brightness == HSBA(hsla: hsla).brightness)
            #expect(alpha == hsla.alpha)
#endif
        }

        @Test
        func creationFromUIColorWithFloatingPoint() throws {
#if canImport(UIKit)
            let hue: CGFloat = 0.5
            let saturation: CGFloat = 0.25
            let brightness: CGFloat = 0.75
            let alpha: CGFloat = 0.25
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

            let hsl = HSL<CGFloat>(color)
            let hsla = HSLA<CGFloat>(color)

            #expect(hsl.hue == hue)
            #expect(hsla.hue == hue)
            #expect(hsl.saturation == HSL<CGFloat>(hsb: HSB(color)).saturation)
            #expect(hsla.saturation == HSLA<CGFloat>(hsba: HSBA(color)).saturation)
            #expect(hsl.luminance == HSL(hsb: HSB(color)).luminance)
            #expect(hsla.luminance == HSLA(hsba: HSBA(color)).luminance)
            #expect(hsla.alpha == alpha)
            #expect(HSL<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSL<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSL<InexactFloat>(exactly: color) == nil)
            #expect(HSL<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func uiColorCreationWithInteger() throws {
#if canImport(UIKit)
            let hsl = HSL<UInt8>(hue: 0x80, saturation: 0x40, luminance: 0xB0)
            let hsla = HSLA(hsl: hsl, alpha: 0x40)

            let opaqueColor = UIColor(hsl)
            let alphaColor = UIColor(hsla)

            var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if (compiler(>=6.2))
            #expect(unsafe opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue.isApproximatelyEqual(to: CGFloat(hsl.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(saturation.isApproximatelyEqual(to: HSB<CGFloat>(hsl: HSL(hsl)).saturation, absoluteTolerance: .ulpOfOne))
            #expect(brightness.isApproximatelyEqual(to: HSB<CGFloat>(hsl: HSL(hsl)).brightness, absoluteTolerance: .ulpOfOne))
            #expect(alpha == 1)
            (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
#if (compiler(>=6.2))
            #expect(unsafe alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue.isApproximatelyEqual(to: CGFloat(hsla.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(saturation.isApproximatelyEqual(to: HSBA<CGFloat>(hsla: HSLA(hsla)).saturation, absoluteTolerance: .ulpOfOne))
            #expect(brightness.isApproximatelyEqual(to: HSBA<CGFloat>(hsla: HSLA(hsla)).brightness, absoluteTolerance: .ulpOfOne))
            #expect(alpha.isApproximatelyEqual(to: CGFloat(hsla.alpha) / 0xFF, absoluteTolerance: .ulpOfOne))
#endif
        }

        @Test
        func creationFromUIColorWithInteger() throws {
#if canImport(UIKit)
            let hue: CGFloat = 0.5
            let saturation: CGFloat = 0.25
            let brightness: CGFloat = 0.75
            let alpha: CGFloat = 0.25
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

            let hsl = HSL<UInt8>(color)
            let hsla = HSLA<UInt8>(color)

            #expect(hsl.hue == UInt8(hue * 0xFF))
            #expect(hsla.hue == UInt8(hue * 0xFF))
            #expect(hsl.saturation.isApproximatelyEqual(to: HSL<UInt8>(hsb: HSB(color)).saturation, absoluteTolerance: 1, norm: Double.init))
            #expect(hsla.saturation.isApproximatelyEqual(to: HSLA<UInt8>(hsba: HSBA(color)).saturation, absoluteTolerance: 1, norm: Double.init))
            #expect(hsl.luminance == HSL(hsb: HSB(color)).luminance)
            #expect(hsla.luminance == HSLA(hsba: HSBA(color)).luminance)
            #expect(hsla.alpha == UInt8(alpha * 0xFF))
            #expect(HSL<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSL<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSL<Int8>(exactly: color) == nil)
            #expect(HSL<Int8>(exactly: color) == nil)
#endif
        }
    }
}
