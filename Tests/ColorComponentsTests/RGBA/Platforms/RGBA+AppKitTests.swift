import Testing
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

extension RGBATests {
    @Suite(.enabled(if: .appKitAvailable))
    struct AppKitTests {
        @Test
        func nsColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let rgb = RGB<CGFloat>(red: 0.25, green: 0.5, blue: 0.75)
            let rgba = RGBA(rgb: rgb, alpha: 0.25)

            let opaqueColor = NSColor(rgb)
            let alphaColor = NSColor(rgba)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == rgba.alpha)
            #expect(opaqueColor.redComponent == rgb.red)
            #expect(alphaColor.redComponent == rgba.red)
            #expect(opaqueColor.greenComponent == rgb.green)
            #expect(alphaColor.greenComponent == rgba.green)
            #expect(opaqueColor.blueComponent == rgb.blue)
            #expect(alphaColor.blueComponent == rgba.blue)
#endif
        }

        @Test
        func creationFromNSColorWithFloatingPoint() throws {
            // The compiler(6.0) check here is needed due to a bug in Swift 6.0. Remove this as of 6.1.
#if compiler(>=6.0) && canImport(AppKit) && !targetEnvironment(macCatalyst)
#if compiler(>=6.2)
            let color = unsafe NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
#else
            let color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
#endif

            let rgb = RGB<CGFloat>(color)
            let rgba = RGBA<CGFloat>(color)

            #expect(rgb.red == color.redComponent)
            #expect(rgba.red == color.redComponent)
            #expect(rgb.green == color.greenComponent)
            #expect(rgba.green == color.greenComponent)
            #expect(rgb.blue == color.blueComponent)
            #expect(rgba.blue == color.blueComponent)
            #expect(rgba.alpha == color.alphaComponent)
            #expect(RGB<InexactFloat>(exactly: color) == nil)
            #expect(RGBA<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func nsColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let rgb = RGB<UInt8>(red: 0x40, green: 0x80, blue: 0xB0)
            let rgba = RGBA(rgb: rgb, alpha: 0x40)

            let opaqueColor = NSColor(rgb)
            let alphaColor = NSColor(rgba)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == CGFloat(rgba.alpha) / 0xFF)
            #expect(opaqueColor.redComponent == CGFloat(rgb.red) / 0xFF)
            #expect(alphaColor.redComponent == CGFloat(rgba.red) / 0xFF)
            #expect(opaqueColor.greenComponent == CGFloat(rgb.green) / 0xFF)
            #expect(alphaColor.greenComponent == CGFloat(rgba.green) / 0xFF)
            #expect(opaqueColor.blueComponent == CGFloat(rgb.blue) / 0xFF)
            #expect(alphaColor.blueComponent == CGFloat(rgba.blue) / 0xFF)
#endif
        }

        @Test
        func creationFromNSColorWithInteger() throws {
            // The compiler(6.0) check here is needed due to a bug in Swift 6.0. Remove this as of 6.1.
#if compiler(>=6.0) && canImport(AppKit) && !targetEnvironment(macCatalyst)
#if compiler(>=6.2)
            let color = unsafe NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
#else
            let color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
#endif

            let rgb = RGB<UInt8>(color)
            let rgba = RGBA<UInt8>(color)

            #expect(rgb.red == UInt8(color.redComponent * 0xFF))
            #expect(rgba.red == UInt8(color.redComponent * 0xFF))
            #expect(rgb.green == UInt8(color.greenComponent * 0xFF))
            #expect(rgba.green == UInt8(color.greenComponent * 0xFF))
            #expect(rgb.blue == UInt8(color.blueComponent * 0xFF))
            #expect(rgba.blue == UInt8(color.blueComponent * 0xFF))
            #expect(rgba.alpha == UInt8(color.alphaComponent * 0xFF))
            #expect(RGB<Int8>(exactly: color) == nil)
            #expect(RGBA<Int8>(exactly: color) == nil)
#endif
        }
    }
}
