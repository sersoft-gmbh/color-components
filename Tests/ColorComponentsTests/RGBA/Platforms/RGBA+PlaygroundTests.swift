import Testing
#if canImport(CoreGraphics)
import CoreGraphics
fileprivate typealias FltType = CGFloat
#else
fileprivate typealias FltType = Double
#endif
@testable import ColorComponents

extension RGBATests {
    @Suite
    struct PlaygroundTests {
        @Test
        func playgroundColorWithFloatingPoint() throws {
            let rgb = RGB<FltType>(red: 0.5, green: 0.73, blue: 0.89)
            let rgba = RGBA(rgb: rgb, alpha: 0.25)

            let opaquePlaygroundColor: _PlaygroundColor = rgb._playgroundColor
            let alphaPlaygroundColor: _PlaygroundColor = rgba._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(rgb))
            #expect(alphaPlaygroundColor == _PlatformColor(rgba))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == rgb.cgColor)
            #expect(alphaPlaygroundColor == rgba.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }

        @Test
        func playgroundColorWithBinaryInteger() throws {
            let rgb = RGB<UInt8>(red: 0x9A, green: 0xF3, blue: 0xFA)
            let rgba = RGBA(rgb: rgb, alpha: 0x77)

            let opaquePlaygroundColor: _PlaygroundColor = rgb._playgroundColor
            let alphaPlaygroundColor: _PlaygroundColor = rgba._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(rgb))
            #expect(alphaPlaygroundColor == _PlatformColor(rgba))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == rgb.cgColor)
            #expect(alphaPlaygroundColor == rgba.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }
    }
}
