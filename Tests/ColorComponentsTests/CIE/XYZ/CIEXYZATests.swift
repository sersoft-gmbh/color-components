import Testing
import ColorComponents

@Suite
struct CIEXYZATests {
    @Test
    func simpleCreation() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)
        let cieXYZA2 = CIE.XYZA<UInt8>(x: 128, y: 64, z: 32, alpha: 0xFF)
        #expect(cieXYZ.x == 128)
        #expect(cieXYZ.y == 64)
        #expect(cieXYZ.z == 32)
        #expect(cieXYZA.xyz == cieXYZ)
        #expect(cieXYZA.xyz.x == 128)
        #expect(cieXYZA.xyz.y == 64)
        #expect(cieXYZA.xyz.z == 32)
        #expect(cieXYZA2.xyz.x == 128)
        #expect(cieXYZA2.xyz.y == 64)
        #expect(cieXYZA2.xyz.z == 32)
        #expect(cieXYZA.alpha == 0xFF)
        #expect(cieXYZA2.alpha == 0xFF)
        #expect(cieXYZA == cieXYZA2)
    }

    @Test
    func modification() {
        var cieXYZA = CIE.XYZA<UInt8>(x: 128, y: 64, z: 32, alpha: 0xFF)
        cieXYZA.x = 120
        cieXYZA.y = 60
        cieXYZA.z = 30
        #expect(cieXYZA.x == 120)
        #expect(cieXYZA.xyz.x == 120)
        #expect(cieXYZA.y == 60)
        #expect(cieXYZA.xyz.y == 60)
        #expect(cieXYZA.z == 30)
        #expect(cieXYZA.xyz.z == 30)
    }

    @Test
    func integerToIntegerConversion() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        let cieXYZInt = CIE.XYZ<Int>(cieXYZ)
        let cieXYZAInt = CIE.XYZA<Int>(cieXYZA)

        #expect(cieXYZInt.x == Int(cieXYZ.x))
        #expect(cieXYZAInt.x == Int(cieXYZA.x))
        #expect(cieXYZInt.y == Int(cieXYZ.y))
        #expect(cieXYZAInt.y == Int(cieXYZA.y))
        #expect(cieXYZInt.z == Int(cieXYZ.z))
        #expect(cieXYZAInt.z == Int(cieXYZA.z))
        #expect(cieXYZAInt.alpha == Int(cieXYZA.alpha))
    }

    @Test
    func exactIntegerToIntegerConversion() throws {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        #expect(CIE.XYZ<Int8>(exactly: cieXYZ) == nil)
        #expect(CIE.XYZA<Int8>(exactly: cieXYZA) == nil)

        let cieXYZExact = try #require(CIE.XYZ<UInt>(exactly: cieXYZ))
        let cieXYZAExact = try #require(CIE.XYZA<UInt>(exactly: cieXYZA))

        #expect(cieXYZExact.x == UInt(cieXYZ.x))
        #expect(cieXYZAExact.x == UInt(cieXYZA.x))
        #expect(cieXYZExact.y == UInt(cieXYZ.y))
        #expect(cieXYZAExact.y == UInt(cieXYZA.y))
        #expect(cieXYZExact.z == UInt(cieXYZ.z))
        #expect(cieXYZAExact.z == UInt(cieXYZA.z))
        #expect(cieXYZAExact.alpha == UInt(cieXYZA.alpha))
    }

    @Test
    func floatToIntegerConversion() {
        let cieXYZ = CIE.XYZ<Float>(x: 0.5, y: 0.25, z: 0.125)
        let cieXYZA = CIE.XYZA<Float>(xyz: cieXYZ, alpha: 1)

        let cieXYZInt = CIE.XYZ<Int>(cieXYZ)
        let cieXYZAInt = CIE.XYZA<Int>(cieXYZA)

        #expect(cieXYZInt.x == Int(cieXYZ.x * 0xFF))
        #expect(cieXYZAInt.x == Int(cieXYZA.x * 0xFF))
        #expect(cieXYZInt.y == Int(cieXYZ.y * 0xFF))
        #expect(cieXYZAInt.y == Int(cieXYZA.y * 0xFF))
        #expect(cieXYZInt.z == Int(cieXYZ.z * 0xFF))
        #expect(cieXYZAInt.z == Int(cieXYZA.z * 0xFF))
        #expect(cieXYZAInt.alpha == Int(cieXYZA.alpha * 0xFF))
    }

    @Test
    func exactFloatToIntegerConversion() throws {
        let cieXYZ = CIE.XYZ<Float>(x: 1, y: 0, z: 1)
        let cieXYZA = CIE.XYZA<Float>(xyz: cieXYZ, alpha: 1)

        #expect(CIE.XYZ<Int8>(exactly: cieXYZ) == nil)
        #expect(CIE.XYZA<Int8>(exactly: cieXYZA) == nil)

        let cieXYZExact = try #require(CIE.XYZ<UInt8>(exactly: cieXYZ))
        let cieXYZAExact = try #require(CIE.XYZA<UInt8>(exactly: cieXYZA))

        #expect(cieXYZExact.x == UInt8(cieXYZ.x * 0xFF))
        #expect(cieXYZAExact.x == UInt8(cieXYZA.x * 0xFF))
        #expect(cieXYZExact.y == UInt8(cieXYZ.y * 0xFF))
        #expect(cieXYZAExact.y == UInt8(cieXYZA.y * 0xFF))
        #expect(cieXYZExact.z == UInt8(cieXYZ.z * 0xFF))
        #expect(cieXYZAExact.z == UInt8(cieXYZA.z * 0xFF))
        #expect(cieXYZAExact.alpha == UInt8(cieXYZA.alpha * 0xFF))
    }

    @Test
    func floatToFloatConversion() {
        let cieXYZ = CIE.XYZ<Float>(x: 0.5, y: 0.25, z: 0.125)
        let cieXYZA = CIE.XYZA<Float>(xyz: cieXYZ, alpha: 1)

        let cieXYZDbl = CIE.XYZ<Double>(cieXYZ)
        let cieXYZADbl = CIE.XYZA<Double>(cieXYZA)

        #expect(cieXYZDbl.x == Double(cieXYZ.x))
        #expect(cieXYZADbl.x == Double(cieXYZA.x))
        #expect(cieXYZDbl.y == Double(cieXYZ.y))
        #expect(cieXYZADbl.y == Double(cieXYZA.y))
        #expect(cieXYZDbl.z == Double(cieXYZ.z))
        #expect(cieXYZADbl.z == Double(cieXYZA.z))
        #expect(cieXYZADbl.alpha == Double(cieXYZA.alpha))
    }

    @Test
    func exactFloatToFloatConversion() throws {
        let cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.125)
        let cieXYZA = CIE.XYZA<Double>(xyz: cieXYZ, alpha: 1)

        #expect(CIE.XYZ<InexactFloat>(exactly: cieXYZ) == nil)
        #expect(CIE.XYZA<InexactFloat>(exactly: cieXYZA) == nil)

        let cieXYZExact = try #require(CIE.XYZ<Float>(exactly: cieXYZ))
        let cieXYZAExact = try #require(CIE.XYZA<Float>(exactly: cieXYZA))

        #expect(cieXYZExact.x == Float(cieXYZ.x))
        #expect(cieXYZAExact.x == Float(cieXYZA.x))
        #expect(cieXYZExact.y == Float(cieXYZ.y))
        #expect(cieXYZAExact.y == Float(cieXYZA.y))
        #expect(cieXYZExact.z == Float(cieXYZ.z))
        #expect(cieXYZAExact.z == Float(cieXYZA.z))
        #expect(cieXYZAExact.alpha == Float(cieXYZA.alpha))
    }

    @Test
    func integerToFloatConversion() {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        let cieXYZInt = CIE.XYZ<Double>(cieXYZ)
        let cieXYZAInt = CIE.XYZA<Double>(cieXYZA)

        #expect(cieXYZInt.x == Double(cieXYZ.x) / 0xFF)
        #expect(cieXYZAInt.x == Double(cieXYZA.x) / 0xFF)
        #expect(cieXYZInt.y == Double(cieXYZ.y) / 0xFF)
        #expect(cieXYZAInt.y == Double(cieXYZA.y) / 0xFF)
        #expect(cieXYZInt.z == Double(cieXYZ.z) / 0xFF)
        #expect(cieXYZAInt.z == Double(cieXYZA.z) / 0xFF)
        #expect(cieXYZAInt.alpha == Double(cieXYZA.alpha) / 0xFF)
    }

    @Test
    func exactIntegerToFloatConversion() throws {
        let cieXYZ = CIE.XYZ<UInt8>(x: 128, y: 64, z: 32)
        let cieXYZA = CIE.XYZA<UInt8>(xyz: cieXYZ, alpha: 0xFF)

        #expect(CIE.XYZ<InexactFloat>(exactly: cieXYZ) == nil)
        #expect(CIE.XYZA<InexactFloat>(exactly: cieXYZA) == nil)

        let cieXYZExact = try #require(CIE.XYZ<Double>(exactly: cieXYZ))
        let cieXYZAExact = try #require(CIE.XYZA<Double>(exactly: cieXYZA))

        #expect(cieXYZExact.x == Double(cieXYZ.x) / 0xFF)
        #expect(cieXYZAExact.x == Double(cieXYZA.x) / 0xFF)
        #expect(cieXYZExact.y == Double(cieXYZ.y) / 0xFF)
        #expect(cieXYZAExact.y == Double(cieXYZA.y) / 0xFF)
        #expect(cieXYZExact.z == Double(cieXYZ.z) / 0xFF)
        #expect(cieXYZAExact.z == Double(cieXYZA.z) / 0xFF)
        #expect(cieXYZAExact.alpha == Double(cieXYZA.alpha) / 0xFF)
    }

    @Test
    func floatingPointColorComponentsConformance() {
        var cieXYZ = CIE.XYZ<Double>(x: 0.5, y: 0.25, z: 0.125)
        var cieXYZA = CIE.XYZA<Double>(xyz: cieXYZ, alpha: 1)

        cieXYZ.changeBrightness(by: 0.1)
        cieXYZA.changeBrightness(by: 0.1)

        #expect(cieXYZ.y == 0.35)
        #expect(cieXYZA.y == 0.35)
        #expect(cieXYZ.y == cieXYZ.brightness)
        #expect(cieXYZA.y == cieXYZA.brightness)
    }
}
