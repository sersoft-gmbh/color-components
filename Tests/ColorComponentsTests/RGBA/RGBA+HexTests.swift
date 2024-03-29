import XCTest
import ColorComponents

final class RGBA_HexTests: XCTestCase {
    func testCreationFromHex() {
        let rgb = RGB<UInt64>(hex: 0xFF8055)
        let rgba = RGBA<UInt64>(hex: 0xFF8055FA as UInt64)

        XCTAssertEqual(rgb.red, 0xFF)
        XCTAssertEqual(rgb.green, 0x80)
        XCTAssertEqual(rgb.blue, 0x55)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0xFA)
    }

    func testCreationFromHexOfDifferentSize() {
        let rgb = RGB<UInt8>(hex: 0xFF8055)
        let rgba = RGBA<UInt8>(hex: 0xFF8055FA as UInt64)

        XCTAssertEqual(rgb.red, 0xFF)
        XCTAssertEqual(rgb.green, 0x80)
        XCTAssertEqual(rgb.blue, 0x55)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0xFA)
    }

    func testCreationFromHexUsingFloatingPoint() {
        let rgb = RGB<Float>(hex: 0xFF8055)
        let rgba = RGBA<Float>(hex: 0xFF8055FA as UInt64)

        XCTAssertEqual(rgb.red, 1, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0x80 / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0x55 / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0xFA / 0xFF, accuracy: .ulpOfOne)
    }

    func testCreationFromHexString() {
        let rgb = RGB<UInt8>(hexString: "FF8055")
        let rgb0x = RGB<UInt8>(hexString: "0xFF8055")
        let rgbHash = RGB<UInt8>(hexString: "#FF8055")
        let rgbInvalid = RGB<UInt8>(hexString: "0xTESTIN")
        let rgba = RGBA<UInt8>(hexString: "FF8055FA")
        let rgba0x = RGBA<UInt8>(hexString: "0xFF8055FA")
        let rgbaHash = RGBA<UInt8>(hexString: "#FF8055FA")
        let rgbaInvalid = RGBA<UInt8>(hexString: "0xTESTINIT")

        XCTAssertNotNil(rgb)
        XCTAssertNotNil(rgb0x)
        XCTAssertNotNil(rgbHash)
        XCTAssertNotNil(rgba)
        XCTAssertNotNil(rgba0x)
        XCTAssertNotNil(rgbaHash)

        XCTAssertNil(rgbInvalid)
        XCTAssertNil(rgbaInvalid)

        XCTAssertEqual(rgb?.red, 0xFF)
        XCTAssertEqual(rgb?.green, 0x80)
        XCTAssertEqual(rgb?.blue, 0x55)
        XCTAssertEqual(rgba?.rgb, rgb)
        XCTAssertEqual(rgba?.alpha, 0xFA)

        XCTAssertEqual(rgb0x, rgb)
        XCTAssertEqual(rgbHash, rgb)
        XCTAssertEqual(rgba0x, rgba)
        XCTAssertEqual(rgbaHash, rgba)
    }

    func testCreationFromHexStringWithFloatingPoint() {
        let rgb = RGB<Float>(hexString: "FF8055")
        let rgb0x = RGB<Float>(hexString: "0xFF8055")
        let rgbHash = RGB<Float>(hexString: "#FF8055")
        let rgbInvalid = RGB<Float>(hexString: "0xTESTIN")
        let rgba = RGBA<Float>(hexString: "FF8055FA")
        let rgba0x = RGBA<Float>(hexString: "0xFF8055FA")
        let rgbaHash = RGBA<Float>(hexString: "#FF8055FA")
        let rgbaInvalid = RGBA<Float>(hexString: "0xTESTINIT")

        XCTAssertNotNil(rgb)
        XCTAssertNotNil(rgb0x)
        XCTAssertNotNil(rgbHash)
        XCTAssertNotNil(rgba)
        XCTAssertNotNil(rgba0x)
        XCTAssertNotNil(rgbaHash)

        XCTAssertNil(rgbInvalid)
        XCTAssertNil(rgbaInvalid)

        if let rgb {
            XCTAssertEqual(rgb.red, 1, accuracy: .ulpOfOne)
            XCTAssertEqual(rgb.green, 0x80 / 0xFF, accuracy: .ulpOfOne)
            XCTAssertEqual(rgb.blue, 0x55 / 0xFF, accuracy: .ulpOfOne)
        }
        XCTAssertEqual(rgba?.rgb, rgb)
        XCTAssertEqual(try XCTUnwrap(rgba).alpha, 0xFA / 0xFF, accuracy: .ulpOfOne)

        XCTAssertEqual(rgb0x, rgb)
        XCTAssertEqual(rgbHash, rgb)
        XCTAssertEqual(rgba0x, rgba)
        XCTAssertEqual(rgbaHash, rgba)
    }

    func testHexValue() {
        let rgb = RGB<UInt64>(red: 0xFF, green: 0x08, blue: 0x55)
        let rgba = RGBA<UInt64>(rgb: rgb, alpha: 0xFA)

        XCTAssertEqual(rgb.hexValue(), 0xFF0855)
        XCTAssertEqual(rgba.hexValue(), 0xFF0855FA as UInt64)
    }

    func testHexValueWithDifferentSize() {
        let rgb = RGB<UInt8>(red: 0xFF, green: 0x08, blue: 0x55)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

        XCTAssertEqual(rgb.hexValue(as: UInt64.self), 0xFF0855)
        XCTAssertEqual(rgba.hexValue(as: UInt64.self), 0xFF0855FA)
    }

    func testHexValueWithFloatingPoint() {
        let rgb = RGB<Float>(red: 0xFF / 0xFF, green: 0x08 / 0xFF, blue: 0x55 / 0xFF)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 0xFA / 0xFF)

        XCTAssertEqual(rgb.hexValue(as: UInt64.self), 0xFF0855)
        XCTAssertEqual(rgba.hexValue(as: UInt64.self), 0xFF0855FA)
    }

    func testHexString() {
        let rgb = RGB(red: 0xFF, green: 0x08, blue: 0x55)
        let rgba = RGBA(rgb: rgb, alpha: 0xFA)

        XCTAssertEqual(rgb.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855;")
        XCTAssertEqual(rgba.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855FA;")
    }

    func testHexStringWithFloatingPoint() {
        let rgb = RGB<Float>(red: 1, green: 0x08 / 0xFF, blue: 0x55 / 0xFF)
        let rgba = RGBA(rgb: rgb, alpha: 0xFA / 0xFF)

        XCTAssertEqual(rgb.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855;")
        XCTAssertEqual(rgba.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855FA;")
    }
}
