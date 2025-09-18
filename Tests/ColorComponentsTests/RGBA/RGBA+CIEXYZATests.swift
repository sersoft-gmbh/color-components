import Testing
import Numerics
import ColorComponents

extension RGBATests {
    @Suite
    struct CIEXYZATests {
        @Test
        func creationFromFloatingPointCIEXYZA() {
            let cieXYZ = CIE.XYZ<Double>(x: 0.4, y: 0.5, z: 0.75)
            let cieXYZA = CIE.XYZA<Double>(xyz: cieXYZ, alpha: 0.9)

            let rgb = RGB(cieXYZ: cieXYZ)
            let rgba = RGBA(cieXYZA: cieXYZA)

            #expect(rgb.red.isApproximatelyEqual(to: 0.15371535, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0.5814606, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0.71322095, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == cieXYZA.alpha)
        }

        @Test
        func creationFromIntegerCIEXYZA() {
            let cieXYZ = CIE.XYZ<UInt8>(x: 0xFA, y: 0x80, z: 0xB0)
            let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFA)

            let rgb = RGB(cieXYZ: cieXYZ)
            let rgba = RGBA(cieXYZA: cieXYZA)

            #expect(rgb.red == 0xFF)
            #expect(rgb.green == 0x05)
            #expect(rgb.blue == 0xAD)
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == cieXYZA.alpha)
        }
    }
}
