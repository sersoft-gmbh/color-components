import XCTest
@testable import ColorComponents

final class BWA_PlaygroundTests: XCTestCase {
    func testPlaygroundColorWithFloatingPoint() throws {
        let bw = BW<CGFloat>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        let opaquePlaygroundColor = bw._playgroundColor
        let alphaPlaygroundColor = bwa._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(bw))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(bwa))
#else
        XCTAssertEqual(opaquePlaygroundColor, bw.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, bwa.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }

    func testPlaygroundColorWithBinaryInteger() throws {
        let bw = BW<UInt8>(white: 0x90)
        let bwa = BWA(bw: bw, alpha: 0x77)

        let opaquePlaygroundColor = bw._playgroundColor
        let alphaPlaygroundColor = bwa._playgroundColor

#if canImport(AppKit) || canImport(UIKit) || canImport(CoreGraphics)
        XCTAssertNotNil(opaquePlaygroundColor)
        XCTAssertNotNil(alphaPlaygroundColor)
#if canImport(AppKit) || canImport(UIKit)
        XCTAssertEqual(opaquePlaygroundColor, _PlatformColor(bw))
        XCTAssertEqual(alphaPlaygroundColor, _PlatformColor(bwa))
#else
        XCTAssertEqual(opaquePlaygroundColor, bw.cgColor)
        XCTAssertEqual(alphaPlaygroundColor, bwa.cgColor)
#endif
#else
        XCTAssertNil(opaquePlaygroundColor)
        XCTAssertNil(alphaPlaygroundColor)
#endif
    }
}
