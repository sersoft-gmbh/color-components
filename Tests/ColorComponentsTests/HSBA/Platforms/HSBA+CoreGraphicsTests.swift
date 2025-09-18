import Testing
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

extension HSBATests {
    @Suite(.enabled(if: .coreGraphicsAvailable))
    struct CoreGraphicsTests {
        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let hsb = HSB<CGFloat>(hue: 0.25, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA(hsb: hsb, alpha: 0.25)

            let opaqueColor = hsb.cgColor
            let alphaColor = hsba.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == 0.25)
            #expect(opaqueColor.components == [0.5625, 0.75, 0.375, 1])
            #expect(alphaColor.components == [0.5625, 0.75, 0.375, 0.25])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#if (compiler(>=6.2))
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#endif

            let hsb = HSB<CGFloat>(cgColor)
            let hsba = HSBA<CGFloat>(cgColor)

            #expect(hsb.hue == 0.25)
            #expect(hsba.hue == 0.25)
            #expect(hsb.saturation == 0.5)
            #expect(hsba.saturation == 0.5)
            #expect(hsb.brightness == 0.75)
            #expect(hsba.brightness == 0.75)
            #expect(hsba.alpha == 0.5)
            #expect(HSBA<CGFloat>(exactly: cgColor) != nil)
            #expect(HSB<CGFloat>(exactly: cgColor) != nil)
            #expect(HSB<InexactFloat>(exactly: cgColor) == nil)
            #expect(HSBA<InexactFloat>(exactly: cgColor) == nil)
#endif
        }

        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
            let hsb = HSB<UInt8>(hue: 0x40, saturation: 0x80, brightness: 0xB0)
            let hsba = HSBA(hsb: hsb, alpha: 0x40)

            let opaqueColor = hsb.cgColor
            let alphaColor = hsba.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == (0x40 / 0xFF) as CGFloat)
            #expect(opaqueColor.components == HSB<CGFloat>(hsb).cgColor.components)
            #expect(alphaColor.components == HSBA<CGFloat>(hsba).cgColor.components)
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericRGB" as CFString))
#if (compiler(>=6.2))
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#endif

            let hsb = HSB<UInt8>(cgColor)
            let hsba = HSBA<UInt8>(cgColor)

            #expect(hsb.hue == UInt8(0.25 * 0xFF))
            #expect(hsba.hue == UInt8(0.25 * 0xFF))
            #expect(hsb.saturation == UInt8(0.505 * 0xFF))
            #expect(hsba.saturation == UInt8(0.505 * 0xFF))
            #expect(hsb.brightness == UInt8(0.75 * 0xFF))
            #expect(hsba.brightness == UInt8(0.75 * 0xFF))
            #expect(hsba.alpha == UInt8(0.5 * 0xFF))
            #expect(HSB<Int8>(exactly: cgColor) == nil)
            #expect(HSBA<Int8>(exactly: cgColor) == nil)
#if (compiler(>=6.2))
            #expect(try HSB<UInt8>(exactly: #require(unsafe CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
            #expect(try HSBA<UInt8>(exactly: #require(unsafe CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
#else
            #expect(try HSB<UInt8>(exactly: #require(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
            #expect(try HSBA<UInt8>(exactly: #require(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
#endif
#endif
        }
    }
}
