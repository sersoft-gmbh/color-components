extension RGB where Value: BinaryInteger {
    public init(hex: Value) {
        self.init(red:   (hex & 0xFF0000) >> 16,
                  green: (hex & 0x00FF00) >> 8,
                  blue:  (hex & 0x0000FF))
    }
}

extension RGBA where Value: BinaryInteger {
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

    @inlinable
    public func hexString(prefix: String = "", postfix: String = "", uppercase: Bool = false) -> String {
        prefix + _rgbaHexString(uppercase: uppercase) + postfix
    }
}
