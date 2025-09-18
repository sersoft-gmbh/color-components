import Testing
#if canImport(CoreGraphics)
import CoreGraphics
fileprivate typealias FltType = CGFloat
#else
fileprivate typealias FltType = Double
#endif
@testable import ColorComponents

extension HSLATests {
    @Suite
    struct PlaygroundTests {
        @Test
        func playgroundColorWithFloatingPoint() throws {
            let hsl = HSL<FltType>(hue: 0.5, saturation: 0.73, luminance: 0.89)
            let hsla = HSLA(hsl: hsl, alpha: 0.25)

            let opaquePlaygroundColor = hsl._playgroundColor
            let alphaPlaygroundColor = hsla._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(hsl))
            #expect(alphaPlaygroundColor == _PlatformColor(hsla))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == hsl.cgColor)
            #expect(alphaPlaygroundColor == hsla.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }

        @Test
        func playgroundColorWithBinaryInteger() throws {
            let hsl = HSL<UInt8>(hue: 0x9A, saturation: 0xF3, luminance: 0xFA)
            let hsla = HSLA(hsl: hsl, alpha: 0x77)

            let opaquePlaygroundColor = hsl._playgroundColor
            let alphaPlaygroundColor = hsla._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(hsl))
            #expect(alphaPlaygroundColor == _PlatformColor(hsla))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == hsl.cgColor)
            #expect(alphaPlaygroundColor == hsla.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }
    }
}
