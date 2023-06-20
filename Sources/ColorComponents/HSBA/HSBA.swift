/// An opaque HSB (hue, saturation, brightness) color components representation.
@frozen
public struct HSB<Value: ColorCompontentValue>: ColorComponents {
    /// The hue component.
    public var hue: Value
    /// The saturation component.
    public var saturation: Value
    /// The brightness component.
    public var brightness: Value

    /// Creates new HSB components with the given values.
    /// - Parameters:
    ///   - hue: The hue component.
    ///   - saturation: The saturation component.
    ///   - brightness: The brightness component.
    public init(hue: Value, saturation: Value, brightness: Value) {
        (self.hue, self.saturation, self.brightness) = (hue, saturation, brightness)
    }
}

/// HSV is just an alias for HSB.
public typealias HSV = HSB

/// An HSBA (hue, saturation, brightness, alpha) color components representation.
@frozen
public struct HSBA<Value: ColorCompontentValue>: AlphaColorComponents {
    /// The HSB components.
    public var hsb: HSB<Value>
    /// The alpha component.
    public var alpha: Value

    /// The hue component.
    /// - SeeAlso: `HSB.hue`
    @inlinable
    public var hue: Value {
        get { hsb.hue }
        set { hsb.hue = newValue }
    }

    /// The saturation component.
    /// - SeeAlso: `HSB.saturation`
    @inlinable
    public var saturation: Value {
        get { hsb.saturation }
        set { hsb.saturation = newValue }
    }

    /// The brightness component.
    /// - SeeAlso: `HSB.brightness`
    @inlinable
    public var brightness: Value {
        get { hsb.brightness }
        set { hsb.brightness = newValue }
    }

    /// Creates new HSBA components using the given values.
    /// - Parameters:
    ///   - hsb: The HSB components.
    ///   - alpha: The alpha component.
    public init(hsb: HSB<Value>, alpha: Value) {
        (self.hsb, self.alpha) = (hsb, alpha)
    }

    /// Creates new HSBA components using the given values.
    /// - Parameters:
    ///   - hue: The hue component.
    ///   - saturation: The saturation component.
    ///   - brightness: The brightness component.
    ///   - alpha: The alpha component.
    @inlinable
    public init(hue: Value, saturation: Value, brightness: Value, alpha: Value) {
        self.init(hsb: .init(hue: hue, saturation: saturation, brightness: brightness), alpha: alpha)
    }
}

/// HSVA is just an alias for HSBA.
public typealias HSVA = HSBA

extension HSB where Value: BinaryInteger {
    /// Creates new HSB components from another HSB color components object with integer values.
    /// - Parameter other: The other HSB color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(other.hue),
                  saturation: .init(other.saturation),
                  brightness: .init(other.brightness))
    }

    /// Tries to create new HSB components that exactly match the values
    /// from another HSB color components object with integer values.
    /// - Parameter other: The other HSB color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSB<OtherValue>) {
        guard let hue = Value(exactly: other.hue),
              let saturation = Value(exactly: other.saturation),
              let brightness = Value(exactly: other.brightness)
        else { return nil }
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }

    /// Creates new HSB components from another HSB color components object with floating point values.
    /// - Parameter other: The other HSB color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(colorConverting: other.hue),
                  saturation: .init(colorConverting: other.saturation),
                  brightness: .init(colorConverting: other.brightness))
    }

    /// Tries to create new HSB components that exactly match the values
    /// from another HSB color components object with floating point values.
    /// - Parameter other: The other HSB color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSB<OtherValue>) {
        guard let hue = Value(colorConvertingExactly: other.hue),
              let saturation = Value(colorConvertingExactly: other.saturation),
              let brightness = Value(colorConvertingExactly: other.brightness)
        else { return nil }
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }
}

extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components from another HSB color components object with integer values.
    /// - Parameter other: The other HSB color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(colorConverting: other.hue),
                  saturation: .init(colorConverting: other.saturation),
                  brightness: .init(colorConverting: other.brightness))
    }

    /// Tries to create new HSB components that exactly match the values
    /// from another HSB color components object with integer values.
    /// - Parameter other: The other HSB color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSB<OtherValue>) {
        guard let hue = Value(colorConvertingExactly: other.hue),
              let saturation = Value(colorConvertingExactly: other.saturation),
              let brightness = Value(colorConvertingExactly: other.brightness)
        else { return nil }
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }

    /// Creates new HSB components from another HSB color components object with floating point values.
    /// - Parameter other: The other HSB color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(other.hue),
                  saturation: .init(other.saturation),
                  brightness: .init(other.brightness))
    }

    /// Tries to create new HSB components that exactly match the values
    /// from another HSB color components object with floating point values.
    /// - Parameter other: The other HSB color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSB<OtherValue>) {
        guard let hue = Value(exactly: other.hue),
              let saturation = Value(exactly: other.saturation),
              let brightness = Value(exactly: other.brightness)
        else { return nil }
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }
}

extension HSBA where Value: BinaryInteger {
    /// Creates new HSBA components from another HSBA color components object with integer values.
    /// - Parameter other: The other HSBA color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(other.alpha))
    }

    /// Tries to create new HSBA components that exactly match the values
    /// from another HSBA color components object with integer values.
    /// - Parameter other: The other HSBA color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }

    /// Creates new HSBA components from another HSBA color components object with floating point values.
    /// - Parameter other: The other HSBA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new HSBA components that exactly match the values
    /// from another HSBA color components object with floating point values.
    /// - Parameter other: The other HSBA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255) - including `hue`!
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components from another HSBA color components object with integer values.
    /// - Parameter other: The other HSBA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new HSBA components that exactly match the values
    /// from another HSBA color components object with integer values.
    /// - Parameter other: The other HSBA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0) - including `hue`!
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }

    /// Creates new HSBA components from another HSBA color components object with floating point values.
    /// - Parameter other: The other HSBA color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(other.alpha))
    }

    /// Tries to create new HSBA components that exactly match the values
    /// from another HSBA color components object with floating point values.
    /// - Parameter other: The other HSBA color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }
}

extension HSB: FloatingPointColorComponents where Value: FloatingPoint {
    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        _apply(percent: percent, to: &brightness)
    }
}

extension HSBA: FloatingPointColorComponents where Value: FloatingPoint {
    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        hsb.changeBrightness(by: percent)
    }
}

extension HSB where Value: FloatingPoint {
    var luminance: Value { brightness * (1 - saturation / 2) }
}

extension HSB: Sendable where Value: Sendable {}
extension HSBA: Sendable where Value: Sendable {}

extension HSB: Encodable where Value: Encodable {}
extension HSBA: Encodable where Value: Encodable {}
extension HSB: Decodable where Value: Decodable {}
extension HSBA: Decodable where Value: Decodable {}

extension HSB: CustomPlaygroundDisplayConvertible {}
extension HSBA: CustomPlaygroundDisplayConvertible {}
