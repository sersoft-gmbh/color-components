import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

final class CIEXYZA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let cieXYZ = CIE.XYZ<CGFloat>(x: 0.25, y: 0.5, z: 0.75)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

        let opaqueColor = cieXYZ.cgColor
        let alphaColor = cieXYZA.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0.25)
        XCTAssertEqual(opaqueColor.components, [0.25, 0.5, 0.75, 1.0])
        XCTAssertEqual(alphaColor.components, [0.25, 0.5, 0.75, 0.25])
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: CGColorSpace.genericXYZ))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: CGColorSpace.genericXYZ))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: CGColorSpace.genericXYZ as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))

        let cieXYZ = CIE.XYZ<CGFloat>(cgColor)
        let cieXYZA = CIE.XYZA<CGFloat>(cgColor)

        XCTAssertEqual(cieXYZ.x, 0.5625)
        XCTAssertEqual(cieXYZA.x, 0.5625)
        XCTAssertEqual(cieXYZ.y, 0.75)
        XCTAssertEqual(cieXYZA.y, 0.75)
        XCTAssertEqual(cieXYZ.z, 0.375)
        XCTAssertEqual(cieXYZA.z, 0.375)
        XCTAssertEqual(cieXYZA.alpha, 0.5)
        XCTAssertNotNil(CIE.XYZ<CGFloat>(exactly: cgColor))
        XCTAssertNotNil(CIE.XYZA<CGFloat>(exactly: cgColor))
        XCTAssertNil(CIE.XYZ<InexactFloat>(exactly: cgColor))
        XCTAssertNil(CIE.XYZA<InexactFloat>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCGColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let cieXYZ = CIE.XYZ<UInt8>(x: 0x40, y: 0x80, z: 0xB0)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

        let opaqueColor = cieXYZ.cgColor
        let alphaColor = cieXYZA.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0x40 / 0xFF)
        XCTAssertEqual(opaqueColor.components, CIE.XYZ<CGFloat>(cieXYZ).cgColor.components)
        XCTAssertEqual(alphaColor.components, CIE.XYZA<CGFloat>(cieXYZA).cgColor.components)
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: CGColorSpace.genericXYZ))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: CGColorSpace.genericXYZ))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: CGColorSpace.genericXYZ as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.5625, 0.75, 0.375, 0.5]))

        let cieXYZ = CIE.XYZ<UInt8>(cgColor)
        let cieXYZA = CIE.XYZA<UInt8>(cgColor)

        XCTAssertEqual(cieXYZ.x, .init(0.5625 * 0xFF))
        XCTAssertEqual(cieXYZA.x, .init(0.5625 * 0xFF))
        XCTAssertEqual(cieXYZ.y, .init(0.75 * 0xFF))
        XCTAssertEqual(cieXYZA.y, .init(0.75 * 0xFF))
        XCTAssertEqual(cieXYZ.z, .init(0.375 * 0xFF))
        XCTAssertEqual(cieXYZA.z, .init(0.375 * 0xFF))
        XCTAssertEqual(cieXYZA.alpha, .init(0.5 * 0xFF))
        XCTAssertNotNil(try CIE.XYZ<UInt8>(exactly: XCTUnwrap(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))))
        XCTAssertNotNil(try CIE.XYZA<UInt8>(exactly: XCTUnwrap(CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1]))))
        XCTAssertNil(CIE.XYZ<Int8>(exactly: cgColor))
        XCTAssertNil(CIE.XYZ<Int8>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }
}
