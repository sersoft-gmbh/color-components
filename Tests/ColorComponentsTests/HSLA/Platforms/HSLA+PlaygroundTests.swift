import XCTest
@testable import ColorComponents

final class HSLA_PlaygroundTests: XCTestCase {
    func testPlaygroundColorWithFloatingPoint() throws {
        let hsl = HSL<CGFloat>(hue: 0.5, saturation: 0.73, luminance: 0.89)
        let hsla = HSLA(hsl: hsl, alpha: 0.25)

        let opaquePlaygroundColor = hsl._playgroundColor
        let alphaPlaygroundColor = hsla._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(hsl))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(hsla))
#else
        XCTAssertEqual(opaquePlaygroundColor, hsl.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, hsla.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }

    func testPlaygroundColorWithBinaryInteger() throws {
        let hsl = HSL<UInt8>(hue: 0x9A, saturation: 0xF3, luminance: 0xFA)
        let hsla = HSLA(hsl: hsl, alpha: 0x77)

        let opaquePlaygroundColor = hsl._playgroundColor
        let alphaPlaygroundColor = hsla._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(hsl))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(hsla))
#else
        XCTAssertEqual(opaquePlaygroundColor, hsl.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, hsla.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }
}
