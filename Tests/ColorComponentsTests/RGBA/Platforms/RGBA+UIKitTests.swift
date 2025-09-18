import Testing
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

extension RGBATests {
    @Suite(.enabled(if: .uiKitAvailable))
    struct UIKitTests {
        @Test
        func uiColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
            let rgb = RGB<CGFloat>(red: 0.5, green: 0.25, blue: 0.75)
            let rgba = RGBA(rgb: rgb, alpha: 0.25)
            
            let opaqueColor = UIColor(rgb)
            let alphaColor = UIColor(rgba)
            
            var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            #expect(unsafe opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == rgb.red)
            #expect(green == rgb.green)
            #expect(blue == rgb.blue)
            #expect(alpha == 1)
            (red, green, blue, alpha) = (0, 0, 0, 0)
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            #expect(unsafe alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == rgba.red)
            #expect(green == rgba.green)
            #expect(blue == rgba.blue)
            #expect(alpha == rgba.alpha)
#endif
        }
        
        @Test
        func creationFromUIColorWithFloatingPoint() throws {
#if canImport(UIKit)
            let red: CGFloat = 0.5
            let green: CGFloat = 0.25
            let blue: CGFloat = 0.75
            let alpha: CGFloat = 0.25
            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            
            let rgb = RGB<CGFloat>(color)
            let rgba = RGBA<CGFloat>(color)
            
            #expect(rgb.red == red)
            #expect(rgba.red == red)
            #expect(rgb.green == green)
            #expect(rgba.green == green)
            #expect(rgb.blue == blue)
            #expect(rgba.blue == blue)
            #expect(rgba.alpha == alpha)
            #expect(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<InexactFloat>(exactly: color) == nil)
            #expect(RGB<InexactFloat>(exactly: color) == nil)
#endif
        }
        
        @Test
        func uiColorCreationWithInteger() throws {
#if canImport(UIKit)
            let rgb = RGB<UInt8>(red: 0x80, green: 0x40, blue: 0xB0)
            let rgba = RGBA(rgb: rgb, alpha: 0x40)
            
            let opaqueColor = UIColor(rgb)
            let alphaColor = UIColor(rgba)
            
            var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            #expect(unsafe opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == CGFloat(rgb.red) / 0xFF)
            #expect(green == CGFloat(rgb.green) / 0xFF)
            #expect(blue == CGFloat(rgb.blue) / 0xFF)
            #expect(alpha == 1)
            (red, green, blue, alpha) = (0, 0, 0, 0)
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            #expect(unsafe alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == CGFloat(rgba.red) / 0xFF)
            #expect(green == CGFloat(rgba.green) / 0xFF)
            #expect(blue == CGFloat(rgba.blue) / 0xFF)
            #expect(alpha == CGFloat(rgba.alpha) / 0xFF)
#endif
        }
        
        @Test
        func creationFromUIColorWithInteger() throws {
#if canImport(UIKit)
            let red: CGFloat = 0.5
            let green: CGFloat = 0.25
            let blue: CGFloat = 0.75
            let alpha: CGFloat = 0.25
            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            
            let rgb = RGB<UInt8>(color)
            let rgba = RGBA<UInt8>(color)
            
            #expect(rgb.red == UInt8(red * 0xFF))
            #expect(rgba.red == UInt8(red * 0xFF))
            #expect(rgb.green == UInt8(green * 0xFF))
            #expect(rgba.green == UInt8(green * 0xFF))
            #expect(rgb.blue == UInt8(blue * 0xFF))
            #expect(rgba.blue == UInt8(blue * 0xFF))
            #expect(rgba.alpha == UInt8(alpha * 0xFF))
            #expect(RGB<Int8>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<Int8>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<Int8>(exactly: color) == nil)
            #expect(RGB<Int8>(exactly: color) == nil)
#endif
        }
    }
}
