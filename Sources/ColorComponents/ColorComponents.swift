/// The type of values that can be used with color components.
public typealias ColorCompontentValue = Hashable & Comparable & Numeric

#if compiler(>=5.7)
/// Describes a type that represents (opaque) color components without an alpha channel.
public protocol ColorComponents<Value>: Hashable {
    /// The value type of these color components.
    associatedtype Value: ColorCompontentValue
}

/// Describes a type that represents color components with an alpha channel.
public protocol AlphaColorComponents<Value>: ColorComponents {
    /// The alpha component.
    var alpha: Value { get }
}

/// Describes a type that represents (opaque) color components whose value is a floating point type.
/// - SeeAlso: `ColorComponents`
public protocol FloatingPointColorComponents<Value>: ColorComponents where Value: FloatingPoint {
    /// The brightness of these color components.
    var brightness: Value { get }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    mutating func changeBrightness(by percent: Value)
}

/// Describes a type that represents color components whose value is a floating point type.
/// - SeeAlso: `AlphaColorComponents`
public typealias AlphaFloatingPointColorComponents<Value> = FloatingPointColorComponents<Value> & AlphaColorComponents<Value>
#else
/// Describes a type that represents (opaque) color components without an alpha channel.
public protocol ColorComponents: Hashable {
    /// The value type of these color components.
    associatedtype Value: ColorCompontentValue
}

/// Describes a type that represents color components with an alpha channel.
public protocol AlphaColorComponents: ColorComponents {
    /// The alpha component.
    var alpha: Value { get }
}

/// Describes a type that represents (opaque) color components whose value is a floating point type.
/// - SeeAlso: `ColorComponents`
public protocol FloatingPointColorComponents: ColorComponents where Value: FloatingPoint {
    /// The brightness of these color components.
    var brightness: Value { get }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    mutating func changeBrightness(by percent: Value)
}

/// Describes a type that represents color components whose value is a floating point type.
/// - SeeAlso: `AlphaColorComponents`
public typealias AlphaFloatingPointColorComponents = FloatingPointColorComponents & AlphaColorComponents
#endif

extension AlphaColorComponents {
    /// Returns whether these color components represent a clear color (`alpha` is zero).
    @inlinable
    public var isClearColor: Bool { alpha <= .zero }
}

extension FloatingPointColorComponents where Value: ExpressibleByFloatLiteral {
    /// Returns whether these color components represent a dark color (`brightness` less than 0.5).
    @inlinable
    public var isDarkColor: Bool { brightness < 0.5 }

    /// Returns whether these color components represent a light color (`brightness` greater than or equal to 0.5).
    @inlinable
    public var isBrightColor: Bool { brightness >= 0.5 }
}

fileprivate extension ColorComponents {
    var _floatingPointPlaygroundSupport: _FloatingPointColorComponentsPlaygroundSupport? {
        self as? _FloatingPointColorComponentsPlaygroundSupport
    }
}

fileprivate extension ColorComponents {
    var _binaryIntegerPlaygroundSupport: _BinaryIntegerColorComponentsPlaygroundSupport? {
        self as? _BinaryIntegerColorComponentsPlaygroundSupport
    }
}

extension ColorComponents where Self: CustomPlaygroundDisplayConvertible, Value: BinaryFloatingPoint {
    public var playgroundDescription: Any {
        _floatingPointPlaygroundSupport?._playgroundColor ?? String(describing: self)
    }
}

extension ColorComponents where Self: CustomPlaygroundDisplayConvertible, Value: BinaryInteger {
    public var playgroundDescription: Any {
        _binaryIntegerPlaygroundSupport?._playgroundColor ?? String(describing: self)
    }
}

extension ColorComponents where Self: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        _binaryIntegerPlaygroundSupport?._playgroundColor
        ?? _floatingPointPlaygroundSupport?._playgroundColor
        ?? String(describing: self)
    }
}

// MARK: - Helpers
extension FloatingPointColorComponents {
    @inlinable
    func _apply(percent: Value, to value: inout Value) {
        value = max(min(value + percent, 1), 0)
    }
}

extension BinaryInteger {
    @inlinable
    init<F: BinaryFloatingPoint>(colorConverting other: F) {
        self.init(other * 0xFF)
    }

    @inlinable
    init?<F: BinaryFloatingPoint>(colorConvertingExactly other: F) {
        self.init(exactly: other * 0xFF)
    }
}

extension BinaryFloatingPoint {
    @inlinable
    init<I: BinaryInteger>(colorConverting other: I) {
        self = Self(other) / 0xFF
    }

    @inlinable
    init?<I: BinaryInteger>(colorConvertingExactly other: I) {
        guard let base = Self(exactly: other) else { return nil }
        self = base / 0xFF
    }
}
