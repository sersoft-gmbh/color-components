import XCTest
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

final class CIEXYZA_AppKitTests: XCTestCase {
    func testNSColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let cieXYZ = CIE.XYZ<CGFloat>(x: 0.25, y: 0.5, z: 0.75)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)
        let rgb = RGB(cieXYZ: cieXYZ)

        let opaqueColor = NSColor(cieXYZ)
        let alphaColor = NSColor(cieXYZA)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, cieXYZA.alpha)
        XCTAssertEqual(opaqueColor.redComponent, rgb.red)
        XCTAssertEqual(alphaColor.redComponent, rgb.red)
        XCTAssertEqual(opaqueColor.greenComponent, rgb.green)
        XCTAssertEqual(alphaColor.greenComponent, rgb.green)
        XCTAssertEqual(opaqueColor.blueComponent, rgb.blue)
        XCTAssertEqual(alphaColor.blueComponent, rgb.blue)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color: NSColor
        if #available(macOS 10.12, *) {
            color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
        } else {
            color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
        }

        let cieXYZ = CIE.XYZ<CGFloat>(color)
        let cieXYZA = CIE.XYZA<CGFloat>(color)

        let cieXYZViaRGB = CIE.XYZ(rgb: RGB<CGFloat>(color))

        XCTAssertEqual(cieXYZ.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZA.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZ.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZA.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZ.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.alpha, color.alphaComponent)
        XCTAssertNil(CIE.XYZ<InexactFloat>(exactly: color))
        XCTAssertNil(CIE.XYZA<InexactFloat>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }

    func testNSColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let cieXYZ = CIE.XYZ<UInt8>(x: 0x30, y: 090, z: 0xA0)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

        let rgb = RGB(cieXYZ: CIE.XYZ<CGFloat>(cieXYZ))

        let opaqueColor = NSColor(cieXYZ)
        let alphaColor = NSColor(cieXYZA)

        XCTAssertEqual(opaqueColor.alphaComponent, 1)
        XCTAssertEqual(alphaColor.alphaComponent, .init(cieXYZA.alpha) / 0xFF, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.redComponent, rgb.red, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.redComponent, rgb.red, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.greenComponent, rgb.green, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.greenComponent, rgb.green, accuracy: .ulpOfOne)
        XCTAssertEqual(opaqueColor.blueComponent, rgb.blue, accuracy: .ulpOfOne)
        XCTAssertEqual(alphaColor.blueComponent, rgb.blue, accuracy: .ulpOfOne)
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color: NSColor
        if #available(macOS 10.12, *) {
            color = NSColor(red: 0.25, green: 0.5, blue: 0.75, alpha: 0.25)
        } else {
            color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
        }

        let cieXYZ = CIE.XYZ<UInt8>(color)
        let cieXYZA = CIE.XYZA<UInt8>(color)

        let cieXYZViaRGB = CIE.XYZ<UInt8>(CIE.XYZ(rgb: RGB<CGFloat>(color)))

        XCTAssertEqual(cieXYZ.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZA.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZ.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZA.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZ.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.alpha, .init(color.alphaComponent * 0xFF))
        XCTAssertNil(CIE.XYZ<Int8>(exactly: color))
        XCTAssertNil(CIE.XYZA<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
    }
}
