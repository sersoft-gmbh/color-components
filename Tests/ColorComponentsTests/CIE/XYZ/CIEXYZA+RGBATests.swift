import XCTest
import ColorComponents

final class CIEXYZ_RGBATests: XCTestCase {
    func testCreationFromRGBA() {
        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 0.9)

        let cieXYZ = CIE.XYZ(rgb: rgb)
        let cieXYZA = CIE.XYZA(rgba: rgba)

        XCTAssertEqual(cieXYZ.x, 0.318174375, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZ.y, 0.294146625, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZ.z, 0.158243625, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZA.xyz, cieXYZ)
        XCTAssertEqual(cieXYZA.alpha, rgba.alpha)
    }

    func testCreationFromRGBAWithIntegers() {
        let rgb = RGB<UInt8>(red: 0x10, green: 0x20, blue: 0x30)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

        let cieXYZ = CIE.XYZ(rgb: rgb)
        let cieXYZA = CIE.XYZA(rgba: rgba)

        XCTAssertEqual(cieXYZ.x, 26)
        XCTAssertEqual(cieXYZ.y, 29)
        XCTAssertEqual(cieXYZ.z, 49)
        XCTAssertEqual(cieXYZA.xyz, cieXYZ)
        XCTAssertEqual(cieXYZA.alpha, rgba.alpha)
    }
}
