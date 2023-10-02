/// An opaque RGB (red, green, blue) color components representation.
@frozen
public struct RGB<Value: ColorCompontentValue>: ColorComponents {
    /// The red component.
    public var red: Value
    /// The green component.
    public var green: Value
    /// The blue component.
    public var blue: Value

    /// Creates new RGB components with the given values.
    /// - Parameters:
    ///   - red: The red component.
    ///   - green: The green component.
    ///   - blue: The blue component.
    public init(red: Value, green: Value, blue: Value) {
        (self.red, self.green, self.blue) = (red, green, blue)
    }
}

/// An RGBA (red, green, blue, alpha) color components representation.
@frozen
public struct RGBA<Value: ColorCompontentValue>: AlphaColorComponents {
    /// The RGB components.
    public var rgb: RGB<Value>
    /// The alpha component.
    public var alpha: Value

    /// The red component.
    /// - SeeAlso: ``RGB/red``
    @inlinable
    public var red: Value {
        get { rgb.red }
        set { rgb.red = newValue }
    }

    /// The green component.
    /// - SeeAlso: ``RGB/green``
    @inlinable
    public var green: Value {
        get { rgb.green }
        set { rgb.green = newValue }
    }

    /// The green component.
    /// - SeeAlso: ``RGB/green``
    @inlinable
    public var blue: Value {
        get { rgb.blue }
        set { rgb.blue = newValue }
    }

    /// Creates new RGBA components using the given values.
    /// - Parameters:
    ///   - rgb: The RGB components.
    ///   - alpha: The alpha component.
    public init(rgb: RGB<Value>, alpha: Value) {
        (self.rgb, self.alpha) = (rgb, alpha)
    }

    /// Creates new RGBA components using the given values.
    /// - Parameters:
    ///   - red: The red component.
    ///   - green: The green component.
    ///   - blue: The blue component.
    ///   - alpha: The alpha component.
    @inlinable
    public init(red: Value, green: Value, blue: Value, alpha: Value) {
        self.init(rgb: .init(red: red, green: green, blue: blue), alpha: alpha)
    }
}

extension RGB where Value: BinaryInteger {
    /// Creates new RGB components from another RGB color components object with integer values.
    /// - Parameter other: The other RGB color components.
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGB<OtherValue>) {
        self.init(red: .init(other.red), green: .init(other.green), blue: .init(other.blue))
    }

    /// Tries to create new RGB components that exactly match the values
    /// from another RGB color components object with integer values.
    /// - Parameter other: The other RGB color components.
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGB<OtherValue>) {
        guard let red = Value(exactly: other.red),
              let green = Value(exactly: other.green),
              let blue = Value(exactly: other.blue)
        else { return nil }
        self.init(red: red, green: green, blue: blue)
    }

    /// Creates new RGB components from another RGB color components object with floating point values.
    /// - Parameter other: The other RGB color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGB<OtherValue>) {
        self.init(red: .init(colorConverting: other.red),
                  green: .init(colorConverting: other.green),
                  blue: .init(colorConverting: other.blue))
    }

    /// Tries to create new RGB components that exactly match the values
    /// from another RGB color components object with floating point values.
    /// - Parameter other: The other RGB color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: RGB<OtherValue>) {
        guard let red = Value(colorConvertingExactly: other.red),
              let green = Value(colorConvertingExactly: other.green),
              let blue = Value(colorConvertingExactly: other.blue)
        else { return nil }
        self.init(red: red, green: green, blue: blue)
    }
}

extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components from another RGB color components object with integer values.
    /// - Parameter other: The other RGB color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGB<OtherValue>) {
        self.init(red: .init(colorConverting: other.red),
                  green: .init(colorConverting: other.green),
                  blue: .init(colorConverting: other.blue))
    }

    /// Tries to create new RGB components that exactly match the values
    /// from another RGB color components object with integer values.
    /// - Parameter other: The other RGB color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGB<OtherValue>) {
        guard let red = Value(colorConvertingExactly: other.red),
              let green = Value(colorConvertingExactly: other.green),
              let blue = Value(colorConvertingExactly: other.blue)
        else { return nil }
        self.init(red: red, green: green, blue: blue)
    }

    /// Creates new RGB components from another RGB color components object with floating point values.
    /// - Parameter other: The other RGB color components.
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGB<OtherValue>) {
        self.init(red: .init(other.red), green: .init(other.green), blue: .init(other.blue))
    }

    /// Tries to create new RGB components that exactly match the values
    /// from another RGB color components object with floating point values.
    /// - Parameter other: The other RGB color components.
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: RGB<OtherValue>) {
        guard let red = Value(exactly: other.red),
              let green = Value(exactly: other.green),
              let blue = Value(exactly: other.blue)
        else { return nil }
        self.init(red: red, green: green, blue: blue)
    }
}

extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components from another RGBA color components object with integer values.
    /// - Parameter other: The other RGBA color components.
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(other.alpha))
    }

    /// Tries to create new RGBA components that exactly match the values
    /// from another RGBA color components object with integer values.
    /// - Parameter other: The other RGBA color components.
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }

    /// Creates new RGBA components from another RGBA color components object with floating point values.
    /// - Parameter other: The other RGBA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new RGBA components that exactly match the values
    /// from another RGBA color components object with floating point values.
    /// - Parameter other: The other RGBA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: ``BinaryInteger/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components from another RGBA color components object with integer values.
    /// - Parameter other: The other RGBA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new RGBA components that exactly match the values
    /// from another RGBA color components object with integer values.
    /// - Parameter other: The other RGBA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }

    /// Creates new RGBA components from another RGBA color components object with floating point values.
    /// - Parameter other: The other RGBA color components.
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(other.alpha))
    }

    /// Tries to create new RGBA components that exactly match the values
    /// from another RGBA color components object with floating point values.
    /// - Parameter other: The other RGBA color components.
    /// - SeeAlso: ``BinaryFloatingPoint/init(_:)``
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }
}

extension RGB: FloatingPointColorComponents where Value: FloatingPoint, Value: ExpressibleByFloatLiteral {
    /// The brightness of these color components. The red, green and blue components are weighted in this.
    public var brightness: Value { red * 0.299 + green * 0.587 + blue * 0.114 }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    public mutating func changeBrightness(by percent: Value) {
        // TODO: Shouldn't the brightness be applied weighted the same as in `brightness` above?
        _apply(percent: percent, to: &red)
        _apply(percent: percent, to: &green)
        _apply(percent: percent, to: &blue)
    }
}

extension RGBA: FloatingPointColorComponents where Value: FloatingPoint, Value: ExpressibleByFloatLiteral {
    /// The brightness of these color components. The red, green and blue components are weighted in this.
    @inlinable
    public var brightness: Value { rgb.brightness }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        rgb.changeBrightness(by: percent)
    }
}

extension RGB: Sendable where Value: Sendable {}
extension RGBA: Sendable where Value: Sendable {}

extension RGB: Encodable where Value: Encodable {}
extension RGBA: Encodable where Value: Encodable {}
extension RGB: Decodable where Value: Decodable {}
extension RGBA: Decodable where Value: Decodable {}

extension RGB: CustomPlaygroundDisplayConvertible {}
extension RGBA: CustomPlaygroundDisplayConvertible {}
