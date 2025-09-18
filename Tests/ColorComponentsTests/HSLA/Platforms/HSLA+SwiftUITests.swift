import Testing
import Numerics
#if canImport(SwiftUI)
import SwiftUI
#endif
@testable import ColorComponents

extension HSLATests {
    @Suite(.enabled(if: .swiftUIAvailable))
    struct SwiftUITests {
        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.75)
            let hsla = HSLA(hsl: hsl, alpha: 0.25)

            #expect(Color(hsl) == Color(HSB(hsl: hsl)))
            #expect(Color(hsla) == Color(HSBA(hsla: hsla)))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let hsl = HSL<CGFloat>(color)
            let hsb = HSB<CGFloat>(color)
            let hsla = HSLA<CGFloat>(color)
            let hsba = HSBA<CGFloat>(color)
#elseif canImport(CoreGraphics)
            let hsl = try #require(HSL<CGFloat>(color))
            let hsb = try #require(HSB<CGFloat>(color))
            let hsla = try #require(HSLA<CGFloat>(color))
            let hsba = try #require(HSBA<CGFloat>(color))
#else
            return
#endif

            #expect(hsl.hue.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsla.hue.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsl.saturation.isApproximatelyEqual(to: HSL(hsb: hsb).saturation, absoluteTolerance: .ulpOfOne))
            #expect(hsla.saturation.isApproximatelyEqual(to: HSLA(hsba: hsba).saturation, absoluteTolerance: .ulpOfOne))
            #expect(hsl.brightness.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsla.brightness.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsla.alpha == 0.25)
            #expect(HSL<InexactFloat>(exactly: Color(white: 1)) == nil)
            #expect(HSLA<InexactFloat>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithInteger() throws {
#if canImport(SwiftUI)
            let hsl = HSL<UInt8>(hue: 0x80, saturation: 0x40, luminance: 0xB0)
            let hsla = HSLA(hsl: hsl, alpha: 0x40)

            #expect(Color(hsl) == Color(HSL<Double>(hsl)))
            #expect(Color(hsla) == Color(HSLA<Double>(hsla)))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithInteger() throws {
#if canImport(SwiftUI)
            let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let hsl = HSL<UInt8>(color)
            let hsb = HSB<UInt8>(color)
            let hsla = HSLA<UInt8>(color)
            let hsba = HSBA<UInt8>(color)
#elseif canImport(CoreGraphics)
            let hsl = try #require(HSL<UInt8>(color))
            let hsb = try #require(HSB<UInt8>(color))
            let hsla = try #require(HSLA<UInt8>(color))
            let hsba = try #require(HSBA<UInt8>(color))
#else
            return
#endif

            #expect(hsl.hue == UInt8(0.5 * 0xFF))
            #expect(hsla.hue == UInt8(0.5 * 0xFF))
            #expect(hsl.saturation.isApproximatelyEqual(to: HSL(hsb: hsb).saturation, absoluteTolerance: 1, norm: Double.init))
            #expect(hsla.saturation.isApproximatelyEqual(to: HSLA(hsba: hsba).saturation, absoluteTolerance: 1, norm: Double.init))
            #expect(hsl.luminance == HSL(hsb: hsb).luminance)
            #expect(hsla.luminance == HSLA(hsba: hsba).luminance)
            #expect(hsla.alpha == UInt8(0.25 * 0xFF))
            #expect(HSL<Int8>(exactly: color) == nil)
            #expect(HSLA<Int8>(exactly: color) == nil)
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func viewConformance() async throws {
#if canImport(SwiftUI) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
            let hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.75)
            let hsla = HSLA(hsl: hsl, alpha: 0.25)

            #expect(await hsl.extractBody() == Color(hsl))
            #expect(await hsla.extractBody() == Color(hsla))
#endif
        }
    }
}
