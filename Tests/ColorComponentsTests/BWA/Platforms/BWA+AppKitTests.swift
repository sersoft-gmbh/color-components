import XCTest
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

final class BWA_AppKitTests: XCTestCase {
    func testNSColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let bw = BW<CGFloat>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        let opaqueColor = NSColor(bw)
        let alphaColor = NSColor(bwa)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, 0.25)
        XCTAssertEqual(opaqueColor.whiteComponent, 0.5)
        XCTAssertEqual(alphaColor.whiteComponent, 0.5)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color = NSColor(colorSpace: .genericGray, components: [0.5, 0.25], count: 2)

        let bw = BW<CGFloat>(color)
        let bwa = BWA<CGFloat>(color)

        XCTAssertEqual(bw.white, color.whiteComponent)
        XCTAssertEqual(bwa.white, color.whiteComponent)
        XCTAssertEqual(bwa.alpha, color.alphaComponent)
        XCTAssertNil(BW<InexactFloat>(exactly: color))
        XCTAssertNil(BWA<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testNSColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA(bw: bw, alpha: 64)

        let opaqueColor = NSColor(bw)
        let alphaColor = NSColor(bwa)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, 64 / 0xFF)
        XCTAssertEqual(opaqueColor.whiteComponent, 128 / 0xFF)
        XCTAssertEqual(alphaColor.whiteComponent, 128 / 0xFF)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color = NSColor(colorSpace: .genericGray, components: [0.75, 0.25], count: 2)

        let bw = BW<UInt8>(color)
        let bwa = BWA<UInt8>(color)

        XCTAssertEqual(bw.white, .init(0.75 * 0xFF))
        XCTAssertEqual(bwa.white, .init(0.75 * 0xFF))
        XCTAssertEqual(bwa.alpha, .init(0.25 * 0xFF))
        XCTAssertNil(BW<Int8>(exactly: color))
        XCTAssertNil(BWA<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
