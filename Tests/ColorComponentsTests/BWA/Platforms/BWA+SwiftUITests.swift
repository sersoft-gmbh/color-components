import Testing
import Numerics
#if canImport(SwiftUI)
import SwiftUI
#endif
import ColorComponents

extension BWATests {
    @Suite(.enabled(if: .swiftUIAvailable))
    struct SwiftUITests {
        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let bw = BW<Double>(white: 0.5)
            let bwa = BWA(bw: bw, alpha: 0.25)

            #expect(Color(bw) == Color(white: 0.5, opacity: 1))
            #expect(Color(bwa) == Color(white: 0.5, opacity: 0.25))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let color = Color(white: 0.5, opacity: 0.25)

#if (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)))
            let bw = BW<CGFloat>(color)
            let bwa = BWA<CGFloat>(color)
#elseif canImport(CoreGraphics)
            let bw = try #require(BW<CGFloat>(color))
            let bwa = try #require(BWA<CGFloat>(color))
#else
            return
#endif

            #expect(bw.white.isApproximatelyEqual(to: 0.5, absoluteTolerance: 0.00001))
            #expect(bwa.white.isApproximatelyEqual(to: 0.5, absoluteTolerance: 0.00001))
            #expect(bwa.alpha == 0.25)
            #expect(BW<InexactFloat>(exactly: Color(white: 1)) == nil)
            #expect(BWA<InexactFloat>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithInteger() throws {
#if canImport(SwiftUI)
            let bw = BW<UInt8>(white: 0x80)
            let bwa = BWA(bw: bw, alpha: 0x40)

            #expect(Color(bw) == Color(white: 0x80 / 0xFF, opacity: 1))
            #expect(Color(bwa) == Color(white: 0x80 / 0xFF, opacity: 0x40 / 0xFF))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithInteger() throws {
#if canImport(SwiftUI)
            let color = Color(white: 0.75, opacity: 0.25)

#if (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)))
            let bw = BW<UInt8>(color)
            let bwa = BWA<UInt8>(color)
#elseif canImport(CoreGraphics)
            let bw = try #require(BW<UInt8>(color))
            let bwa = try #require(BWA<UInt8>(color))
#else
            return
#endif

            #expect(bw.white == 0xBF)
            #expect(bwa.white == 0xBF)
            #expect(bwa.alpha == 0x3F)
            #expect(BW<Int8>(exactly: Color(white: 1)) == nil)
            #expect(BWA<Int8>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func viewConformance() async throws {
#if canImport(SwiftUI) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
            let bw = BW<Double>(white: 0.5)
            let bwa = BWA(bw: bw, alpha: 0.25)

            #expect(await bw.extractBody() == Color(bw))
            #expect(await bwa.extractBody() == Color(bwa))
#endif
        }
    }
}
