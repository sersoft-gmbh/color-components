import XCTest
import ColorComponents

final class RGBA_HexTests: XCTestCase {
    func testCreationFromHex() {
        let rgb = RGB<UInt64>(hex: 0xFF8055)
        let rgba = RGBA<UInt64>(hex: 0xFF8055FA)

        XCTAssertEqual(rgb.red, 0xFF)
        XCTAssertEqual(rgb.green, 0x80)
        XCTAssertEqual(rgb.blue, 0x55)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0xFA)
    }

    func testCreationFromHexOfDifferentSize() {
        let rgb = RGB<UInt8>(hex: 0xFF8055)
        let rgba = RGBA<UInt8>(hex: 0xFF8055FA)

        XCTAssertEqual(rgb.red, 0xFF)
        XCTAssertEqual(rgb.green, 0x80)
        XCTAssertEqual(rgb.blue, 0x55)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0xFA)
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

    func testHexString() {
        let rgb = RGB(red: 0xFF, green: 0x08, blue: 0x55)
        let rgba = RGBA(rgb: rgb, alpha: 0xFA)

        XCTAssertEqual(rgb.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855;")
        XCTAssertEqual(rgba.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855FA;")
    }
}
