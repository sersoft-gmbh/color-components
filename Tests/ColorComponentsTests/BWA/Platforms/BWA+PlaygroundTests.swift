import Testing
#if canImport(CoreGraphics)
import CoreGraphics
fileprivate typealias FltType = CGFloat
#else
fileprivate typealias FltType = Double
#endif
@testable import ColorComponents

extension BWATests {
    @Suite
    struct PlaygroundTests {
        @Test
        func playgroundColorWithFloatingPoint() {
            let bw = BW<FltType>(white: 0.5)
            let bwa = BWA(bw: bw, alpha: 0.25)

            let opaquePlaygroundColor = bw._playgroundColor
            let alphaPlaygroundColor = bwa._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(bw))
            #expect(alphaPlaygroundColor == _PlatformColor(bwa))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == bw.cgColor)
            #expect(alphaPlaygroundColor == bwa.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }

        @Test
        func playgroundColorWithBinaryInteger() {
            let bw = BW<UInt8>(white: 0x90)
            let bwa = BWA(bw: bw, alpha: 0x77)

            let opaquePlaygroundColor = bw._playgroundColor
            let alphaPlaygroundColor = bwa._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(bw))
            #expect(alphaPlaygroundColor == _PlatformColor(bwa))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == bw.cgColor)
            #expect(alphaPlaygroundColor == bwa.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }
    }
}
