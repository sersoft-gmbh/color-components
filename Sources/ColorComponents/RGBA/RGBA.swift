public struct RGB<Value: ColorCompontentValue>: ColorComponents {
    public var red: Value
    public var green: Value
    public var blue: Value

    public init(red: Value, green: Value, blue: Value) {
        (self.red, self.green, self.blue) = (red, green, blue)
    }
}

public struct RGBA<Value: ColorCompontentValue>: AlphaColorComponents {
    public var rgb: RGB<Value>
    public var alpha: Value

    @inlinable
    public var red: Value {
        get { rgb.red }
        set { rgb.red = newValue }
    }

    @inlinable
    public var green: Value {
        get { rgb.green }
        set { rgb.green = newValue }
    }

    @inlinable
    public var blue: Value {
        get { rgb.blue }
        set { rgb.blue = newValue }
    }

    public init(rgb: RGB<Value>, alpha: Value) {
        (self.rgb, self.alpha) = (rgb, alpha)
    }

    @inlinable
    public init(red: Value, green: Value, blue: Value, alpha: Value) {
        self.init(rgb: .init(red: red, green: green, blue: blue), alpha: alpha)
    }
}

extension RGB where Value: BinaryInteger {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGB<OtherValue>) {
        self.init(red: .init(other.red), green: .init(other.green), blue: .init(other.blue))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGB<OtherValue>) {
        guard let red = Value(exactly: other.red),
              let green = Value(exactly: other.green),
              let blue = Value(exactly: other.blue)
        else { return nil }
        self.init(red: red, green: green, blue: blue)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGB<OtherValue>) {
        self.init(red: .init(colorConverting: other.red),
                  green: .init(colorConverting: other.green),
                  blue: .init(colorConverting: other.blue))
    }

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
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGB<OtherValue>) {
        self.init(red: .init(colorConverting: other.red),
                  green: .init(colorConverting: other.green),
                  blue: .init(colorConverting: other.blue))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGB<OtherValue>) {
        guard let red = Value(colorConvertingExactly: other.red),
              let green = Value(colorConvertingExactly: other.green),
              let blue = Value(colorConvertingExactly: other.blue)
        else { return nil }
        self.init(red: red, green: green, blue: blue)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGB<OtherValue>) {
        self.init(red: .init(other.red), green: .init(other.green), blue: .init(other.blue))
    }

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
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(colorConverting: other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(colorConverting: other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: RGBA<OtherValue>) {
        self.init(rgb: .init(other.rgb), alpha: .init(other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: RGBA<OtherValue>) {
        guard let rgb = RGB<Value>(exactly: other.rgb),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: alpha)
    }
}

extension RGB: FloatingPointColorComponents where Value: FloatingPoint, Value: ExpressibleByFloatLiteral {
    public var brightness: Value { red * 0.299 + green * 0.587 + blue * 0.114 }

    public mutating func changeBrightness(by percent: Value) {
        // TODO: Shouldn't the brightness be applied weighted the same as in `brightness` above?
        _apply(percent: percent, to: &red)
        _apply(percent: percent, to: &green)
        _apply(percent: percent, to: &blue)
    }
}

extension RGBA: FloatingPointColorComponents where Value: FloatingPoint, Value: ExpressibleByFloatLiteral  {
    @inlinable
    public var brightness: Value { rgb.brightness }

    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        rgb.changeBrightness(by: percent)
    }
}

extension RGB: Encodable where Value: Encodable {}
extension RGBA: Encodable where Value: Encodable {}
extension RGB: Decodable where Value: Decodable {}
extension RGBA: Decodable where Value: Decodable {}
