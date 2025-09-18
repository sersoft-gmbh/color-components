import Testing
import Numerics
import ColorComponents

extension CIEXYZATests {
    @Suite
    struct RGBATests {
        @Test
        func creationFromFloatingPointRGBA() {
            let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
            let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

            let cieXYZ = CIE.XYZ(rgb: rgb)
            let cieXYZA = CIE.XYZA(rgba: rgba)

            #expect(cieXYZ.x.isApproximatelyEqual(to: 0.318174375, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZ.y.isApproximatelyEqual(to: 0.294146625, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZ.z.isApproximatelyEqual(to: 0.158243625, absoluteTolerance: .ulpOfOne))
            #expect(cieXYZA.xyz == cieXYZ)
            #expect(cieXYZA.alpha == rgba.alpha)
        }

        @Test
        func creationFromIntegerRGBA() {
            let rgb = RGB<UInt8>(red: 0x10, green: 0x20, blue: 0x30)
            let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

            let cieXYZ = CIE.XYZ(rgb: rgb)
            let cieXYZA = CIE.XYZA(rgba: rgba)

            #expect(cieXYZ.x == 26)
            #expect(cieXYZ.y == 29)
            #expect(cieXYZ.z == 49)
            #expect(cieXYZA.xyz == cieXYZ)
            #expect(cieXYZA.alpha == rgba.alpha)
        }
    }
}
