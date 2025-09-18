import Testing
import Numerics
#if canImport(SwiftUI)
import SwiftUI
#endif
import ColorComponents

extension HSBATests {
    @Suite(.enabled(if: .swiftUIAvailable))
    struct SwiftUITests {
        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.75)
            let hsba = HSBA(hsb: hsb, alpha: 0.25)

            #expect(Color(hsb) == Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 1))
            #expect(Color(hsba) == Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let hsb = HSB<CGFloat>(color)
            let hsba = HSBA<CGFloat>(color)
#elseif canImport(CoreGraphics)
            let hsb = try #require(HSB<CGFloat>(color))
            let hsba = try #require(HSBA<CGFloat>(color))
#else
            return
#endif

            #expect(hsb.hue.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsba.hue.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(hsb.saturation.isApproximatelyEqual(to: 0.25, absoluteTolerance: .ulpOfOne))
            #expect(hsba.saturation.isApproximatelyEqual(to: 0.25, absoluteTolerance: .ulpOfOne))
            #expect(hsb.brightness.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsba.brightness.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(hsba.alpha == 0.25)
            #expect(HSB<InexactFloat>(exactly: Color(white: 1)) == nil)
            #expect(HSBA<InexactFloat>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithInteger() throws {
#if canImport(SwiftUI)
            let hsb = HSB<UInt8>(hue: 0x80, saturation: 0x40, brightness: 0xB0)
            let hsba = HSBA(hsb: hsb, alpha: 0x40)

            #expect(Color(hsb) == Color(hue: Double(hsb.hue) / 0xFF,
                                        saturation: Double(hsb.saturation) / 0xFF,
                                        brightness: Double(hsb.brightness) / 0xFF,
                                        opacity: 1))
            #expect(Color(hsba) == Color(hue: Double(hsba.hue) / 0xFF,
                                         saturation: Double(hsba.saturation) / 0xFF,
                                         brightness: Double(hsba.brightness) / 0xFF,
                                         opacity: Double(hsba.alpha) / 0xFF))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithInteger() throws {
#if canImport(SwiftUI)
            let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let hsb = HSB<UInt8>(color)
            let hsba = HSBA<UInt8>(color)
#elseif canImport(CoreGraphics)
            let hsb = try #require(HSB<UInt8>(color))
            let hsba = try #require(HSBA<UInt8>(color))
#endif

            #expect(hsb.hue == UInt8(0.5 * 0xFF))
            #expect(hsba.hue == UInt8(0.5 * 0xFF))
            #expect(hsb.saturation == UInt8(0.25 * 0xFF))
            #expect(hsba.saturation == UInt8(0.25 * 0xFF))
            #expect(hsb.brightness == UInt8(0.75 * 0xFF))
            #expect(hsba.brightness == UInt8(0.75 * 0xFF))
            #expect(hsba.alpha == UInt8(0.25 * 0xFF))
            #expect(HSB<Int8>(exactly: color) == nil)
            #expect(HSBA<Int8>(exactly: color) == nil)
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func viewConformance() async throws {
#if canImport(SwiftUI) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
            let hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.75)
            let hsba = HSBA(hsb: hsb, alpha: 0.25)

            #expect(await hsb.extractBody() == Color(hsb))
            #expect(await hsba.extractBody() == Color(hsba))
#endif
        }
    }
}
