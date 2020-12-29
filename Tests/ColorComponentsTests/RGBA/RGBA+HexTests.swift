import XCTest
import ColorComponents

final class RGBA_HexTests: XCTestCase {
    func testCreationFromHex() {
        let rgb = RGB(hex: 0xFF8055)
        let rgba = RGBA(hex: 0xFF8055FA)

        XCTAssertEqual(rgb.red, 0xFF)
        XCTAssertEqual(rgb.green, 0x80)
        XCTAssertEqual(rgb.blue, 0x55)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0xFA)
    }

    func testHexString() {
        let rgb = RGB(red: 0xFF, green: 0x08, blue: 0x55)
        let rgba = RGBA(rgb: rgb, alpha: 0xFA)

        XCTAssertEqual(rgb.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855;")
        XCTAssertEqual(rgba.hexString(prefix: "0x", postfix: ";", uppercase: true), "0xFF0855FA;")
    }
}
