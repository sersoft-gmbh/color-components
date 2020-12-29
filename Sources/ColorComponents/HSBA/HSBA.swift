@frozen
public struct HSB<Value: ColorCompontentValue>: ColorComponents {
    public var hue: Value
    public var saturation: Value
    public var brightness: Value

    public init(hue: Value, saturation: Value, brightness: Value) {
        (self.hue, self.saturation, self.brightness) = (hue, saturation, brightness)
    }
}

@frozen
public struct HSBA<Value: ColorCompontentValue>: AlphaColorComponents {
    public var hsb: HSB<Value>
    public var alpha: Value

    @inlinable
    public var hue: Value {
        get { hsb.hue }
        set { hsb.hue = newValue }
    }

    @inlinable
    public var saturation: Value {
        get { hsb.saturation }
        set { hsb.saturation = newValue }
    }

    @inlinable
    public var brightness: Value {
        get { hsb.brightness }
        set { hsb.brightness = newValue }
    }

    public init(hsb: HSB<Value>, alpha: Value) {
        (self.hsb, self.alpha) = (hsb, alpha)
    }

    @inlinable
    public init(hue: Value, saturation: Value, brightness: Value, alpha: Value) {
        self.init(hsb: .init(hue: hue, saturation: saturation, brightness: brightness), alpha: alpha)
    }
}

extension HSB where Value: BinaryInteger {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(other.hue),
                  saturation: .init(other.saturation),
                  brightness: .init(other.brightness))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSB<OtherValue>) {
        guard let hue = Value(exactly: other.hue),
              let saturation = Value(exactly: other.saturation),
              let brightness = Value(exactly: other.brightness)
        else { return nil }
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(colorConverting: other.hue),
                  saturation: .init(colorConverting: other.saturation),
                  brightness: .init(colorConverting: other.brightness))
    }

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
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(colorConverting: other.hue),
                  saturation: .init(colorConverting: other.saturation),
                  brightness: .init(colorConverting: other.brightness))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSB<OtherValue>) {
        guard let hue = Value(colorConvertingExactly: other.hue),
              let saturation = Value(colorConvertingExactly: other.saturation),
              let brightness = Value(colorConvertingExactly: other.brightness)
        else { return nil }
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSB<OtherValue>) {
        self.init(hue: .init(other.hue),
                  saturation: .init(other.saturation),
                  brightness: .init(other.brightness))
    }

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
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(colorConverting: other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(colorConverting: other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: HSBA<OtherValue>) {
        self.init(hsb: .init(other.hsb), alpha: .init(other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: HSBA<OtherValue>) {
        guard let hsb = HSB<Value>(exactly: other.hsb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(hsb: hsb, alpha: alpha)
    }
}

extension HSB: FloatingPointColorComponents where Value: FloatingPoint {
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        _apply(percent: percent, to: &brightness)
    }
}

extension HSBA: FloatingPointColorComponents where Value: FloatingPoint {
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        hsb.changeBrightness(by: percent)
    }
}

extension HSB: Encodable where Value: Encodable {}
extension HSBA: Encodable where Value: Encodable {}
extension HSB: Decodable where Value: Decodable {}
extension HSBA: Decodable where Value: Decodable {}
