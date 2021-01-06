extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components using the given HSB components.
    /// - Parameter hsb: The HSB components to convert to RGB.
    public init(hsb: HSB<Value>) {
        let chroma = hsb.brightness * hsb.saturation
        let hueSixty = max(0, min(hsb.hue, 1)) / (60 / 360)
        let x = chroma * (1 - abs(hueSixty.truncatingRemainder(dividingBy: 2) - 1))

        let (r, g, b): (Value, Value, Value)
        switch hueSixty {
        case (0...1): (r, g, b) = (chroma, x, 0)
        case (1...2): (r, g, b) = (x, chroma, 0)
        case (2...3): (r, g, b) = (0, chroma, x)
        case (3...4): (r, g, b) = (0, x, chroma)
        case (4...5): (r, g, b) = (x, 0, chroma)
        case (5...6): (r, g, b) = (chroma, 0, x)
        default: fatalError("Invalid value of hue / 60deg: \(hueSixty)")
        }

        let match = hsb.brightness - chroma
        self.init(red: r + match, green: g + match, blue: b + match)
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
