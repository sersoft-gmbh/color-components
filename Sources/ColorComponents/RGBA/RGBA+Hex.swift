extension RGB where Value: BinaryInteger {
    /// Creates new RGB components by splitting the combined hex value into RGB components.
    /// E.g. `RGB(hex: 0x3D4A7C)` becomes `RGB(red: 0x3D, green: 0x4A, blue: 0x7C)`.
    /// - Parameter hex: The combined RGB hex value.
    public init(hex: Value) {
        self.init(red:   (hex & 0xFF0000) >> 16,
                  green: (hex & 0x00FF00) >> 8,
                  blue:  (hex & 0x0000FF))
    }
}

extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components by splitting the combined hex value into RGBA components.
    /// E.g. `RGBA(hex: 0x3D4A7C1B)` becomes `RGBA(red: 0x3D, green: 0x4A, blue: 0x7C, alpha: 0x1B)`.
    /// - Parameter hex: The combined RGBA hex value.
    public init(hex: Value) {
        self.init(red:   (hex & 0xFF000000) >> 24,
                  green: (hex & 0x00FF0000) >> 16,
                  blue:  (hex & 0x0000FF00) >> 8,
                  alpha: (hex & 0x000000FF))
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
