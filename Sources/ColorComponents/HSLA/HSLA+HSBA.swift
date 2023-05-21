extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components using the given HSB components.
    /// - Parameter hsb: The HSB components to convert to HSL.
    public init(hsb: HSB<Value>) {
        let luminance = hsb.luminance
        self.init(hue: hsb.hue,
                  saturation: luminance.isZero || luminance == 1 ? .zero : (hsb.brightness - luminance) / min(luminance, 1 - luminance),
                  luminance: luminance)
    }
}

extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components using the given HSBA components.
    /// - Parameter hsba: The HSBA components to convert to HSLA.
    /// - SeeAlso: `HSL.init(hsb:)`
    @inlinable
    public init(hsba: HSBA<Value>) {
        self.init(hsl: HSL(hsb: hsba.hsb), alpha: hsba.alpha)
    }
}

extension HSL where Value: BinaryInteger {
    /// Creates new HSL components using the given HSB components.
    /// - Parameter hsb: The HSB components to convert to HSL.
    public init(hsb: HSB<Value>) {
        // FIXME: Can we perform a better conversion here?
        self.init(HSL<Double>(hsb: HSB<Double>(hsb)))
    }
}

extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components using the given HSBA components.
    /// - Parameter hsba: The HSBA components to convert to HSLA.
    /// - SeeAlso: `HSL.init(hsb:)`
    @inlinable
    public init(hsba: HSBA<Value>) {
        self.init(hsl: HSL(hsb: hsba.hsb), alpha: hsba.alpha)
    }
}
