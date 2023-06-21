import XCTest
@testable import ColorComponents

final class RGBA_PlaygroundTests: XCTestCase {
    func testPlaygroundColorWithFloatingPoint() throws {
        let rgb = RGB<CGFloat>(red: 0.5, green: 0.73, blue: 0.89)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        let opaquePlaygroundColor = rgb._playgroundColor
        let alphaPlaygroundColor = rgba._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(rgb))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(rgba))
#else
        XCTAssertEqual(opaquePlaygroundColor, rgb.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, rgba.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }

    func testPlaygroundColorWithBinaryInteger() throws {
        let rgb = RGB<UInt8>(red: 0x9A, green: 0xF3, blue: 0xFA)
        let rgba = RGBA(rgb: rgb, alpha: 0x77)

        let opaquePlaygroundColor = rgb._playgroundColor
        let alphaPlaygroundColor = rgba._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(rgb))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(rgba))
#else
        XCTAssertEqual(opaquePlaygroundColor, rgb.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, rgba.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }
}
