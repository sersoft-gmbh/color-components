@frozen
public struct BW<Value: ColorCompontentValue>: ColorComponents {
    public var white: Value

    public init(white: Value) {
        self.white = white
    }
}

@frozen
public struct BWA<Value: ColorCompontentValue>: AlphaColorComponents {
    public var bw: BW<Value>
    public var alpha: Value

    @inlinable
    public var white: Value {
        get { bw.white }
        set { bw.white = newValue }
    }

    public init(bw: BW<Value>, alpha: Value) {
        (self.bw, self.alpha) = (bw, alpha)
    }

    @inlinable
    public init(white: Value, alpha: Value) {
        self.init(bw: .init(white: white), alpha: alpha)
    }
}

extension BW where Value: BinaryInteger {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BW<OtherValue>) {
        self.init(white: .init(other.white))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BW<OtherValue>) {
        guard let white = Value(exactly: other.white) else { return nil }
        self.init(white: white)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BW<OtherValue>) {
        self.init(white: .init(colorConverting: other.white))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BW<OtherValue>) {
        guard let white = Value(colorConvertingExactly: other.white) else { return nil }
        self.init(white: white)
    }
}

extension BW where Value: BinaryFloatingPoint {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BW<OtherValue>) {
        self.init(white: .init(colorConverting: other.white))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BW<OtherValue>) {
        guard let white = Value(colorConvertingExactly: other.white) else { return nil }
        self.init(white: white)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BW<OtherValue>) {
        self.init(white: .init(other.white))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BW<OtherValue>) {
        guard let white = Value(exactly: other.white) else { return nil }
        self.init(white: white)
    }
}

extension BWA where Value: BinaryInteger {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(colorConverting: other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }
}

extension BWA where Value: BinaryFloatingPoint {
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(colorConverting: other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }

    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: BWA<OtherValue>) {
        self.init(bw: .init(other.bw), alpha: .init(other.alpha))
    }

    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: BWA<OtherValue>) {
        guard let bw = BW<Value>(exactly: other.bw),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(bw: bw, alpha: alpha)
    }
}

extension BW: FloatingPointColorComponents where Value: FloatingPoint {
    @inlinable
    public var brightness: Value { white }

    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        _apply(percent: percent, to: &white)
    }
}

extension BWA: FloatingPointColorComponents where Value: FloatingPoint {
    @inlinable
    public var brightness: Value { bw.brightness }

    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        bw.changeBrightness(by: percent)
    }
}

extension BW: Encodable where Value: Encodable {}
extension BWA: Encodable where Value: Encodable {}
extension BW: Decodable where Value: Decodable {}
extension BWA: Decodable where Value: Decodable {}
