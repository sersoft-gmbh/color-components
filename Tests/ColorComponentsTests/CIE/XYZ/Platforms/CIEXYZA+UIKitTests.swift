import XCTest
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

final class CIEXYZA_UIKitTests: XCTestCase {
    func testUIColorCreationWithFloatingPoint() throws {
#if canImport(UIKit)
        let cieXYZ = CIE.XYZ<CGFloat>(x: 0.5, y: 0.25, z: 0.75)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

        let rgb = RGB(cieXYZ: cieXYZ)

        let opaqueColor = UIColor(cieXYZ)
        let alphaColor = UIColor(cieXYZA)

        var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        XCTAssertEqual(red, rgb.red)
        XCTAssertEqual(green, rgb.green)
        XCTAssertEqual(blue, rgb.blue)
        XCTAssertEqual(alpha, 1)
        (red, green, blue, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        XCTAssertEqual(red, rgb.red)
        XCTAssertEqual(green, rgb.green)
        XCTAssertEqual(blue, rgb.blue)
        XCTAssertEqual(alpha, cieXYZA.alpha)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromUIColorWithFloatingPoint() throws {
#if canImport(UIKit)
        let red: CGFloat = 0.5
        let green: CGFloat = 0.25
        let blue: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)

        let cieXYZ = CIE.XYZ<CGFloat>(color)
        let cieXYZA = CIE.XYZA<CGFloat>(color)

        let cieXYZViaRGB = CIE.XYZ(rgb: RGB(red: red, green: green, blue: blue))

        XCTAssertEqual(cieXYZ.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZA.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZ.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZA.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZ.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.alpha, alpha)
        XCTAssertNil(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)))
        XCTAssertNil(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)))
        XCTAssertNil(RGB<InexactFloat>(exactly: color))
        XCTAssertNil(RGB<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testUIColorCreationWithInteger() throws {
#if canImport(UIKit)
        let cieXYZ = CIE.XYZ<UInt8>(x: 0x80, y: 0x40, z: 0xB0)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

        let rgb = RGB(cieXYZ: CIE.XYZ<CGFloat>(cieXYZ))

        let opaqueColor = UIColor(cieXYZ)
        let alphaColor = UIColor(cieXYZA)

        var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        XCTAssertEqual(red, rgb.red)
        XCTAssertEqual(green, rgb.green)
        XCTAssertEqual(blue, rgb.blue)
        XCTAssertEqual(alpha, 1)
        (red, green, blue, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        XCTAssertEqual(red, rgb.red)
        XCTAssertEqual(green, rgb.green)
        XCTAssertEqual(blue, rgb.blue)
        XCTAssertEqual(alpha, .init(cieXYZA.alpha) / 0xFF)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromUIColorWithInteger() throws {
#if canImport(UIKit)
        let red: CGFloat = 0.5
        let green: CGFloat = 0.25
        let blue: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)

        let cieXYZ = CIE.XYZ<UInt8>(color)
        let cieXYZA = CIE.XYZA<UInt8>(color)

        let cieXYZViaRGB = CIE.XYZ<UInt8>(CIE.XYZ(rgb: RGB(red: red, green: green, blue: blue)))


        XCTAssertEqual(cieXYZ.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZA.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZ.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZA.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZ.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.alpha, .init(alpha * 0xFF))
        XCTAssertNil(RGB<Int8>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)))
        XCTAssertNil(RGB<Int8>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)))
        XCTAssertNil(RGB<Int8>(exactly: color))
        XCTAssertNil(RGB<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
