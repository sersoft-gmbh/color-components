import Testing
#if canImport(CoreGraphics)
import CoreGraphics
fileprivate typealias FltType = CGFloat
#else
fileprivate typealias FltType = Double
#endif
@testable import ColorComponents

extension HSBATests {
    @Suite
    struct PlaygroundTests {
        @Test
        func playgroundColorWithFloatingPoint() throws {
            let hsb = HSB<FltType>(hue: 0.5, saturation: 0.73, brightness: 0.89)
            let hsba = HSBA(hsb: hsb, alpha: 0.25)

            let opaquePlaygroundColor: _PlaygroundColor = hsb._playgroundColor
            let alphaPlaygroundColor: _PlaygroundColor = hsba._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(hsb))
            #expect(alphaPlaygroundColor == _PlatformColor(hsba))
#elseif  canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == hsb.cgColor)
            #expect(alphaPlaygroundColor == hsba.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }

        @Test
        func playgroundColorWithBinaryInteger() throws {
            let hsb = HSB<UInt8>(hue: 0x9A, saturation: 0xF3, brightness: 0xFA)
            let hsba = HSBA(hsb: hsb, alpha: 0x77)

            let opaquePlaygroundColor: _PlaygroundColor = hsb._playgroundColor
            let alphaPlaygroundColor: _PlaygroundColor = hsba._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(hsb))
            #expect(alphaPlaygroundColor == _PlatformColor(hsba))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == hsb.cgColor)
            #expect(alphaPlaygroundColor == hsba.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }
    }
}
