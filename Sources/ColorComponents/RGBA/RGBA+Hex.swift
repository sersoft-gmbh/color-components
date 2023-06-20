extension RGB where Value: BinaryInteger {
    /// Creates new RGB components by splitting the combined hex value into RGB components.
    /// E.g. `RGB<UInt64>(hex: 0x3D4A7C)` becomes `RGB<UInt64>(red: 0x3D, green: 0x4A, blue: 0x7C)`.
    /// - Parameter hex: The combined RGB hex value.
    public init(hex: Value) {
        self.init(red:   (hex & 0xFF0000) >> 16,
                  green: (hex & 0x00FF00) >> 8,
                  blue:  (hex & 0x0000FF))
    }

    /// Creates new RGB components by splitting the combined hex value into RGB components.
    /// E.g. `RGB<UInt8>(hex: 0x3D4A7C)` becomes `RGB<UInt8>(red: 0x3D, green: 0x4A, blue: 0x7C)`.
    /// This overload exists so that e.g. `RGB<UInt8>` can be created from `0xFFECDA` which would overflow `UInt8`.
    /// - Parameter hex: The combined RGB hex value.
    @inlinable
    public init<Hex: BinaryInteger>(hex: Hex) {
        self.init(RGB<Hex>(hex: hex))
    }

    /// Creates new RGB components by parsing a given hex string into RGB components.
    /// If the string has `0x` or `#` as prefix, it is automatically removed.
    /// Returns nil if the string is no valid hex string.
    /// E.g. `RGB<UInt8>(hexString: "0x3D4A7C")` becomes `RGB<UInt8>(red: 0x3D, green: 0x4A, blue: 0x7C)`.
    /// - Parameter hexString: The string containing hex RGB values.
    public init?<S: StringProtocol>(hexString: S) {
        let dropCount: Int
        switch true {
        case hexString.hasPrefix("0x"): dropCount = 2
        case hexString.hasPrefix("#"): dropCount = 1
        default: dropCount = 0
        }
        guard let hexValue = UInt64(hexString.dropFirst(dropCount), radix: 16)
        else { return nil }
        self.init(hex: hexValue)
    }

    /// Computes the combined hex value for this RGB components.
    /// E.g. for `RGB<UInt64>(red: 0x3D, green: 0x4A, blue: 0x7C)` this returns `0x3D4A7C`.
    /// - Returns: The combined hex value for this RGB type.
    /// - Note: If the `Value` of this RGB components is too small to hold the entire hex value, this method will trap.
    ///         Use `hexValue(as:)` to perform the convesion using a larger type.
    public func hexValue() -> Value {
        red << 16 + green << 8 + blue
    }

    /// Computes the combined hex value for this RGB components using a given integer type.
    /// E.g. for `RGB<UInt8>(red: 0x3D, green: 0x4A, blue: 0x7C)` using `UInt64` as type, this returns `0x3D4A7C`.
    /// - Parameter : The type of integer to use.
    /// - Returns: The combined hex value for this RGB type.
    public func hexValue<I: BinaryInteger>(as _: I.Type = I.self) -> I {
        RGB<I>(self).hexValue()
    }
}

extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components by splitting the combined hex value into RGB components.
    /// E.g. `RGB<Float>(hex: 0x3D4A7C)` becomes `RGB<Float>(red: 0.24, green: 0.3, blue: 0.486)`.
    /// - Parameter hex: The combined RGB hex value.
    @inlinable
    public init<Hex: BinaryInteger>(hex: Hex) {
        self.init(RGB<Hex>(hex: hex))
    }

    /// Creates new RGB components by parsing a given hex string into RGB components.
    /// If the string has `0x` or `#` as prefix, it is automatically removed.
    /// Returns nil if the string is no valid hex string.
    /// E.g. `RGB<Float>(hexString: "0x3D4A7C")` becomes `RGB<Float>(red: 0.24, green: 0.3, blue: 0.486)`.
    /// - Parameter hexString: The string containing hex RGB values.
    @inlinable
    public init?<S: StringProtocol>(hexString: S) {
        guard let rgb = RGB<UInt8>(hexString: hexString) else { return nil }
        self.init(rgb)
    }

    /// Computes the combined hex value for this RGB components using a given integer type.
    /// E.g. for `RGB<Float>(red: 0.5, green: 0.25, blue: 0.75)` this returns `0x7F3FBF`.
    /// - Parameter : The type of integer to use.
    /// - Returns: The combined hex value for this RGB type.
    @inlinable
    public func hexValue<I: BinaryInteger>(as _: I.Type = I.self) -> I {
        RGB<I>(self).hexValue()
    }
}

extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components by splitting the combined hex value into RGBA components.
    /// E.g. `RGBA<UInt64>(hex: 0x3D4A7C1B)` becomes `RGBA<UInt64>(red: 0x3D, green: 0x4A, blue: 0x7C, alpha: 0x1B)`.
    /// - Parameter hex: The combined RGBA hex value.
    public init(hex: Value) {
        self.init(red:   (hex & 0xFF000000) >> 24,
                  green: (hex & 0x00FF0000) >> 16,
                  blue:  (hex & 0x0000FF00) >> 8,
                  alpha: (hex & 0x000000FF))
    }

    /// Creates new RGBA components by splitting the combined hex value into RGBA components.
    /// E.g. `RGBA<UInt8>(hex: 0x3D4A7C1B)` becomes `RGBA<UInt8>(red: 0x3D, green: 0x4A, blue: 0x7C, alpha: 0x1B)`.
    /// This overload exists so that e.g. `RGBA<UInt8>` can be created from `0xFFECDAFF` which would overflow `UInt8`.
    /// - Parameter hex: The combined RGBA hex value.
    @inlinable
    public init<Hex: BinaryInteger>(hex: Hex) {
        self.init(RGBA<Hex>(hex: hex))
    }

    /// Creates new RGBA components by parsing a given hex string into RGBA components.
    /// If the string has `0x` or `#` as prefix, it is automatically removed.
    /// Returns nil if the string is no valid hex string.
    /// E.g. `RGB<UInt8>(hexString: "0x3D4A7CFF")` becomes `RGB<UInt8>(red: 0x3D, green: 0x4A, blue: 0x7C, alpha: 0xFF)`.
    /// - Parameter hexString: The string containing hex RGBA values.
    public init?<S: StringProtocol>(hexString: S) {
        let dropCount: Int
        switch true {
        case hexString.hasPrefix("0x"): dropCount = 2
        case hexString.hasPrefix("#"): dropCount = 1
        default: dropCount = 0
        }
        guard let hexValue = UInt64(hexString.dropFirst(dropCount), radix: 16)
        else { return nil }
        self.init(hex: hexValue)
    }

    /// Computes the combined hex value for this RGBA components.
    /// E.g. for `RGBA<UInt64>(red: 0x3D, green: 0x4A, blue: 0x7C, alpha: 0xFF)` this returns `0x3D4A7CFF`.
    /// - Returns: The combined hex value for this RGB type.
    /// - Note: If the `Value` of this RGBA components is too small to hold the entire hex value, this method will trap.
    ///         Use `hexValue(as:)` to perform the convesion using a larger type.
    public func hexValue() -> Value {
        red << 24 + green << 16 + blue << 8 + alpha
    }

    /// Computes the combined hex value for this RGBA components using a given integer type.
    /// E.g. for `RGBA<UInt8>(red: 0x3D, green: 0x4A, blue: 0x7C, alpha: 0xFF)` using `UInt64` as type this returns `0x3D4A7CFF`.
    /// - Parameter : The type of integer to use.
    /// - Returns: The combined hex value for this RGB type.
    public func hexValue<I: BinaryInteger>(as _: I.Type = I.self) -> I {
        RGBA<I>(self).hexValue()
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components by splitting the combined hex value into RGBA components.
    /// E.g. `RGBA<Float>(hex: 0x3D4A7CFF)` becomes `RGB<Float>(red: 0.24, green: 0.3, blue: 0.486, alpha: 1)`.
    /// - Parameter hex: The combined RGBA hex value.
    @inlinable
    public init<Hex: BinaryInteger>(hex: Hex) {
        self.init(RGBA<Hex>(hex: hex))
    }

    /// Creates new RGBA components by parsing a given hex string into RGBA components.
    /// If the string has `0x` or `#` as prefix, it is automatically removed.
    /// Returns nil if the string is no valid hex string.
    /// E.g. `RGBA<Float>(hexString: "0x3D4A7CFF")` becomes `RGBA<Float>(red: 0.24, green: 0.3, blue: 0.486, alpha: 1)`.
    /// - Parameter hexString: The string containing hex RGBA values.
    @inlinable
    public init?<S: StringProtocol>(hexString: S) {
        guard let rgba = RGBA<UInt8>(hexString: hexString) else { return nil }
        self.init(rgba)
    }

    /// Computes the combined hex value for this RGBA components using a given integer type.
    /// E.g. for `RGBA<Float>(red: 0.5, green: 0.25, blue: 0.75, alpha: 1)` this returns `0x7F3FBFFF`.
    /// - Parameter : The type of integer to use.
    /// - Returns: The combined hex value for this RGBA type.
    @inlinable
    public func hexValue<I: BinaryInteger>(as _: I.Type = I.self) -> I {
        RGBA<I>(self).hexValue()
    }
}

