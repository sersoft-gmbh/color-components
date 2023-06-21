struct DummyNumeric: Sendable, Hashable, Comparable, Numeric {
    typealias Magnitude = Int.Magnitude
    typealias IntegerLiteralType = Int

    private var value: Int

    var magnitude: Magnitude { value.magnitude }

    private init(value: Int) {
        self.value = value
    }

    init?<T>(exactly source: T) where T : BinaryInteger {
        guard let val = Int(exactly: source) else { return nil }
        self.init(value: val)
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.init(value: value)
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs.value *= rhs.value
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value - rhs.value)
    }
}
