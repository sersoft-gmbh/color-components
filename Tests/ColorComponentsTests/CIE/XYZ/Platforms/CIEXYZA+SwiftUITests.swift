import Testing
import Numerics
#if canImport(SwiftUI)
import SwiftUI
#endif
import ColorComponents

extension CIEXYZATests {
    @Suite(.enabled(if: .swiftUIAvailable))
    struct SwiftUITests {
        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.75)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

            #expect(Color(cieXYZ) == Color(RGB(cieXYZ: cieXYZ)))
            #expect(Color(cieXYZA) == Color(RGBA(cieXYZA: cieXYZA)))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithFloatingPoint() throws {
#if canImport(SwiftUI)
            let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let cieXYZ = CIE.XYZ<Double>(color)
            let cieXYZA = CIE.XYZA<Double>(color)
            let cieXYZViaRGB = CIE.XYZ<Double>(rgb: RGB<Double>(color))
#elseif canImport(CoreGraphics)
            let cieXYZ = try #require(CIE.XYZ<Double>(color))
            let cieXYZA = try #require(CIE.XYZA<Double>(color))
            let cieXYZViaRGB = try CIE.XYZ<Double>(rgb: #require(RGB<Double>(color)))
#else
            return
#endif

            #expect(cieXYZ.x.isApproximatelyEqual(to: cieXYZViaRGB.x, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZA.x.isApproximatelyEqual(to: cieXYZViaRGB.x, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZ.y.isApproximatelyEqual(to: cieXYZViaRGB.y, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZA.y.isApproximatelyEqual(to: cieXYZViaRGB.y, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZ.z.isApproximatelyEqual(to: cieXYZViaRGB.z, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZA.z.isApproximatelyEqual(to: cieXYZViaRGB.z, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZA.alpha == 0.25)
            #expect(CIE.XYZ<InexactFloat>(exactly: Color(white: 1)) == nil)
            #expect(CIE.XYZA<InexactFloat>(exactly: Color(white: 1)) == nil)
#endif
        }

        @Test
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func colorCreationWithInteger() throws {
#if canImport(SwiftUI)
            let cieXYZ = CIE.XYZ<UInt8>(x: 0x80, y: 0x40, z: 0xB0)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

            #expect(Color(cieXYZ) == Color(RGB(cieXYZ: CIE.XYZ<Double>(cieXYZ))))
            #expect(Color(cieXYZA) == Color(RGBA(cieXYZA: CIE.XYZA<Double>(cieXYZA))))
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        func creationFromColorWithInteger() throws {
#if canImport(SwiftUI)
            let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
            let cieXYZ = CIE.XYZ<UInt8>(color)
            let cieXYZA = CIE.XYZA<UInt8>(color)
            let cieXYZViaRGB = CIE.XYZ<UInt8>(CIE.XYZ(rgb: RGB<Double>(color)))
#elseif canImport(CoreGraphics)
            let cieXYZ = try #require(CIE.XYZ<UInt8>(color))
            let cieXYZA = try #require(CIE.XYZA<UInt8>(color))
            let cieXYZViaRGB = try CIE.XYZ<UInt8>(CIE.XYZ(rgb: #require(RGB<Double>(color))))
#else
            return
#endif

            #expect(cieXYZ.x == cieXYZViaRGB.x)
            #expect(cieXYZA.x == cieXYZViaRGB.x)
            #expect(cieXYZ.y == cieXYZViaRGB.y)
            #expect(cieXYZA.y == cieXYZViaRGB.y)
            #expect(cieXYZ.z == cieXYZViaRGB.z)
            #expect(cieXYZA.z == cieXYZViaRGB.z)
            #expect(cieXYZA.alpha == UInt8(0.25 * 0xFF))
            #expect(CIE.XYZ<Int8>(exactly: color) == nil)
            #expect(CIE.XYZA<Int8>(exactly: color) == nil)
#endif
        }

        @Test(.enabled(if: .platformColorAvailable))
        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func viewConformance() async throws {
#if canImport(SwiftUI) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
            let cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.75)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

            #expect(await cieXYZ.extractBody() == Color(cieXYZ))
            #expect(await cieXYZA.extractBody() == Color(cieXYZA))
#endif
        }
    }
}