extension BinaryInteger {
    @usableFromInline
    func _hexString(uppercase: Bool) -> String {
        let str = String(self, radix: 16, uppercase: uppercase)
        return str.count == 2 ? str : "0" + str
    }
}

extension RGB where Value: BinaryInteger {
    @inlinable
    func _rgbHexString(uppercase: Bool) -> String {
        red._hexString(uppercase: uppercase)
        + green._hexString(uppercase: uppercase)
        + blue._hexString(uppercase: uppercase)
    }

    /// Returns an RGB hex string representing these components.
    /// - Parameters:
    ///   - prefix: A prefix to prepend to the hex string. Defaults to an empty string.
    ///   - postfix: A postfix to append to the hex string. Defaults to an empty string.
    ///   - uppercase: Whether or not letter should be uppercase. Defaults to `false`.
    /// - Returns: A hex string of these RGB components.
    @inlinable
    public func hexString(prefix: String = "", postfix: String = "", uppercase: Bool = false) -> String {
        prefix + _rgbHexString(uppercase: uppercase) + postfix
    }
}

extension RGB where Value: BinaryFloatingPoint {
    /// Returns an RGB hex string representing these components.
    /// - Parameters:
    ///   - prefix: A prefix to prepend to the hex string. Defaults to an empty string.
    ///   - postfix: A postfix to append to the hex string. Defaults to an empty string.
    ///   - uppercase: Whether or not letter should be uppercase. Defaults to `false`.
    /// - Returns: A hex string of these RGB components.
    @inlinable
    public func hexString(prefix: String = "", postfix: String = "", uppercase: Bool = false) -> String {
        RGB<UInt8>(self).hexString(prefix: prefix, postfix: postfix, uppercase: uppercase)
    }
}

extension RGBA where Value: BinaryInteger {
    @inlinable
    func _rgbaHexString(uppercase: Bool) -> String {
        rgb._rgbHexString(uppercase: uppercase) + alpha._hexString(uppercase: uppercase)
    }

    /// Returns an RGBA hex string representing these components.
    /// - Parameters:
    ///   - prefix: A prefix to prepend to the hex string. Defaults to an empty string.
    ///   - postfix: A postfix to append to the hex string. Defaults to an empty string.
    ///   - uppercase: Whether or not letter should be uppercase. Defaults to `false`.
    /// - Returns: A hex string of these RGBA components.
    @inlinable
    public func hexString(prefix: String = "", postfix: String = "", uppercase: Bool = false) -> String {
        prefix + _rgbaHexString(uppercase: uppercase) + postfix
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    /// Returns an RGBA hex string representing these components.
    /// - Parameters:
    ///   - prefix: A prefix to prepend to the hex string. Defaults to an empty string.
    ///   - postfix: A postfix to append to the hex string. Defaults to an empty string.
    ///   - uppercase: Whether or not letter should be uppercase. Defaults to `false`.
    /// - Returns: A hex string of these RGBA components.
    @inlinable
    public func hexString(prefix: String = "", postfix: String = "", uppercase: Bool = false) -> String {
        RGBA<UInt8>(self).hexString(prefix: prefix, postfix: postfix, uppercase: uppercase)
    }
}
