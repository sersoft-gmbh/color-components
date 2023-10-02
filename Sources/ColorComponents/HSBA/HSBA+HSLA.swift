extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components using the given HSL components.
    /// - Parameter hsl: The HSL components to convert to HSB.
    public init(hsl: HSL<Value>) {
        let brightness = hsl.brightness
        self.init(hue: hsl.hue,
                  saturation: brightness.isZero ? .zero : 2 * (1 - hsl.luminance / brightness),
                  brightness: brightness)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components using the given HSLA components.
    /// - Parameter hsla: The HSLA components to convert to HSBA.
    /// - SeeAlso: ``HSB/init(hsl:)``
    @inlinable
    public init(hsla: HSLA<Value>) {
        self.init(hsb: HSB(hsl: hsla.hsl), alpha: hsla.alpha)
    }
}

extension HSB where Value: BinaryInteger {
    /// Creates new HSB components using the given HSL components.
    /// - Parameter hsl: The HSL components to convert to HSB.
    public init(hsl: HSL<Value>) {
        // FIXME: Can we perform a better conversion here?
        self.init(HSB<Double>(hsl: HSL<Double>(hsl)))
    }
}

extension HSBA where Value: BinaryInteger {
    /// Creates new HSBA components using the given HSLA components.
    /// - Parameter hsla: The HSLA components to convert to HSBA.
    /// - SeeAlso: ``HSB/init(hsl:)``
    @inlinable
    public init(hsla: HSLA<Value>) {
        self.init(hsb: HSB(hsl: hsla.hsl), alpha: hsla.alpha)
    }
}
