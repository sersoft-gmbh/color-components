extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components using the given HSB components.
    /// - Parameter hsb: The HSB components to convert to RGB.
    public init(hsb: HSB<Value>) {
        let chroma = hsb.brightness * hsb.saturation
        self.init(hue: hsb.hue, chroma: chroma, match: hsb.brightness - chroma)
    }
}

extension RGB where Value: BinaryInteger {
    /// Creates new RGB components using the given HSB components.
    /// - Parameter hsb: The HSB components to convert to RGB.
    public init(hsb: HSB<Value>) {
        // FIXME: Is there a better way to convert this?
        self.init(RGB<Double>(hsb: HSB<Double>(hsb)))
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components using the given HSBA components.
    /// - Parameter hsba: The HSBA components to convert to RGBA.
    @inlinable
    public init(hsba: HSBA<Value>) {
        self.init(rgb: RGB(hsb: hsba.hsb), alpha: hsba.alpha)
    }
}

extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components using the given HSBA components.
    /// - Parameter hsba: The HSBA components to convert to RGBA.
    @inlinable
    public init(hsba: HSBA<Value>) {
        self.init(rgb: RGB(hsb: hsba.hsb), alpha: hsba.alpha)
    }
}
