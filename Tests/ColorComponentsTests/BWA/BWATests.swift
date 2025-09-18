import Testing
import ColorComponents

@Suite
struct BWATests {
    @Test
    func simpleCreation() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)
        let bwa2 = BWA<UInt8>(white: 128, alpha: 0xFF)
        #expect(bw.white == 128)
        #expect(bwa.bw == bw)
        #expect(bwa.bw.white == 128)
        #expect(bwa2.bw.white == 128)
        #expect(bwa.alpha == 0xFF)
        #expect(bwa2.alpha == 0xFF)
        #expect(bwa == bwa2)
    }

    @Test
    func modification() {
        var bwa = BWA<UInt8>(white: 128, alpha: 0xFF)
        bwa.white = 120
        #expect(bwa.white == 120)
        #expect(bwa.bw.white == 120)
    }

    @Test
    func integerToIntegerConversion() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        let bwInt = BW<Int>(bw)
        let bwaInt = BWA<Int>(bwa)

        #expect(bwInt.white == Int(bw.white))
        #expect(bwaInt.white == Int(bwa.white))
        #expect(bwaInt.alpha == Int(bwa.alpha))
    }

    @Test
    func exactIntegerToIntegerConversion() throws {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        #expect(BW<Int8>(exactly: bw) == nil)
        #expect(BWA<Int8>(exactly: bwa) == nil)

        #expect(BW<UInt>(exactly: bw)?.white == UInt(bw.white))

        let bwaExact = try #require(BWA<UInt>(exactly: bwa))
        #expect(bwaExact.white == UInt(bwa.white))
        #expect(bwaExact.alpha == UInt(bwa.alpha))
    }

    @Test
    func floatToIntegerConversion() {
        let bw = BW<Float>(white: 0.5)
        let bwa = BWA<Float>(bw: bw, alpha: 1)

        let bwInt = BW<Int>(bw)
        let bwaInt = BWA<Int>(bwa)

        #expect(bwInt.white == Int(bw.white * 0xFF))
        #expect(bwaInt.white == Int(bwa.white * 0xFF))
        #expect(bwaInt.alpha == Int(bwa.alpha * 0xFF))
    }

    @Test
    func exactFloatToIntegerConversion() throws {
        let bw = BW<Float>(white: 1)
        let bwa = BWA<Float>(bw: bw, alpha: 1)

        #expect(BW<Int8>(exactly: bw) == nil)
        #expect(BWA<Int8>(exactly: bwa) == nil)

        #expect(BW<UInt8>(exactly: bw)?.white == UInt8(bw.white * 0xFF))

        let bwaExact = try #require(BWA<UInt8>(exactly: bwa))
        #expect(bwaExact.white == UInt8(bwa.white * 0xFF))
        #expect(bwaExact.alpha == UInt8(bwa.alpha * 0xFF))
    }

    @Test
    func floatToFloatConversion() {
        let bw = BW<Float>(white: 0.5)
        let bwa = BWA<Float>(bw: bw, alpha: 1)

        let bwDbl = BW<Double>(bw)
        let bwaDbl = BWA<Double>(bwa)

        #expect(bwDbl.white == Double(bw.white))
        #expect(bwaDbl.white == Double(bwa.white))
        #expect(bwaDbl.alpha == Double(bwa.alpha))
    }

    @Test
    func exactFloatToFloatConversion() throws {
        let bw = BW<Double>(white: 0.5)
        let bwa = BWA<Double>(bw: bw, alpha: 1)

        #expect(BW<InexactFloat>(exactly: bw) == nil)
        #expect(BWA<InexactFloat>(exactly: bwa) == nil)

        #expect(BW<Float>(exactly: bw)?.white == Float(bw.white))

        let bwaExact = try #require(BWA<Float>(exactly: bwa))
        #expect(bwaExact.white == Float(bwa.white))
        #expect(bwaExact.alpha == Float(bwa.alpha))
    }

    @Test
    func integerToFloatConversion() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        let bwInt = BW<Double>(bw)
        let bwaInt = BWA<Double>(bwa)

        #expect(bwInt.white == Double(bw.white) / 0xFF)
        #expect(bwaInt.white == Double(bwa.white) / 0xFF)
        #expect(bwaInt.alpha == Double(bwa.alpha) / 0xFF)
    }

    @Test
    func exactIntegerToFloatConversion() throws {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        #expect(BW<InexactFloat>(exactly: bw) == nil)
        #expect(BWA<InexactFloat>(exactly: bwa) == nil)

        #expect(BW<Double>(exactly: bw)?.white == Double(bw.white) / 0xFF)

        let bwaExact = try #require(BWA<Double>(exactly: bwa))
        #expect(bwaExact.white == Double(bwa.white) / 0xFF)
        #expect(bwaExact.alpha == Double(bwa.alpha) / 0xFF)
    }

    @Test
    func floatingPointColorComponentsConformance() {
        var bw = BW<Double>(white: 0.5)
        var bwa = BWA<Double>(bw: bw, alpha: 1)
        #expect(bw.brightness == bw.white)
        #expect(bwa.brightness == bwa.white)
        bw.changeBrightness(by: 0.1)
        bwa.changeBrightness(by: 0.1)
        #expect(bw.brightness == bw.white)
        #expect(bwa.brightness == bwa.white)
        #expect(bw.brightness == 0.6)
        #expect(bwa.brightness == 0.6)
    }
}
