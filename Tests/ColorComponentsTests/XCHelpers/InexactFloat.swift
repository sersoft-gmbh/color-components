struct InexactFloat: BinaryFloatingPoint, RawRepresentable {
    typealias RawValue = Float

    typealias IntegerLiteralType = RawValue.IntegerLiteralType
    typealias FloatLiteralType = RawValue.FloatLiteralType
    typealias RawSignificand = RawValue.RawSignificand
    typealias RawExponent = RawValue.RawExponent
    typealias Exponent = RawValue.Exponent
    typealias Stride = RawValue.Stride
    typealias Magnitude = Self

    static var exponentBitCount: Int { RawValue.exponentBitCount }
    static var significandBitCount: Int { RawValue.significandBitCount }
    static var nan: Self { .init(rawValue: .nan) }
    static var signalingNaN: Self { .init(rawValue: .signalingNaN) }
    static var infinity: Self { .init(rawValue: .infinity) }
    static var greatestFiniteMagnitude: Self { .init(rawValue: .greatestFiniteMagnitude) }
    static var leastNormalMagnitude: Self { .init(rawValue: .leastNormalMagnitude) }
    static var leastNonzeroMagnitude: Self { .init(rawValue: .leastNonzeroMagnitude) }
    static var pi: Self { .init(rawValue: .pi) }

    var exponentBitPattern: RawExponent { rawValue.exponentBitPattern }
    var significandBitPattern: RawSignificand { rawValue.significandBitPattern }

    var significandWidth: Int { rawValue.significandWidth }
    var binade: Self { .init(rawValue: rawValue.binade) }
    var ulp: Self { .init(rawValue: rawValue.ulp) }

    var sign: FloatingPointSign { rawValue.sign }
    var exponent: Exponent { rawValue.exponent }
    var significand: Self { .init(rawValue: rawValue.significand) }
    var nextUp: Self { .init(rawValue: rawValue.nextUp) }
    var nextDown: Self { .init(rawValue: rawValue.nextDown) }

    var isNormal: Bool { rawValue.isNormal }
    var isFinite: Bool { rawValue.isFinite }
    var isZero: Bool { rawValue.isZero }
    var isSubnormal: Bool { rawValue.isSubnormal }
    var isInfinite: Bool { rawValue.isFinite }
    var isNaN: Bool { rawValue.isNaN }
    var isSignalingNaN: Bool { rawValue.isSignalingNaN }
    var isCanonical: Bool { rawValue.isCanonical }
    var magnitude: Magnitude { .init(rawValue: rawValue.magnitude) }

    private(set) var rawValue: RawValue

    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.init(rawValue: .init(integerLiteral: value))
    }

    init(floatLiteral value: FloatLiteralType) {
        self.init(rawValue: .init(floatLiteral: value))
    }

    init(sign: FloatingPointSign, exponentBitPattern: RawExponent, significandBitPattern: RawSignificand) {
        self.init(rawValue: .init(sign: sign,
                                  exponentBitPattern: exponentBitPattern,
                                  significandBitPattern: significandBitPattern))
    }

    init(sign: FloatingPointSign, exponent: Exponent, significand: Self) {
        self.init(rawValue: .init(sign: sign, exponent: exponent, significand: significand.rawValue))
    }

    // All this just for these two...
    init?(exactly value: some BinaryInteger) { nil }
    init?(exactly value: some BinaryFloatingPoint) { nil }

    func distance(to other: Self) -> Stride {
        rawValue.distance(to: other.rawValue)
    }

    func advanced(by n: Stride) -> Self {
        .init(rawValue: rawValue.advanced(by: n))
    }

    func isEqual(to other: Self) -> Bool {
        rawValue.isEqual(to: other.rawValue)
    }

    func isLess(than other: Self) -> Bool {
        rawValue.isLess(than: other.rawValue)
    }

    func isLessThanOrEqualTo(_ other: Self) -> Bool {
        rawValue.isLessThanOrEqualTo(other.rawValue)
    }

    mutating func formRemainder(dividingBy other: Self) {
        rawValue.formRemainder(dividingBy: other.rawValue)
    }

    mutating func formTruncatingRemainder(dividingBy other: Self) {
        rawValue.formTruncatingRemainder(dividingBy: other.rawValue)
    }

    mutating func formSquareRoot() {
        rawValue.formSquareRoot()
    }

    mutating func addProduct(_ lhs: Self, _ rhs: Self) {
        rawValue.addProduct(lhs.rawValue, rhs.rawValue)
    }

    mutating func round(_ rule: FloatingPointRoundingRule) {
        rawValue.round(rule)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        .init(rawValue: lhs.rawValue + rhs.rawValue)
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        .init(rawValue: lhs.rawValue - rhs.rawValue)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(rawValue: lhs.rawValue * rhs.rawValue)
    }

    static func / (lhs: Self, rhs: Self) -> Self {
        .init(rawValue: lhs.rawValue / rhs.rawValue)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs.rawValue *= rhs.rawValue
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs.rawValue /= rhs.rawValue
    }
}
