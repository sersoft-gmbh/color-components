import XCTest
import XCHelpers
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

final class RGBA_UIKitTests: XCTestCase {
    func testUIColorCreation() throws {
        #if canImport(UIKit)
        let rgb = RGB<CGFloat>(red: 0.5, green: 0.25, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        let opaqueColor = UIColor(rgb)
        let alphaColor = UIColor(rgba)

        var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        XCTAssertEqual(red, rgb.red)
        XCTAssertEqual(green, rgb.green)
        XCTAssertEqual(blue, rgb.blue)
        XCTAssertEqual(alpha, 1)
        (red, green, blue, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        XCTAssertEqual(red, rgba.red)
        XCTAssertEqual(green, rgba.green)
        XCTAssertEqual(blue, rgba.blue)
        XCTAssertEqual(alpha, rgba.alpha)
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromUIColor() throws {
        #if canImport(UIKit)
        let red: CGFloat = 0.5
        let green: CGFloat = 0.25
        let blue: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)

        let rgb = RGB<CGFloat>(color)
        let rgba = RGBA<CGFloat>(color)

        XCTAssertEqual(rgb.red, red)
        XCTAssertEqual(rgba.red, red)
        XCTAssertEqual(rgb.green, green)
        XCTAssertEqual(rgba.green, green)
        XCTAssertEqual(rgb.blue, blue)
        XCTAssertEqual(rgba.blue, blue)
        XCTAssertEqual(rgba.alpha, alpha)
        XCTAssertNil(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)))
        XCTAssertNil(RGB<InexactFloat>(exactly: NoCompsUIColor(red: red, green: green, blue: blue, alpha: alpha)))
        XCTAssertNil(RGB<InexactFloat>(exactly: color))
        XCTAssertNil(RGB<InexactFloat>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }
}
