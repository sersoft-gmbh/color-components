extension CIE {
    /// An opaque XYZ color components representation.
    @frozen
    public struct XYZ<Value: ColorCompontentValue>: ColorComponents {
        /// The x component.
        public var x: Value
        /// The y component.
        public var y: Value
        /// The z component.
        public var z: Value

        /// Creates new XYZ components with the given values.
        /// - Parameters:
        ///   - x: The x component.
        ///   - y: The y component.
        ///   - z: The z component.
        public init(x: Value, y: Value, z: Value) {
            (self.x, self.y, self.z) = (x, y, z)
        }
    }

    /// An XYZA (x, y, z, alpha) color components representation.
    @frozen
    public struct XYZA<Value: ColorCompontentValue>: AlphaColorComponents {
        /// The XYZ components.
        public var xyz: CIE.XYZ<Value>
        /// The alpha component.
        public var alpha: Value

        /// The x component.
        /// - SeeAlso: `XYZ.x`
        @inlinable
        public var x: Value {
            get { xyz.x }
            set { xyz.x = newValue }
        }

        /// The y component.
        /// - SeeAlso: `XYZ.y`
        @inlinable
        public var y: Value {
            get { xyz.y }
            set { xyz.y = newValue }
        }

        /// The y component.
        /// - SeeAlso: `XYZ.y`
        @inlinable
        public var z: Value {
            get { xyz.z }
            set { xyz.z = newValue }
        }

        /// Creates new XYZA components using the given values.
        /// - Parameters:
        ///   - xyz: The XYZ components.
        ///   - alpha: The alpha component.
        public init(xyz: CIE.XYZ<Value>, alpha: Value) {
            (self.xyz, self.alpha) = (xyz, alpha)
        }

        /// Creates new XYZA components using the given values.
        /// - Parameters:
        ///   - x: The x component.
        ///   - y: The y component.
        ///   - z: The z component.
        ///   - alpha: The alpha component.
        @inlinable
        public init(x: Value, y: Value, z: Value, alpha: Value) {
            self.init(xyz: .init(x: x, y: y, z: z), alpha: alpha)
        }
    }
}

extension CIE.XYZ where Value: BinaryInteger {
    /// Creates new XYZ components from another XYZ color components object with integer values.
    /// - Parameter other: The other XYZ color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: CIE.XYZ<OtherValue>) {
        self.init(x: .init(other.x), y: .init(other.y), z: .init(other.z))
    }

    /// Tries to create new XYZ components that exactly match the values
    /// from another XYZ color components object with integer values.
    /// - Parameter other: The other XYZ color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: CIE.XYZ<OtherValue>) {
        guard let x = Value(exactly: other.x),
              let y = Value(exactly: other.y),
              let z = Value(exactly: other.z)
        else { return nil }
        self.init(x: x, y: y, z: z)
    }

    /// Creates new XYZ components from another XYZ color components object with floating point values.
    /// - Parameter other: The other XYZ color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: CIE.XYZ<OtherValue>) {
        self.init(x: .init(colorConverting: other.x),
                  y: .init(colorConverting: other.y),
                  z: .init(colorConverting: other.z))
    }

    /// Tries to create new XYZ components that exactly match the values
    /// from another XYZ color components object with floating point values.
    /// - Parameter other: The other XYZ color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: CIE.XYZ<OtherValue>) {
        guard let x = Value(colorConvertingExactly: other.x),
              let y = Value(colorConvertingExactly: other.y),
              let z = Value(colorConvertingExactly: other.z)
        else { return nil }
        self.init(x: x, y: y, z: z)
    }
}

extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// Creates new XYZ components from another XYZ color components object with integer values.
    /// - Parameter other: The other XYZ color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: CIE.XYZ<OtherValue>) {
        self.init(x: .init(colorConverting: other.x),
                  y: .init(colorConverting: other.y),
                  z: .init(colorConverting: other.z))
    }

    /// Tries to create new XYZ components that exactly match the values
    /// from another XYZ color components object with integer values.
    /// - Parameter other: The other XYZ color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: CIE.XYZ<OtherValue>) {
        guard let x = Value(colorConvertingExactly: other.x),
              let y = Value(colorConvertingExactly: other.y),
              let z = Value(colorConvertingExactly: other.z)
        else { return nil }
        self.init(x: x, y: y, z: z)
    }

    /// Creates new XYZ components from another XYZ color components object with floating point values.
    /// - Parameter other: The other XYZ color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: CIE.XYZ<OtherValue>) {
        self.init(x: .init(other.x), y: .init(other.y), z: .init(other.z))
    }

    /// Tries to create new XYZ components that exactly match the values
    /// from another XYZ color components object with floating point values.
    /// - Parameter other: The other XYZ color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: CIE.XYZ<OtherValue>) {
        guard let x = Value(exactly: other.x),
              let y = Value(exactly: other.y),
              let z = Value(exactly: other.z)
        else { return nil }
        self.init(x: x, y: y, z: z)
    }
}

