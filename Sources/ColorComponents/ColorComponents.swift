public typealias ColorCompontentValue = Hashable & Comparable & AdditiveArithmetic

public protocol ColorComponents: Hashable {
    associatedtype Value: ColorCompontentValue
}

public protocol AlphaColorComponents: ColorComponents {
    var alpha: Value { get }
}

public protocol FloatingPointColorComponents: ColorComponents where Value: FloatingPoint {
    var brightness: Value { get }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    mutating func changeBrightness(by percent: Value)
}

public typealias AlphaFloatingPointColorComponents = FloatingPointColorComponents & AlphaColorComponents

extension ColorComponents {
    @inlinable
    public var isClearColor: Bool { false }
}

extension AlphaColorComponents {
    @inlinable
    public var isClearColor: Bool { alpha <= .zero }
}

extension FloatingPointColorComponents where Value: ExpressibleByFloatLiteral {
    @inlinable
    public var isDarkColor: Bool { brightness < 0.5 }
}

extension FloatingPointColorComponents where Value: Numeric {
    @inlinable
    internal func apply(percent: Value, to value: inout Value) {
        value = max(min(value + percent, 1), 0)
    }
}

extension BinaryInteger {
    @inlinable
    internal init<F: BinaryFloatingPoint>(colorConverting other: F) {
        self.init(other * 0xFF)
    }

    @inlinable
    internal init?<F: BinaryFloatingPoint>(colorConvertingExactly other: F) {
        self.init(exactly: other * 0xFF)
    }
}

extension BinaryFloatingPoint {
    @inlinable
    internal init<I: BinaryInteger>(colorConverting other: I) {
        self = Self(other) / 0xFF
    }

    @inlinable
    internal init?<I: BinaryInteger>(colorConvertingExactly other: I) {
        guard let base = Self(exactly: other) else { return nil }
        self = base / 0xFF
    }
}
