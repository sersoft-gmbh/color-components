import XCTest
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

final class RGBA_AppKitTests: XCTestCase {
    func testNSColorCreation() throws {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let rgb = RGB<CGFloat>(red: 0.25, green: 0.5, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        let opaqueColor = NSColor(rgb)
        let alphaColor = NSColor(rgba)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, rgba.alpha)
        XCTAssertEqual(opaqueColor.redComponent, rgb.red)
        XCTAssertEqual(alphaColor.redComponent, rgba.red)
        XCTAssertEqual(opaqueColor.greenComponent, rgb.green)
        XCTAssertEqual(alphaColor.greenComponent, rgba.green)
        XCTAssertEqual(opaqueColor.blueComponent, rgb.blue)
        XCTAssertEqual(alphaColor.blueComponent, rgba.blue)
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromNSColor() throws {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
        
        let rgb = RGB<CGFloat>(color)
        let rgba = RGBA<CGFloat>(color)

        XCTAssertEqual(rgb.red, color.redComponent)
        XCTAssertEqual(rgba.red, color.redComponent)
        XCTAssertEqual(rgb.green, color.greenComponent)
        XCTAssertEqual(rgba.green, color.greenComponent)
        XCTAssertEqual(rgb.blue, color.blueComponent)
        XCTAssertEqual(rgba.blue, color.blueComponent)
        XCTAssertEqual(rgba.alpha, color.alphaComponent)
        XCTAssertNil(RGB<InexactFloat>(exactly: color))
        XCTAssertNil(RGBA<InexactFloat>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }
}
