/// An opaque black/white color components representation.
@frozen
public struct BW<Value: ColorCompontentValue>: ColorComponents {
    /// The white component.
    public var white: Value

    /// Creates new black/white components with the given value.
    /// - Parameter white: The white component.
    public init(white: Value) {
        self.white = white
    }
}

/// A black/white color components representation with an alpha channel.
@frozen
public struct BWA<Value: ColorCompontentValue>: AlphaColorComponents {
    /// The black/white components.
    public var bw: BW<Value>
    /// The alpha component.
    public var alpha: Value

    /// The white component.
    /// - SeeAlso: `BW.white`
    @inlinable
    public var white: Value {
        get { bw.white }
        set { bw.white = newValue }
    }

    /// Creates new black/white components with an alpha channel with the given values.
    /// - Parameters:
    ///   - bw: The black/white components.
    ///   - alpha: The alpha component.
    public init(bw: BW<Value>, alpha: Value) {
        (self.bw, self.alpha) = (bw, alpha)
    }

    /// Creates new black/white components with an alpha channel with the given values.
    /// - Parameters:
    ///   - white: The white component.
    ///   - alpha: The alpha component.
    @inlinable
    public init(white: Value, alpha: Value) {
        self.init(bw: .init(white: white), alpha: alpha)
    }
}

extension BW where Value: BinaryInteger {
    /// Creates new black/white components from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BW<OtherValue>) {
        self.init(white: .init(other.white))
    }

    /// Tries to create new black/white components that exactly match the values
    /// from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BW<OtherValue>) {
        guard let white = Value(exactly: other.white) else { return nil }
        self.init(white: white)
    }

    /// Creates new black/white components from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BW<OtherValue>) {
        self.init(white: .init(colorConverting: other.white))
    }

    /// Tries to create new black/white components that exactly match the values
    /// from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BW<OtherValue>) {
        guard let white = Value(colorConvertingExactly: other.white) else { return nil }
        self.init(white: white)
    }
}

extension BW where Value: BinaryFloatingPoint {
    /// Creates new black/white components from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BW<OtherValue>) {
        self.init(white: .init(colorConverting: other.white))
    }

    /// Tries to create new black/white components that exactly match the values
    /// from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BW<OtherValue>) {
        guard let white = Value(colorConvertingExactly: other.white) else { return nil }
        self.init(white: white)
    }

    /// Creates new black/white components from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BW<OtherValue>) {
        self.init(white: .init(other.white))
    }

    /// Tries to create new black/white components that exactly match the values
    /// from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BW<OtherValue>) {
        guard let white = Value(exactly: other.white) else { return nil }
        self.init(white: white)
    }
}

extension BWA where Value: BinaryInteger {
    /// Creates new black/white components with alpha channel from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(other.alpha))
    }

    /// Tries to create new black/white components with alpha channel that exactly match the values
    /// from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }

    /// Creates new black/white components with alpha channel from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components with alpha channle.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new black/white components with alpha channel that exactly match the values
    /// from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }
}

extension BWA where Value: BinaryFloatingPoint {
    /// Creates new black/white components with alpha channel from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new black/white components with alpha channel that exactly match the values
    /// from another b/w color components object with integer values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }

    /// Creates new black/white components with alpha channel from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(other.alpha))
    }

    /// Tries to create new black/white components with alpha channel that exactly match the values
    /// from another b/w color components object with floating point values.
    /// - Parameter other: The other black/white color components with alpha channel.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }
}

extension BW: FloatingPointColorComponents where Value: FloatingPoint {
    /// The brightness of these color components. Corresponds to the white value.
    @inlinable
    public var brightness: Value { white }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        _apply(percent: percent, to: &white)
    }
}

extension BWA: /*Alpha*/FloatingPointColorComponents where Value: FloatingPoint {
    /// The brightness of these color components. Corresponds to the white value.
    @inlinable
    public var brightness: Value { bw.brightness }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        bw.changeBrightness(by: percent)
    }
}

extension BW: Sendable where Value: Sendable {}
extension BWA: Sendable where Value: Sendable {}

extension BW: Encodable where Value: Encodable {}
extension BWA: Encodable where Value: Encodable {}
extension BW: Decodable where Value: Decodable {}
extension BWA: Decodable where Value: Decodable {}

extension BW: CustomPlaygroundDisplayConvertible {}
extension BWA: CustomPlaygroundDisplayConvertible {}
