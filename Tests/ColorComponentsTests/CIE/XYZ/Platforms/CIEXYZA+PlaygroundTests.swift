import XCTest
@testable import ColorComponents

final class CIEXYZ_PlaygroundTests: XCTestCase {
    func testPlaygroundColorWithFloatingPoint() throws {
        let cieXYZ = CIE.XYZ<CGFloat>(x: 0.5, y: 0.73, z: 0.1)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

        let opaquePlaygroundColor = cieXYZ._playgroundColor
        let alphaPlaygroundColor = cieXYZA._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(cieXYZ))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(cieXYZA))
#else
        XCTAssertEqual(opaquePlaygroundColor, cieXYZ.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, cieXYZA.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }

    func testPlaygroundColorWithBinaryInteger() throws {
        let cieXYZ = CIE.XYZ<UInt8>(x: 0x9A, y: 0xF3, z: 0x10)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x77)

        let opaquePlaygroundColor = cieXYZ._playgroundColor
        let alphaPlaygroundColor = cieXYZA._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(cieXYZ))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(cieXYZA))
#else
        XCTAssertEqual(opaquePlaygroundColor, cieXYZ.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, cieXYZA.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }
}
