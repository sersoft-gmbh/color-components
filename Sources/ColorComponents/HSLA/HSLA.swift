/// An opaque HSL (hue, saturation, luminance) color components representation.
@frozen
public struct HSL<Value: ColorCompontentValue>: ColorComponents {
    /// The hue component.
    public var hue: Value
    /// The saturation component.
    public var saturation: Value
    /// The luminance component.
    public var luminance: Value

    /// Creates new HSL components with the given values.
    /// - Parameters:
    ///   - hue: The hue component.
    ///   - saturation: The saturation component.
    ///   - luminance: The luminance component.
    public init(hue: Value, saturation: Value, luminance: Value) {
        (self.hue, self.saturation, self.luminance) = (hue, saturation, luminance)
    }
}

/// An HSLA (hue, saturation, luminance, alpha) color components representation.
@frozen
public struct HSLA<Value: ColorCompontentValue>: AlphaColorComponents {
    /// The HSL components.
    public var hsl: HSL<Value>
    /// The alpha component.
    public var alpha: Value

    /// The hue component.
    /// - SeeAlso: `HSL.hue`
    @inlinable
    public var hue: Value {
        get { hsl.hue }
        set { hsl.hue = newValue }
    }

    /// The saturation component.
    /// - SeeAlso: `HSL.saturation`
    @inlinable
    public var saturation: Value {
        get { hsl.saturation }
        set { hsl.saturation = newValue }
    }

    /// The luminance component.
    /// - SeeAlso: `HSL.luminance`
    @inlinable
    public var luminance: Value {
        get { hsl.luminance }
        set { hsl.luminance = newValue }
    }

    /// Creates new HSLA components using the given values.
    /// - Parameters:
    ///   - hsb: The HSL components.
    ///   - alpha: The alpha component.
    public init(hsl: HSL<Value>, alpha: Value) {
        (self.hsl, self.alpha) = (hsl, alpha)
    }

    /// Creates new HSLA components using the given values.
    /// - Parameters:
    ///   - hue: The hue component.
    ///   - saturation: The saturation component.
    ///   - luminance: The luminance component.
    ///   - alpha: The alpha component.
    @inlinable
    public init(hue: Value, saturation: Value, luminance: Value, alpha: Value) {
        self.init(hsl: .init(hue: hue, saturation: saturation, luminance: luminance), alpha: alpha)
    }
}

extension HSL where Value: BinaryInteger {
    /// Creates new HSL components from another HSL color components object with integer values.
    /// - Parameter other: The other HSL color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSL<OtherValue>) {
        self.init(hue: .init(other.hue),
                  saturation: .init(other.saturation),
                  luminance: .init(other.luminance))
    }

    /// Tries to create new HSL components that exactly match the values
    /// from another HSL color components object with integer values.
    /// - Parameter other: The other HSL color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSL<OtherValue>) {
        guard let hue = Value(exactly: other.hue),
              let saturation = Value(exactly: other.saturation),
              let luminance = Value(exactly: other.luminance)
        else { return nil }
        self.init(hue: hue, saturation: saturation, luminance: luminance)
    }

    /// Creates new HSL components from another HSL color components object with floating point values.
    /// - Parameter other: The other HSL color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSL<OtherValue>) {
        self.init(hue: .init(colorConverting: other.hue),
                  saturation: .init(colorConverting: other.saturation),
                  luminance: .init(colorConverting: other.luminance))
    }

    /// Tries to create new HSL components that exactly match the values
    /// from another HSL color components object with floating point values.
    /// - Parameter other: The other HSL color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSL<OtherValue>) {
        guard let hue = Value(colorConvertingExactly: other.hue),
              let saturation = Value(colorConvertingExactly: other.saturation),
              let luminance = Value(colorConvertingExactly: other.luminance)
        else { return nil }
        self.init(hue: hue, saturation: saturation, luminance: luminance)
    }
}

extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components from another HSL color components object with integer values.
    /// - Parameter other: The other HSL color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSL<OtherValue>) {
        self.init(hue: .init(colorConverting: other.hue),
                  saturation: .init(colorConverting: other.saturation),
                  luminance: .init(colorConverting: other.luminance))
    }

    /// Tries to create new HSB components that exactly match the values
    /// from another HSB color components object with integer values.
    /// - Parameter other: The other HSB color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSL<OtherValue>) {
        guard let hue = Value(colorConvertingExactly: other.hue),
              let saturation = Value(colorConvertingExactly: other.saturation),
              let luminance = Value(colorConvertingExactly: other.luminance)
        else { return nil }
        self.init(hue: hue, saturation: saturation, luminance: luminance)
    }

    /// Creates new HSL components from another HSL color components object with floating point values.
    /// - Parameter other: The other HSL color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSL<OtherValue>) {
        self.init(hue: .init(other.hue),
                  saturation: .init(other.saturation),
                  luminance: .init(other.luminance))
    }

    /// Tries to create new HSL components that exactly match the values
    /// from another HSL color components object with floating point values.
    /// - Parameter other: The other HSB color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSL<OtherValue>) {
        guard let hue = Value(exactly: other.hue),
              let saturation = Value(exactly: other.saturation),
              let luminance = Value(exactly: other.luminance)
        else { return nil }
        self.init(hue: hue, saturation: saturation, luminance: luminance)
    }
}

extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components from another HSLA color components object with integer values.
    /// - Parameter other: The other HSLA color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSLA<OtherValue>) {
        self.init(hsl: .init(other.hsl), alpha: .init(other.alpha))
    }

    /// Tries to create new HSLA components that exactly match the values
    /// from another HSLA color components object with integer values.
    /// - Parameter other: The other HSLA color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSLA<OtherValue>) {
        guard let hsl = HSL<Value>(exactly: other.hsl),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(hsl: hsl, alpha: alpha)
    }

    /// Creates new HSLA components from another HSLA color components object with floating point values.
    /// - Parameter other: The other HSLA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSLA<OtherValue>) {
        self.init(hsl: .init(other.hsl), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new HSLA components that exactly match the values
    /// from another HSLA color components object with floating point values.
    /// - Parameter other: The other HSLA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSLA<OtherValue>) {
        guard let hsl = HSL<Value>(exactly: other.hsl),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(hsl: hsl, alpha: alpha)
    }
}

extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components from another HSLA color components object with integer values.
    /// - Parameter other: The other HSLA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSLA<OtherValue>) {
        self.init(hsl: .init(other.hsl), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new HSLA components that exactly match the values
    /// from another HSLA color components object with integer values.
    /// - Parameter other: The other HSLA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSLA<OtherValue>) {
        guard let hsl = HSL<Value>(exactly: other.hsl),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(hsl: hsl, alpha: alpha)
    }

    /// Creates new HSLA components from another HSLA color components object with floating point values.
    /// - Parameter other: The other HSLA color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSLA<OtherValue>) {
        self.init(hsl: .init(other.hsl), alpha: .init(other.alpha))
    }

    /// Tries to create new HSLA components that exactly match the values
    /// from another HSLA color components object with floating point values.
    /// - Parameter other: The other HSLA color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSLA<OtherValue>) {
        guard let hsl = HSL<Value>(exactly: other.hsl),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(hsl: hsl, alpha: alpha)
    }
}

extension HSL: FloatingPointColorComponents where Value: FloatingPoint {
    /// The brightness of these color components.
    public var brightness: Value {
        luminance + saturation * min(luminance, 1 - luminance)
    }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        // TODO: Is this correct?
        _apply(percent: percent, to: &luminance)
    }
}

extension HSLA: FloatingPointColorComponents where Value: FloatingPoint {
    /// The brightness of these color components.
    @inlinable
    public var brightness: Value { hsl.brightness }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        hsl.changeBrightness(by: percent)
    }
}

extension HSL: Sendable where Value: Sendable {}
extension HSLA: Sendable where Value: Sendable {}

extension HSL: Encodable where Value: Encodable {}
extension HSLA: Encodable where Value: Encodable {}
extension HSL: Decodable where Value: Decodable {}
extension HSLA: Decodable where Value: Decodable {}

extension HSL: CustomPlaygroundDisplayConvertible {}
extension HSLA: CustomPlaygroundDisplayConvertible {}
