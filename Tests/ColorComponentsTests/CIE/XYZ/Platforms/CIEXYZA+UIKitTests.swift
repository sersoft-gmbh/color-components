import Testing
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

extension CIEXYZATests {
    @Suite(.enabled(if: .uiKitAvailable))
    struct UIKitTests {
        @Test
        func uiColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
            let cieXYZ = CIE.XYZ<CGFloat>(x: 0.5, y: 0.25, z: 0.75)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

            let rgb = RGB(cieXYZ: cieXYZ)

            let opaqueColor = UIColor(cieXYZ)
            let alphaColor = UIColor(cieXYZA)

            var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if compiler(>=6.2)
            #expect(unsafe opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == rgb.red)
            #expect(green == rgb.green)
            #expect(blue == rgb.blue)
            #expect(alpha == 1)
            (red, green, blue, alpha) = (0, 0, 0, 0)
#if compiler(>=6.2)
            #expect(unsafe alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == rgb.red)
            #expect(green == rgb.green)
            #expect(blue == rgb.blue)
            #expect(alpha == cieXYZA.alpha)
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

            let cieXYZ = CIE.XYZ<CGFloat>(color)
            let cieXYZA = CIE.XYZA<CGFloat>(color)

            let cieXYZViaRGB = CIE.XYZ(rgb: RGB(red: red, green: green, blue: blue))

            #expect(cieXYZ.x == cieXYZViaRGB.x)
            #expect(cieXYZA.x == cieXYZViaRGB.x)
            #expect(cieXYZ.y == cieXYZViaRGB.y)
            #expect(cieXYZA.y == cieXYZViaRGB.y)
            #expect(cieXYZ.z == cieXYZViaRGB.z)
            #expect(cieXYZA.z == cieXYZViaRGB.z)
            #expect(cieXYZA.alpha == alpha)
            #expect(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<InexactFloat>(exactly: color) == nil)
            #expect(RGB<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func uiColorCreationWithInteger() throws {
#if canImport(UIKit)
            let cieXYZ = CIE.XYZ<UInt8>(x: 0x80, y: 0x40, z: 0xB0)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

            let rgb = RGB(cieXYZ: CIE.XYZ<CGFloat>(cieXYZ))

            let opaqueColor = UIColor(cieXYZ)
            let alphaColor = UIColor(cieXYZA)

            var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
#if compiler(>=6.2)
            #expect(unsafe opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == rgb.red)
            #expect(green == rgb.green)
            #expect(blue == rgb.blue)
            #expect(alpha == 1)
            (red, green, blue, alpha) = (0, 0, 0, 0)
#if compiler(>=6.2)
            #expect(unsafe alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#else
            #expect(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
#endif
            #expect(red == rgb.red)
            #expect(green == rgb.green)
            #expect(blue == rgb.blue)
            #expect(alpha == CGFloat(cieXYZA.alpha) / 0xFF)
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

            let cieXYZ = CIE.XYZ<UInt8>(color)
            let cieXYZA = CIE.XYZA<UInt8>(color)

            let cieXYZViaRGB = CIE.XYZ<UInt8>(CIE.XYZ(rgb: RGB(red: red, green: green, blue: blue)))

            #expect(cieXYZ.x == cieXYZViaRGB.x)
            #expect(cieXYZA.x == cieXYZViaRGB.x)
            #expect(cieXYZ.y == cieXYZViaRGB.y)
            #expect(cieXYZA.y == cieXYZViaRGB.y)
            #expect(cieXYZ.z == cieXYZViaRGB.z)
            #expect(cieXYZA.z == cieXYZViaRGB.z)
            #expect(cieXYZA.alpha == UInt8(alpha * 0xFF))
            #expect(RGB<Int8>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<Int8>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)) == nil)
            #expect(RGB<Int8>(exactly: color) == nil)
            #expect(RGB<Int8>(exactly: color) == nil)
#endif
        }
    }
}
