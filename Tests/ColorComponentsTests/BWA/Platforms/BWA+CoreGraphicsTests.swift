import Testing
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

extension BWATests {
    @Suite(.enabled(if: .coreGraphicsAvailable))
    struct CoreGraphicsTests {
        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let bw = BW<CGFloat>(white: 0.5)
            let bwa = BWA(bw: bw, alpha: 0.25)

            let opaqueColor = bw.cgColor
            let alphaColor = bwa.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == 0.25)
            #expect(opaqueColor.components == [0.5, 1.0])
            #expect(alphaColor.components == [0.5, 0.25])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.75, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.75, 0.5]))
#endif

            let bw = BW<CGFloat>(cgColor)
            let bwa = BWA<CGFloat>(cgColor)

            #expect(bw.white == 0.75)
            #expect(bwa.white == 0.75)
            #expect(bwa.alpha == 0.5)
            #expect(BWA<CGFloat>(exactly: cgColor) != nil)
            #expect(BW<CGFloat>(exactly: cgColor) != nil)
            #expect(BW<InexactFloat>(exactly: cgColor) == nil)
            #expect(BWA<InexactFloat>(exactly: cgColor) == nil)
#endif
        }

        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
            let bw = BW<UInt8>(white: 0x80)
            let bwa = BWA(bw: bw, alpha: 0x40)

            let opaqueColor = bw.cgColor
            let alphaColor = bwa.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == (0x40 / 0xFF) as CGFloat)
            #expect(opaqueColor.components == [0x80 / 0xFF as CGFloat, 1.0])
            #expect(alphaColor.components == [0x80 / 0xFF as CGFloat, 0x40 / 0xFF as CGFloat])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
            #expect(alphaColor.colorSpace == CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.75, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.75, 0.5]))
#endif

            let bw = BW<UInt8>(cgColor)
            let bwa = BWA<UInt8>(cgColor)

            #expect(bw.white == 0xBF)
            #expect(bwa.white == 0xBF)
            #expect(bwa.alpha == 0x7F)
            #expect(BW<Int8>(exactly: cgColor) == nil)
            #expect(BWA<Int8>(exactly: cgColor) == nil)
#endif
        }
    }
}
