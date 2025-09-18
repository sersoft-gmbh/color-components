import Testing
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

extension RGBATests {
    @Suite(.enabled(if: .coreGraphicsAvailable))
    struct CoreGraphicsTests {
        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let rgb = RGB<CGFloat>(red: 0.25, green: 0.5, blue: 0.75)
            let rgba = RGBA(rgb: rgb, alpha: 0.25)

            let opaqueColor = rgb.cgColor
            let alphaColor = rgba.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == 0.25)
            #expect(opaqueColor.components == [0.25, 0.5, 0.75, 1])
            #expect(alphaColor.components == [0.25, 0.5, 0.75, 0.25])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#if hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.25, 0.5, 0.75, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.25, 0.5, 0.75, 0.5]))
#endif

            let rgb = RGB<CGFloat>(cgColor)
            let rgba = RGBA<CGFloat>(cgColor)

            #expect(rgb.red == 0.25)
            #expect(rgba.red == 0.25)
            #expect(rgb.green == 0.5)
            #expect(rgba.green == 0.5)
            #expect(rgb.blue == 0.75)
            #expect(rgba.blue == 0.75)
            #expect(rgba.alpha == 0.5)
            #expect(RGBA<CGFloat>(exactly: cgColor) != nil)
            #expect(RGB<CGFloat>(exactly: cgColor) != nil)
            #expect(RGB<InexactFloat>(exactly: cgColor) == nil)
            #expect(RGBA<InexactFloat>(exactly: cgColor) == nil)
#endif
        }

        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
            let rgb = RGB<UInt8>(red: 0x40, green: 0x80, blue: 0xB0)
            let rgba = RGBA(rgb: rgb, alpha: 0x40)

            let opaqueColor = rgb.cgColor
            let alphaColor = rgba.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == (0x40 / 0xFF) as CGFloat)
            #expect(opaqueColor.components == [0x40 / 0xFF as CGFloat, 0x80 / 0xFF as CGFloat, 0xB0 / 0xFF as CGFloat, 1])
            #expect(alphaColor.components == [0x40 / 0xFF as CGFloat, 0x80 / 0xFF as CGFloat, 0xB0 / 0xFF as CGFloat, 0x40 / 0xFF as CGFloat])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#if hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.25, 0.5, 0.75, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.25, 0.5, 0.75, 0.5]))
#endif

            let rgb = RGB<UInt8>(cgColor)
            let rgba = RGBA<UInt8>(cgColor)

            #expect(rgb.red == UInt8(0.25 * 0xFF))
            #expect(rgba.red == UInt8(0.25 * 0xFF))
            #expect(rgb.green == UInt8(0.5 * 0xFF))
            #expect(rgba.green == UInt8(0.5 * 0xFF))
            #expect(rgb.blue == UInt8(0.75 * 0xFF))
            #expect(rgba.blue == UInt8(0.75 * 0xFF))
            #expect(rgba.alpha == UInt8(0.5 * 0xFF))
            #expect(RGB<Int8>(exactly: cgColor) == nil)
            #expect(RGBA<Int8>(exactly: cgColor) == nil)
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorConvertingColorSpaces() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#if hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.25, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.25, 0.5]))
#endif

            let rgb = RGB<CGFloat>(cgColor)
            let rgba = RGBA<CGFloat>(cgColor)

            #expect(rgb.red == 0.25)
            #expect(rgba.red == 0.25)
            #expect(rgb.green == 0.25)
            #expect(rgba.green == 0.25)
            #expect(rgb.blue == 0.25)
            #expect(rgba.blue == 0.25)
            #expect(rgba.alpha == 0.5)
#endif
        }
    }
}
