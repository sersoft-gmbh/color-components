import Testing
import Numerics
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

extension HSBATests {
    @Suite(.enabled(if: .uiKitAvailable))
    struct UIKitTests {
        @Test
        func uiColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
            let hsb = HSB<CGFloat>(hue: 0.5, saturation: 0.25, brightness: 0.75)
            let hsba = HSBA(hsb: hsb, alpha: 0.25)
            
            let opaqueColor = UIColor(hsb)
            let alphaColor = UIColor(hsba)
            
            var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if (compiler(>=6.2))
            #expect(unsafe opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue == hsb.hue)
            #expect(saturation == hsb.saturation)
            #expect(brightness == hsb.brightness)
            #expect(alpha == 1)
            (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
#if (compiler(>=6.2))
            #expect(unsafe alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue == hsba.hue)
            #expect(saturation == hsba.saturation)
            #expect(brightness == hsba.brightness)
            #expect(alpha == hsba.alpha)
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
            
            let hsb = HSB<CGFloat>(color)
            let hsba = HSBA<CGFloat>(color)
            
            #expect(hsb.hue == hue)
            #expect(hsba.hue == hue)
            #expect(hsb.saturation == saturation)
            #expect(hsba.saturation == saturation)
            #expect(hsb.brightness == brightness)
            #expect(hsba.brightness == brightness)
            #expect(hsba.alpha == alpha)
            #expect(HSB<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSB<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSB<InexactFloat>(exactly: color) == nil)
            #expect(HSB<InexactFloat>(exactly: color) == nil)
#endif
        }
        
        @Test
        func uiColorCreationWithInteger() throws {
#if canImport(UIKit)
            let hsb = HSB<UInt8>(hue: 0x80, saturation: 0x40, brightness: 0xB0)
            let hsba = HSBA(hsb: hsb, alpha: 0x40)
            
            let opaqueColor = UIColor(hsb)
            let alphaColor = UIColor(hsba)
            
            var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if (compiler(>=6.2))
            #expect(unsafe opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue.isApproximatelyEqual(to: CGFloat(hsb.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(saturation.isApproximatelyEqual(to: CGFloat(hsb.saturation) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(brightness.isApproximatelyEqual(to: CGFloat(hsb.brightness) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(alpha == 1)
            (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
#if (compiler(>=6.2))
            #expect(unsafe alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#else
            #expect(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
#endif
            #expect(hue.isApproximatelyEqual(to: CGFloat(hsba.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(saturation.isApproximatelyEqual(to: CGFloat(hsba.saturation) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(brightness.isApproximatelyEqual(to: CGFloat(hsba.brightness) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(alpha.isApproximatelyEqual(to: CGFloat(hsba.alpha) / 0xFF, absoluteTolerance: .ulpOfOne))
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
            
            let hsb = HSB<UInt8>(color)
            let hsba = HSBA<UInt8>(color)
            
            #expect(hsb.hue == UInt8(hue * 0xFF))
            #expect(hsba.hue == UInt8(hue * 0xFF))
            #expect(hsb.saturation == UInt8(saturation * 0xFF))
            #expect(hsba.saturation == UInt8(saturation * 0xFF))
            #expect(hsb.brightness == UInt8(brightness * 0xFF))
            #expect(hsba.brightness == UInt8(brightness * 0xFF))
            #expect(hsba.alpha == UInt8(alpha * 0xFF))
            #expect(HSB<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSB<Int8>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)) == nil)
            #expect(HSB<Int8>(exactly: color) == nil)
            #expect(HSB<Int8>(exactly: color) == nil)
#endif
        }
    }
}
