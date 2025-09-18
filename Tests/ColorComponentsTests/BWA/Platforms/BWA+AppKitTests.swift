import Testing
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

extension BWATests {
    @Suite(.enabled(if: .appKitAvailable))
    struct AppKitTests {
        @Test
        func nsColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let bw = BW<CGFloat>(white: 0.5)
            let bwa = BWA(bw: bw, alpha: 0.25)

            let opaqueColor = NSColor(bw)
            let alphaColor = NSColor(bwa)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == 0.25)
            #expect(opaqueColor.whiteComponent == 0.5)
            #expect(alphaColor.whiteComponent == 0.5)
#endif
        }

        @Test
        func creationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let color = unsafe NSColor(colorSpace: .genericGray, components: [0.5, 0.25], count: 2)
#else
            let color = NSColor(colorSpace: .genericGray, components: [0.5, 0.25], count: 2)
#endif

            let bw = BW<CGFloat>(color)
            let bwa = BWA<CGFloat>(color)

            #expect(bw.white == color.whiteComponent)
            #expect(bwa.white == color.whiteComponent)
            #expect(bwa.alpha == color.alphaComponent)
            #expect(BW<InexactFloat>(exactly: color) == nil)
            #expect(BWA<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func nsColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let bw = BW<UInt8>(white: 128)
            let bwa = BWA(bw: bw, alpha: 64)

            let opaqueColor = NSColor(bw)
            let alphaColor = NSColor(bwa)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == (64 / 0xFF) as CGFloat)
            #expect(opaqueColor.whiteComponent == (128 / 0xFF) as CGFloat)
            #expect(alphaColor.whiteComponent == (128 / 0xFF) as CGFloat)
#endif
        }

        @Test
        func creationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let color = unsafe NSColor(colorSpace: .genericGray, components: [0.75, 0.25], count: 2)
#else
            let color = NSColor(colorSpace: .genericGray, components: [0.75, 0.25], count: 2)
#endif

            let bw = BW<UInt8>(color)
            let bwa = BWA<UInt8>(color)

            #expect(bw.white == UInt8(0.75 * 0xFF))
            #expect(bwa.white == UInt8(0.75 * 0xFF))
            #expect(bwa.alpha == UInt8(0.25 * 0xFF))
            #expect(BW<Int8>(exactly: color) == nil)
            #expect(BWA<Int8>(exactly: color) == nil)
#endif
        }
    }
}
