import XCTest
import ColorComponents

final class CIEXYZATests: XCTestCase {
    func testSimpleCreation() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)
        let cieXYZA2 = CIE.XYZA<UInt8>(x: 128, y: 64, z: 32, alpha: 0xFF)
        XCTAssertEqual(cieXYZ.x, 128)
        XCTAssertEqual(cieXYZ.y, 64)
        XCTAssertEqual(cieXYZ.z, 32)
        XCTAssertEqual(cieXYZA.xyz, cieXYZ)
        XCTAssertEqual(cieXYZA.xyz.x, 128)
        XCTAssertEqual(cieXYZA.xyz.y, 64)
        XCTAssertEqual(cieXYZA.xyz.z, 32)
        XCTAssertEqual(cieXYZA2.xyz.x, 128)
        XCTAssertEqual(cieXYZA2.xyz.y, 64)
        XCTAssertEqual(cieXYZA2.xyz.z, 32)
        XCTAssertEqual(cieXYZA.alpha, 0xFF)
        XCTAssertEqual(cieXYZA2.alpha, 0xFF)
        XCTAssertEqual(cieXYZA, cieXYZA2)
    }

    func testModification() {
        var cieXYZA = CIE.XYZA<UInt8>(x: 128, y: 64, z: 32, alpha: 0xFF)
        cieXYZA.x = 120
        cieXYZA.y = 60
        cieXYZA.z = 30
        XCTAssertEqual(cieXYZA.x, 120)
        XCTAssertEqual(cieXYZA.xyz.x, 120)
        XCTAssertEqual(cieXYZA.y, 60)
        XCTAssertEqual(cieXYZA.xyz.y, 60)
        XCTAssertEqual(cieXYZA.z, 30)
        XCTAssertEqual(cieXYZA.xyz.z, 30)
    }

    func testIntegerToIntegerConversion() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        let cieXYZInt = CIE.XYZ<Int>(cieXYZ)
        let cieXYZAInt = CIE.XYZA<Int>(cieXYZA)

        XCTAssertEqual(cieXYZInt.x, .init(cieXYZ.x))
        XCTAssertEqual(cieXYZAInt.x, .init(cieXYZA.x))
        XCTAssertEqual(cieXYZInt.y, .init(cieXYZ.y))
        XCTAssertEqual(cieXYZAInt.y, .init(cieXYZA.y))
        XCTAssertEqual(cieXYZInt.z, .init(cieXYZ.z))
        XCTAssertEqual(cieXYZAInt.z, .init(cieXYZA.z))
        XCTAssertEqual(cieXYZAInt.alpha, .init(cieXYZA.alpha))
    }

    func testExactIntegerToIntegerConversion() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        let cieXYZExact = CIE.XYZ<UInt>(exactly: cieXYZ)
        let cieXYZAExact = CIE.XYZA<UInt>(exactly: cieXYZA)

        XCTAssertNil(CIE.XYZ<Int8>(exactly: cieXYZ))
        XCTAssertNil(CIE.XYZA<Int8>(exactly: cieXYZA))
        XCTAssertNotNil(cieXYZExact)
        XCTAssertNotNil(cieXYZAExact)
        XCTAssertEqual(cieXYZExact?.x, .init(cieXYZ.x))
        XCTAssertEqual(cieXYZAExact?.x, .init(cieXYZA.x))
        XCTAssertEqual(cieXYZExact?.y, .init(cieXYZ.y))
        XCTAssertEqual(cieXYZAExact?.y, .init(cieXYZA.y))
        XCTAssertEqual(cieXYZExact?.z, .init(cieXYZ.z))
        XCTAssertEqual(cieXYZAExact?.z, .init(cieXYZA.z))
        XCTAssertEqual(cieXYZAExact?.alpha, .init(cieXYZA.alpha))
    }

    func testFloatToIntegerConversion() {
        let cieXYZ = CIE.XYZ<Float>(x: 0.5, y: 0.25, z: 0.125)
        let cieXYZA = CIE.XYZA<Float>(xyz: cieXYZ, alpha: 1)

        let cieXYZInt = CIE.XYZ<Int>(cieXYZ)
        let cieXYZAInt = CIE.XYZA<Int>(cieXYZA)

        XCTAssertEqual(cieXYZInt.x, .init(cieXYZ.x * 0xFF))
        XCTAssertEqual(cieXYZAInt.x, .init(cieXYZA.x * 0xFF))
        XCTAssertEqual(cieXYZInt.y, .init(cieXYZ.y * 0xFF))
        XCTAssertEqual(cieXYZAInt.y, .init(cieXYZA.y * 0xFF))
        XCTAssertEqual(cieXYZInt.z, .init(cieXYZ.z * 0xFF))
        XCTAssertEqual(cieXYZAInt.z, .init(cieXYZA.z * 0xFF))
        XCTAssertEqual(cieXYZAInt.alpha, .init(cieXYZA.alpha * 0xFF))
    }

    func testExactFloatToIntegerConversion() {
        let cieXYZ = CIE.XYZ<Float>(x: 1, y: 0, z: 1)
        let cieXYZA = CIE.XYZA<Float>(xyz: cieXYZ, alpha: 1)

        let cieXYZExact = CIE.XYZ<UInt8>(exactly: cieXYZ)
        let cieXYZAExact = CIE.XYZA<UInt8>(exactly: cieXYZA)

        XCTAssertNil(CIE.XYZ<Int8>(exactly: cieXYZ))
        XCTAssertNil(CIE.XYZA<Int8>(exactly: cieXYZA))
        XCTAssertNotNil(cieXYZExact)
        XCTAssertNotNil(cieXYZAExact)
        XCTAssertEqual(cieXYZExact?.x, .init(cieXYZ.x * 0xFF))
        XCTAssertEqual(cieXYZAExact?.x, .init(cieXYZA.x * 0xFF))
        XCTAssertEqual(cieXYZExact?.y, .init(cieXYZ.y * 0xFF))
        XCTAssertEqual(cieXYZAExact?.y, .init(cieXYZA.y * 0xFF))
        XCTAssertEqual(cieXYZExact?.z, .init(cieXYZ.z * 0xFF))
        XCTAssertEqual(cieXYZAExact?.z, .init(cieXYZA.z * 0xFF))
        XCTAssertEqual(cieXYZAExact?.alpha, .init(cieXYZA.alpha * 0xFF))
    }

    func testFloatToFloatConversion() {
        let cieXYZ = CIE.XYZ<Float>(x: 0.5, y: 0.25, z: 0.125)
        let cieXYZA = CIE.XYZA<Float>(xyz: cieXYZ, alpha: 1)

        let cieXYZDbl = CIE.XYZ<Double>(cieXYZ)
        let cieXYZADbl = CIE.XYZA<Double>(cieXYZA)

        XCTAssertEqual(cieXYZDbl.x, .init(cieXYZ.x))
        XCTAssertEqual(cieXYZADbl.x, .init(cieXYZA.x))
        XCTAssertEqual(cieXYZDbl.y, .init(cieXYZ.y))
        XCTAssertEqual(cieXYZADbl.y, .init(cieXYZA.y))
        XCTAssertEqual(cieXYZDbl.z, .init(cieXYZ.z))
        XCTAssertEqual(cieXYZADbl.z, .init(cieXYZA.z))
        XCTAssertEqual(cieXYZADbl.alpha, .init(cieXYZA.alpha))
    }

    func testExactFloatToFloatConversion() {
        let cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.125)
        let cieXYZA = CIE.XYZA<Double>(xyz: cieXYZ, alpha: 1)

        let cieXYZExact = CIE.XYZ<Float>(exactly: cieXYZ)
        let cieXYZAExact = CIE.XYZA<Float>(exactly: cieXYZA)

        XCTAssertNil(CIE.XYZ<InexactFloat>(exactly: cieXYZ))
        XCTAssertNil(CIE.XYZA<InexactFloat>(exactly: cieXYZA))
        XCTAssertNotNil(cieXYZExact)
        XCTAssertNotNil(cieXYZAExact)
        XCTAssertEqual(cieXYZExact?.x, .init(cieXYZ.x))
        XCTAssertEqual(cieXYZAExact?.x, .init(cieXYZA.x))
        XCTAssertEqual(cieXYZExact?.y, .init(cieXYZ.y))
        XCTAssertEqual(cieXYZAExact?.y, .init(cieXYZA.y))
        XCTAssertEqual(cieXYZExact?.z, .init(cieXYZ.z))
        XCTAssertEqual(cieXYZAExact?.z, .init(cieXYZA.z))
        XCTAssertEqual(cieXYZAExact?.alpha, .init(cieXYZA.alpha))
    }

    func testIntegerToFloatConversion() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        let cieXYZInt = CIE.XYZ<Double>(cieXYZ)
        let cieXYZAInt = CIE.XYZA<Double>(cieXYZA)

        XCTAssertEqual(cieXYZInt.x, .init(cieXYZ.x) / 0xFF)
        XCTAssertEqual(cieXYZAInt.x, .init(cieXYZA.x) / 0xFF)
        XCTAssertEqual(cieXYZInt.y, .init(cieXYZ.y) / 0xFF)
        XCTAssertEqual(cieXYZAInt.y, .init(cieXYZA.y) / 0xFF)
        XCTAssertEqual(cieXYZInt.z, .init(cieXYZ.z) / 0xFF)
        XCTAssertEqual(cieXYZAInt.z, .init(cieXYZA.z) / 0xFF)
        XCTAssertEqual(cieXYZAInt.alpha, .init(cieXYZA.alpha) / 0xFF)
    }

    func testExactIntegerToFloatConversion() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        let cieXYZExact = CIE.XYZ<Double>(exactly: cieXYZ)
        let cieXYZAExact = CIE.XYZA<Double>(exactly: cieXYZA)

        XCTAssertNil(CIE.XYZ<InexactFloat>(exactly: cieXYZ))
        XCTAssertNil(CIE.XYZA<InexactFloat>(exactly: cieXYZA))
        XCTAssertNotNil(cieXYZExact)
        XCTAssertNotNil(cieXYZAExact)
        XCTAssertEqual(cieXYZExact?.x, .init(cieXYZ.x) / 0xFF)
        XCTAssertEqual(cieXYZAExact?.x, .init(cieXYZA.x) / 0xFF)
        XCTAssertEqual(cieXYZExact?.y, .init(cieXYZ.y) / 0xFF)
        XCTAssertEqual(cieXYZAExact?.y, .init(cieXYZA.y) / 0xFF)
        XCTAssertEqual(cieXYZExact?.z, .init(cieXYZ.z) / 0xFF)
        XCTAssertEqual(cieXYZAExact?.z, .init(cieXYZA.z) / 0xFF)
        XCTAssertEqual(cieXYZAExact?.alpha, .init(cieXYZA.alpha) / 0xFF)
    }

    func testFloatingPointColorComponentsConformance() {
        var cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.125)
        var cieXYZA = CIE.XYZA<Double>(xyz: cieXYZ, alpha: 1)

        cieXYZ.changeBrightness(by: 0.1)
        cieXYZA.changeBrightness(by: 0.1)

        XCTAssertEqual(cieXYZ.y, 0.35)
        XCTAssertEqual(cieXYZA.y, 0.35)
    }
}
