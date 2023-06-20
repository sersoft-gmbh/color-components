import XCTest
import ColorComponents

final class RGBA_CIEXYZATests: XCTestCase {
    func testCreationFromCIEXYZA() {
        let cieXYZ = CIE.XYZ<Double>(x: 0.4, y: 0.5, z: 0.75)
        let cieXYZA = CIE.XYZA<Double>(xyz: cieXYZ, alpha: 0.9)

        let rgb = RGB(cieXYZ: cieXYZ)
        let rgba = RGBA(cieXYZA: cieXYZA)

        XCTAssertEqual(rgb.red, 0.15371535, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.5814606, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.71322095, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, cieXYZA.alpha)
    }

    func testCreationFromCIEXYZA_WithIntegers() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 0xFA, y: 0x80, z: 0xB0)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFA)

        let rgb = RGB(cieXYZ: cieXYZ)
        let rgba = RGBA(cieXYZA: cieXYZA)

        XCTAssertEqual(rgb.red, 0xFF)
        XCTAssertEqual(rgb.green, 0x05)
        XCTAssertEqual(rgb.blue, 0xAD)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, cieXYZA.alpha)
    }
}
