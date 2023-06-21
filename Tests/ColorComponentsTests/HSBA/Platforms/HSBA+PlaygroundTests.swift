import XCTest
@testable import ColorComponents

final class HSBA_PlaygroundTests: XCTestCase {
    func testPlaygroundColorWithFloatingPoint() throws {
        let hsb = HSB<CGFloat>(hue: 0.5, saturation: 0.73, brightness: 0.89)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        let opaquePlaygroundColor = hsb._playgroundColor
        let alphaPlaygroundColor = hsba._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(hsb))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(hsba))
#else
        XCTAssertEqual(opaquePlaygroundColor, hsb.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, hsba.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }

    func testPlaygroundColorWithBinaryInteger() throws {
        let hsb = HSB<UInt8>(hue: 0x9A, saturation: 0xF3, brightness: 0xFA)
        let hsba = HSBA(hsb: hsb, alpha: 0x77)

        let opaquePlaygroundColor = hsb._playgroundColor
        let alphaPlaygroundColor = hsba._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(hsb))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(hsba))
#else
        XCTAssertEqual(opaquePlaygroundColor, hsb.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, hsba.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }
}
