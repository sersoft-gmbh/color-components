import Testing
#if canImport(CoreGraphics)
import CoreGraphics
fileprivate typealias FltType = CGFloat
#else
fileprivate typealias FltType = Double
#endif
@testable import ColorComponents

extension CIEXYZATests {
    @Suite
    struct PlaygroundTests {
        @Test
        func playgroundColorWithFloatingPoint() throws {
            let cieXYZ = CIE.XYZ<FltType>(x: 0.5, y: 0.73, z: 0.1)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

            let opaquePlaygroundColor = cieXYZ._playgroundColor
            let alphaPlaygroundColor = cieXYZA._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(cieXYZ))
            #expect(alphaPlaygroundColor == _PlatformColor(cieXYZA))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == cieXYZ.cgColor)
            #expect(alphaPlaygroundColor == cieXYZA.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }

        @Test
        func playgroundColorWithBinaryInteger() throws {
            let cieXYZ = CIE.XYZ<UInt8>(x: 0x9A, y: 0xF3, z: 0x10)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x77)

            let opaquePlaygroundColor = cieXYZ._playgroundColor
            let alphaPlaygroundColor = cieXYZA._playgroundColor

#if canImport(AppKit) || canImport(UIKit)
            #expect(opaquePlaygroundColor == _PlatformColor(cieXYZ))
            #expect(alphaPlaygroundColor == _PlatformColor(cieXYZA))
#elseif canImport(CoreGraphics)
            #expect(opaquePlaygroundColor == cieXYZ.cgColor)
            #expect(alphaPlaygroundColor == cieXYZA.cgColor)
#else
            #expect(opaquePlaygroundColor == nil)
            #expect(alphaPlaygroundColor == nil)
#endif
        }
    }
}
