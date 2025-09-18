import Testing
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

extension HSLATests {
    @Suite(.enabled(if: .coreGraphicsAvailable))
    struct CoreGraphicsTests {
        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let hsl = HSL<CGFloat>(hue: 0.25, saturation: 0.5, luminance: 0.75)
            let hsla = HSLA(hsl: hsl, alpha: 0.25)

            let opaqueColor = hsl.cgColor
            let alphaColor = hsla.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == 0.25)
            #expect(opaqueColor.components == [0.75, 0.875, 0.625, 1])
            #expect(alphaColor.components == [0.75, 0.875, 0.625, 0.25])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#endif

            let hsl = HSL<CGFloat>(cgColor)
            let hsla = HSLA<CGFloat>(cgColor)

            #expect(hsl.hue == 0.25)
            #expect(hsla.hue == 0.25)
            #expect(hsl.saturation == HSL<CGFloat>(rgb: RGB(cgColor)).saturation)
            #expect(hsla.saturation == HSLA<CGFloat>(rgba: RGBA(cgColor)).saturation)
            #expect(hsl.brightness == 0.75)
            #expect(hsla.brightness == 0.75)
            #expect(hsla.alpha == 0.5)
            #expect(HSLA<CGFloat>(exactly: cgColor) != nil)
            #expect(HSL<CGFloat>(exactly: cgColor) != nil)
            #expect(HSL<InexactFloat>(exactly: cgColor) == nil)
            #expect(HSLA<InexactFloat>(exactly: cgColor) == nil)
#endif
        }

        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
            let hsl = HSL<UInt8>(hue: 0x40, saturation: 0x80, luminance: 0xB0)
            let hsla = HSLA(hsl: hsl, alpha: 0x40)

            let opaqueColor = hsl.cgColor
            let alphaColor = hsla.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == (0x40 / 0xFF) as CGFloat)
            #expect(opaqueColor.components == HSL<CGFloat>(hsl).cgColor.components)
            #expect(alphaColor.components == HSLA<CGFloat>(hsla).cgColor.components)
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#endif

            let hsl = HSL<UInt8>(cgColor)
            let hsla = HSLA<UInt8>(cgColor)

            #expect(hsl.hue == UInt8(0.25 * 0xFF))
            #expect(hsla.hue == UInt8(0.25 * 0xFF))
            #expect(hsl.saturation == HSL<UInt8>(rgb: RGB(cgColor)).saturation)
            #expect(hsla.saturation == HSLA<UInt8>(rgba: RGBA(cgColor)).saturation)
            #expect(hsl.luminance == HSL(rgb: RGB(cgColor)).luminance)
            #expect(hsla.luminance == HSLA(rgba: RGBA(cgColor)).luminance)
            #expect(hsla.alpha == UInt8(0.5 * 0xFF))
            #expect(HSL<Int8>(exactly: cgColor) == nil)
            #expect(HSLA<Int8>(exactly: cgColor) == nil)
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            #expect(try HSL<UInt8>(exactly: #require(unsafe CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
            #expect(try HSLA<UInt8>(exactly: #require(unsafe CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
#else
            #expect(try HSL<UInt8>(exactly: #require(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
            #expect(try HSLA<UInt8>(exactly: #require(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
#endif
#endif
        }
    }
}
