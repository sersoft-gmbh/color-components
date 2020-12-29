#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import XCTest
import AppKit
import ColorComponents

final class BWA_AppKitTests: XCTestCase {
    func testNSColorCreation() {
        let bw = BW<CGFloat>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        let opaqueColor = NSColor(bw)
        let alphaColor = NSColor(bwa)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, 0.25)
        XCTAssertEqual(opaqueColor.whiteComponent, 0.5)
        XCTAssertEqual(alphaColor.whiteComponent, 0.5)
    }

    func testCreationFromNSColor() {
        let color = NSColor(colorSpace: .genericGray, components: [0.5, 0.25], count: 2)

        let bw = BW<CGFloat>(color)
        let bwa = BWA<CGFloat>(color)

        XCTAssertEqual(bw.white, color.whiteComponent)
        XCTAssertEqual(bwa.white, color.whiteComponent)
        XCTAssertEqual(bwa.alpha, color.alphaComponent)
        XCTAssertNil(BW<InexactFloat>(exactly: color))
        XCTAssertNil(BWA<InexactFloat>(exactly: color))
    }
}
#endif
