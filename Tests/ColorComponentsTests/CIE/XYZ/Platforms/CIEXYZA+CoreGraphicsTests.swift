import Testing
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

extension CIEXYZATests {
    @Suite(.enabled(if: .coreGraphicsAvailable))
    struct CoreGraphicsTests {
        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let cieXYZ = CIE.XYZ<CGFloat>(x: 0.25, y: 0.5, z: 0.75)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

            let opaqueColor = cieXYZ.cgColor
            let alphaColor = cieXYZA.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == 0.25)
            #expect(opaqueColor.components == [0.25, 0.5, 0.75, 1.0])
            #expect(alphaColor.components == [0.25, 0.5, 0.75, 0.25])
            #expect(opaqueColor.colorSpace == CGColorSpace(name: CGColorSpace.genericXYZ))
            #expect(alphaColor.colorSpace == CGColorSpace(name: CGColorSpace.genericXYZ))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: CGColorSpace.genericXYZ as CFString))
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#endif

            let cieXYZ = CIE.XYZ<CGFloat>(cgColor)
            let cieXYZA = CIE.XYZA<CGFloat>(cgColor)

            #expect(cieXYZ.x == 0.5625)
            #expect(cieXYZA.x == 0.5625)
            #expect(cieXYZ.y == 0.75)
            #expect(cieXYZA.y == 0.75)
            #expect(cieXYZ.z == 0.375)
            #expect(cieXYZA.z == 0.375)
            #expect(cieXYZA.alpha == 0.5)
            #expect(CIE.XYZ<CGFloat>(exactly: cgColor) != nil)
            #expect(CIE.XYZA<CGFloat>(exactly: cgColor) != nil)
            #expect(CIE.XYZ<InexactFloat>(exactly: cgColor) == nil)
            #expect(CIE.XYZA<InexactFloat>(exactly: cgColor) == nil)
#endif
        }

        @Test
        @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        func cgColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
            let cieXYZ = CIE.XYZ<UInt8>(x: 0x40, y: 0x80, z: 0xB0)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

            let opaqueColor = cieXYZ.cgColor
            let alphaColor = cieXYZA.cgColor

            #expect(opaqueColor.alpha == 1)
            #expect(alphaColor.alpha == (0x40 / 0xFF) as CGFloat)
            #expect(opaqueColor.components == CIE.XYZ<CGFloat>(cieXYZ).cgColor.components)
            #expect(alphaColor.components == CIE.XYZA<CGFloat>(cieXYZA).cgColor.components)
            #expect(opaqueColor.colorSpace == CGColorSpace(name: CGColorSpace.genericXYZ))
            #expect(alphaColor.colorSpace == CGColorSpace(name: CGColorSpace.genericXYZ))
#endif
        }

        @Test
        @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        func creationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
            let colorSpace = try #require(CGColorSpace(name: CGColorSpace.genericXYZ as CFString))
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            let cgColor = try #require(unsafe CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#else
            let cgColor = try #require(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))
#endif

            let cieXYZ = CIE.XYZ<UInt8>(cgColor)
            let cieXYZA = CIE.XYZA<UInt8>(cgColor)

            #expect(cieXYZ.x == UInt8(0.5625 * 0xFF))
            #expect(cieXYZA.x == UInt8(0.5625 * 0xFF))
            #expect(cieXYZ.y == UInt8(0.75 * 0xFF))
            #expect(cieXYZA.y == UInt8(0.75 * 0xFF))
            #expect(cieXYZ.z == UInt8(0.375 * 0xFF))
            #expect(cieXYZA.z == UInt8(0.375 * 0xFF))
            #expect(cieXYZA.alpha == UInt8(0.5 * 0xFF))
            #expect(CIE.XYZ<Int8>(exactly: cgColor) == nil)
            #expect(CIE.XYZ<Int8>(exactly: cgColor) == nil)
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
            #expect(try CIE.XYZ<UInt8>(exactly: #require(unsafe CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
            #expect(try CIE.XYZA<UInt8>(exactly: #require(unsafe CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
#else
            #expect(try CIE.XYZ<UInt8>(exactly: #require(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
            #expect(try CIE.XYZA<UInt8>(exactly: #require(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))) != nil)
#endif
#endif
        }
    }
}
