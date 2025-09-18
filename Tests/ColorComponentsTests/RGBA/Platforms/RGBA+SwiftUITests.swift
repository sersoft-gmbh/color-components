import Testing
import Numerics
#if canImport(SwiftUI)
import SwiftUI
#endif
import ColorComponents

extension RGBATests {
    @Suite(.enabled(if: .swiftUIAvailable))
    struct SwiftUITests {
        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.75)
            let rgba = RGBA(rgb: rgb, alpha: 0.25)

            #expect(Color(rgb) == Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 1))
            #expect(Color(rgba) == Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let rgb = RGB<CGFloat>(color)
            let rgba = RGBA<CGFloat>(color)
#elseif canImport(CoreGraphics)
            let rgb = try #require(RGB<CGFloat>(color))
            let rgba = try #require(RGBA<CGFloat>(color))
#else
            return
#endif

            #expect(rgb.red.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(rgba.red.isApproximatelyEqual(to: 0.5, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.25, absoluteTolerance: .ulpOfOne))
            #expect(rgba.green.isApproximatelyEqual(to: 0.25, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgba.blue.isApproximatelyEqual(to: 0.75, absoluteTolerance: .ulpOfOne))
            #expect(rgba.alpha == 0.25)
            #expect(RGB<InexactFloat>(exactly: Color(white: 1)) == nil)
            #expect(RGBA<InexactFloat>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithInteger() throws {
#if canImport(SwiftUI)
            let rgb = RGB<UInt8>(red: 0x80, green: 0x40, blue: 0xB0)
            let rgba = RGBA(rgb: rgb, alpha: 0x40)

            #expect(Color(rgb) == Color(red: Double(rgb.red) / 0xFF,
                                        green: Double(rgb.green) / 0xFF,
                                        blue: Double(rgb.blue) / 0xFF,
                                        opacity: 1))
            #expect(Color(rgba) == Color(red: Double(rgba.red) / 0xFF,
                                         green: Double(rgba.green) / 0xFF,
                                         blue: Double(rgba.blue) / 0xFF,
                                         opacity: Double(rgba.alpha) / 0xFF))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithInteger() throws {
#if canImport(SwiftUI)
            let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let rgb = RGB<UInt8>(color)
            let rgba = RGBA<UInt8>(color)
#elseif canImport(CoreGraphics)
            let rgb = try #require(RGB<UInt8>(color))
            let rgba = try #require(RGBA<UInt8>(color))
#else
            return
#endif

            #expect(rgb.red == UInt8(0.5 * 0xFF))
            #expect(rgba.red == UInt8(0.5 * 0xFF))
            #expect(rgb.green == UInt8(0.25 * 0xFF))
            #expect(rgba.green == UInt8(0.25 * 0xFF))
            #expect(rgb.blue == UInt8(0.75 * 0xFF))
            #expect(rgba.blue == UInt8(0.75 * 0xFF))
            #expect(rgba.alpha == UInt8(0.25 * 0xFF))
            #expect(RGB<Int8>(exactly: Color(white: 1)) == nil)
            #expect(RGBA<Int8>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func viewConformance() async throws {
#if canImport(SwiftUI) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
            let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.75)
            let rgba = RGBA(rgb: rgb, alpha: 0.25)

            #expect(await rgb.extractBody() == Color(rgb))
            #expect(await rgba.extractBody() == Color(rgba))
#endif
        }
    }
}
