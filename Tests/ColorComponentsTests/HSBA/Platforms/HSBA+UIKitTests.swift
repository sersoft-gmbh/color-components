import XCTest
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

final class HSBA_UIKitTests: XCTestCase {
    func testUIColorCreation() throws {
        #if canImport(UIKit)
        let hsb = HSB<CGFloat>(hue: 0.5, saturation: 0.25, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        let opaqueColor = UIColor(hsb)
        let alphaColor = UIColor(hsba)

        var (hue, saturation, brightness, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, hsb.hue)
        XCTAssertEqual(saturation, hsb.saturation)
        XCTAssertEqual(brightness, hsb.brightness)
        XCTAssertEqual(alpha, 1)
        (hue, saturation, brightness, alpha) = (0, 0, 0, 0)
        XCTAssertTrue(alphaColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        XCTAssertEqual(hue, hsba.hue)
        XCTAssertEqual(saturation, hsba.saturation)
        XCTAssertEqual(brightness, hsba.brightness)
        XCTAssertEqual(alpha, hsba.alpha)
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromUIColor() throws {
        #if canImport(UIKit)
        let hue: CGFloat = 0.5
        let saturation: CGFloat = 0.25
        let brightness: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

        let hsb = HSB<CGFloat>(color)
        let hsba = HSBA<CGFloat>(color)

        XCTAssertEqual(hsb.hue, hue)
        XCTAssertEqual(hsba.hue, hue)
        XCTAssertEqual(hsb.saturation, saturation)
        XCTAssertEqual(hsba.saturation, saturation)
        XCTAssertEqual(hsb.brightness, brightness)
        XCTAssertEqual(hsba.brightness, brightness)
        XCTAssertEqual(hsba.alpha, alpha)
        XCTAssertNil(HSB<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSB<InexactFloat>(exactly: NoCompsUIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)))
        XCTAssertNil(HSB<InexactFloat>(exactly: color))
        XCTAssertNil(HSB<InexactFloat>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }
}
