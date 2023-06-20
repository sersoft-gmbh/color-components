import XCTest
import XCHelpers
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
#endif
#endif
import ColorComponents

final class CIEXYZA_SwiftUITests: XCTestCase {
    func testColorCreationWithFloatingPoint() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.75)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

        XCTAssertEqual(Color(cieXYZ), Color(RGB(cieXYZ: cieXYZ)))
        XCTAssertEqual(Color(cieXYZA), Color(RGBA(cieXYZA: cieXYZA)))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromColorWithFloatingPoint() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let cieXYZ = CIE.XYZ<Double>(color)
        let cieXYZA = CIE.XYZA<Double>(color)
        let cieXYZViaRGB = CIE.XYZ<Double>(rgb: RGB<Double>(color))
#elseif canImport(CoreGraphics)
        let cieXYZ = try XCTUnwrap(CIE.XYZ<Double>(color))
        let cieXYZA = try XCTUnwrap(CIE.XYZA<Double>(color))
        let cieXYZViaRGB = try CIE.XYZ<Double>(rgb: XCTUnwrap(RGB<Double>(color)))
#else
        try skipUnavailableAPI()
#endif

        XCTAssertEqual(cieXYZ.x, cieXYZViaRGB.x, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZA.x, cieXYZViaRGB.x, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZ.y, cieXYZViaRGB.y, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZA.y, cieXYZViaRGB.y, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZ.z, cieXYZViaRGB.z, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZA.z, cieXYZViaRGB.z, accuracy: .ulpOfOne)
        XCTAssertEqual(cieXYZA.alpha, 0.25)
        XCTAssertNil(CIE.XYZ<InexactFloat>(exactly: Color(white: 1)))
        XCTAssertNil(CIE.XYZA<InexactFloat>(exactly: Color(white: 1)))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }

    func testColorCreationWithInteger() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let cieXYZ = CIE.XYZ<UInt8>(x: 0x80, y: 0x40, z: 0xB0)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

        XCTAssertEqual(Color(cieXYZ), Color(RGB(cieXYZ: CIE.XYZ<Double>(cieXYZ))))
        XCTAssertEqual(Color(cieXYZA), Color(RGBA(cieXYZA: CIE.XYZA<Double>(cieXYZA))))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }

    func testCreationFromColorWithInteger() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let cieXYZ = CIE.XYZ<UInt8>(color)
        let cieXYZA = CIE.XYZA<UInt8>(color)
        let cieXYZViaRGB = CIE.XYZ<UInt8>(CIE.XYZ(rgb: RGB<Double>(color)))
#elseif canImport(CoreGraphics)
        let cieXYZ = try XCTUnwrap(CIE.XYZ<UInt8>(color))
        let cieXYZA = try XCTUnwrap(CIE.XYZA<UInt8>(color))
        let cieXYZViaRGB = try CIE.XYZ<UInt8>(CIE.XYZ(rgb: XCTUnwrap(RGB<Double>(color))))
#else
        try skipUnavailableAPI()
#endif

        XCTAssertEqual(cieXYZ.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZA.x, cieXYZViaRGB.x)
        XCTAssertEqual(cieXYZ.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZA.y, cieXYZViaRGB.y)
        XCTAssertEqual(cieXYZ.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.z, cieXYZViaRGB.z)
        XCTAssertEqual(cieXYZA.alpha, .init(0.25 * 0xFF))
        XCTAssertNil(CIE.XYZ<Int8>(exactly: color))
        XCTAssertNil(CIE.XYZA<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }

    func testViewConformance() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.75)
        let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)

        XCTAssertEqual(cieXYZ.body as? Color, Color(cieXYZ))
        XCTAssertEqual(cieXYZA.body as? Color, Color(cieXYZA))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }
}
