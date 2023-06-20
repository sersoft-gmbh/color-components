import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import ColorComponents

final class BWA_CoreGraphicsTests: XCTestCase {
    func testCGColorCreationWithFloatingPoint() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let bw = BW<CGFloat>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        let opaqueColor = bw.cgColor
        let alphaColor = bwa.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0.25)
        XCTAssertEqual(opaqueColor.components, [0.5, 1.0])
        XCTAssertEqual(alphaColor.components, [0.5, 0.25])
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithFloatingPoint() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.75, 0.5]))

        let bw = BW<CGFloat>(cgColor)
        let bwa = BWA<CGFloat>(cgColor)

        XCTAssertEqual(bw.white, 0.75)
        XCTAssertEqual(bwa.white, 0.75)
        XCTAssertEqual(bwa.alpha, 0.5)
        XCTAssertNotNil(BWA<CGFloat>(exactly: cgColor))
        XCTAssertNotNil(BW<CGFloat>(exactly: cgColor))
        XCTAssertNil(BW<InexactFloat>(exactly: cgColor))
        XCTAssertNil(BWA<InexactFloat>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCGColorCreationWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let bw = BW<UInt8>(white: 0x80)
        let bwa = BWA(bw: bw, alpha: 0x40)

        let opaqueColor = bw.cgColor
        let alphaColor = bwa.cgColor

        XCTAssertEqual(opaqueColor.alpha, 1)
        XCTAssertEqual(alphaColor.alpha, 0x40 / 0xFF)
        XCTAssertEqual(opaqueColor.components, [0x80 / 0xFF as CGFloat, 1.0])
        XCTAssertEqual(alphaColor.components, [0x80 / 0xFF as CGFloat, 0x40 / 0xFF as CGFloat])
        XCTAssertEqual(opaqueColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
        XCTAssertEqual(alphaColor.colorSpace, CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromCGColorWithInteger() throws {
#if canImport(CoreGraphics)
        guard #available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
        else { try skipUnavailableAPI() }

        let colorSpace = try XCTUnwrap(CGColorSpace(name: "kCGColorSpaceGenericGray" as CFString))
        let cgColor = try XCTUnwrap(CGColor(colorSpace: colorSpace, components: [0.75, 0.5]))

        let bw = BW<UInt8>(cgColor)
        let bwa = BWA<UInt8>(cgColor)

        XCTAssertEqual(bw.white, 0xBF)
        XCTAssertEqual(bwa.white, 0xBF)
        XCTAssertEqual(bwa.alpha, 0x7F)
        XCTAssertNil(BW<Int8>(exactly: cgColor))
        XCTAssertNil(BWA<Int8>(exactly: cgColor))
#else
        try skipUnavailableAPI()
#endif
    }
}