extension CIE.XYZA where Value: BinaryInteger {
    /// Creates new XYZA components from another XYZA color components object with integer values.
    /// - Parameter other: The other XYZA color components.
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: CIE.XYZA<OtherValue>) {
        self.init(xyz: .init(other.xyz), alpha: .init(other.alpha))
    }

    /// Tries to create new XYZA components that exactly match the values
    /// from another XYZA color components object with integer values.
    /// - Parameter other: The other XYZA color components.
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: CIE.XYZA<OtherValue>) {
        guard let xyz = CIE.XYZ<Value>(exactly: other.xyz),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(xyz: xyz, alpha: alpha)
    }

    /// Creates new XYZA components from another XYZA color components object with floating point values.
    /// - Parameter other: The other XYZA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: CIE.XYZA<OtherValue>) {
        self.init(xyz: .init(other.xyz), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new XYZA components that exactly match the values
    /// from another XYZA color components object with floating point values.
    /// - Parameter other: The other XYZA color components.
    /// - Note: This will convert the floating point values (0.0 - 1.0) to integer values (0 - 255).
    /// - SeeAlso: `BinaryInteger.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: CIE.XYZA<OtherValue>) {
        guard let xyz = CIE.XYZ<Value>(exactly: other.xyz),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(xyz: xyz, alpha: alpha)
    }
}

extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// Creates new XYZA components from another XYZA color components object with integer values.
    /// - Parameter other: The other XYZA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryInteger>(_ other: CIE.XYZA<OtherValue>) {
        self.init(xyz: .init(other.xyz), alpha: .init(colorConverting: other.alpha))
    }

    /// Tries to create new XYZA components that exactly match the values
    /// from another XYZA color components object with integer values.
    /// - Parameter other: The other XYZA color components.
    /// - Note: This will convert the integer values (0 - 255) to floating point values (0.0 - 1.0).
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryInteger>(exactly other: CIE.XYZA<OtherValue>) {
        guard let xyz = CIE.XYZ<Value>(exactly: other.xyz),
              let alpha = Value(colorConvertingExactly: other.alpha)
        else { return nil }
        self.init(xyz: xyz, alpha: alpha)
    }

    /// Creates new XYZA components from another XYZA color components object with floating point values.
    /// - Parameter other: The other XYZA color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(_:)`
    @inlinable
    public init<OtherValue: BinaryFloatingPoint>(_ other: CIE.XYZA<OtherValue>) {
        self.init(xyz: .init(other.xyz), alpha: .init(other.alpha))
    }

    /// Tries to create new XYZA components that exactly match the values
    /// from another XYZA color components object with floating point values.
    /// - Parameter other: The other XYZA color components.
    /// - SeeAlso: `BinaryFloatingPoint.init(exactly:)`
    @inlinable
    public init?<OtherValue: BinaryFloatingPoint>(exactly other: CIE.XYZA<OtherValue>) {
        guard let xyz = CIE.XYZ<Value>(exactly: other.xyz),
              let alpha = Value(exactly: other.alpha)
        else { return nil }
        self.init(xyz: xyz, alpha: alpha)
    }
}

extension CIE.XYZ: FloatingPointColorComponents where Value: FloatingPoint, Value: ExpressibleByFloatLiteral {
    /// The brightness of these color components. The x, y and z components are weighted in this.
    public var brightness: Value { y }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    public mutating func changeBrightness(by percent: Value) {
        _apply(percent: percent, to: &y)
    }
}

extension CIE.XYZA: FloatingPointColorComponents where Value: FloatingPoint, Value: ExpressibleByFloatLiteral {
    /// The brightness of these color components. The x, y and z components are weighted in this.
    @inlinable
    public var brightness: Value { xyz.brightness }

    /// Changes the brightness by the given percent value.
    /// Pass 0.1 to increase brightness by 10%.
    /// Pass -0.1 to decrease brightness by 10%.
    /// - Parameter percent: The percentage amount to change the brightness.
    @inlinable
    public mutating func changeBrightness(by percent: Value) {
        xyz.changeBrightness(by: percent)
    }
}

extension CIE.XYZ: Sendable where Value: Sendable {}
extension CIE.XYZA: Sendable where Value: Sendable {}

extension CIE.XYZ: Encodable where Value: Encodable {}
extension CIE.XYZA: Encodable where Value: Encodable {}
extension CIE.XYZ: Decodable where Value: Decodable {}
extension CIE.XYZA: Decodable where Value: Decodable {}

extension CIE.XYZ: CustomPlaygroundDisplayConvertible {}
extension CIE.XYZA: CustomPlaygroundDisplayConvertible {}
