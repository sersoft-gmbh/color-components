extension HSB where Value: BinaryFloatingPoint {
    public init(rgb: RGB<Value>) {
        let maxVal = max(rgb.red, rgb.green, rgb.blue)
        let delta = maxVal - min(rgb.red, rgb.green, rgb.blue)
        let hue: Value
        switch maxVal {
        case rgb.red: hue = (rgb.green - rgb.blue) / delta
        case rgb.green: hue = 2 + (rgb.blue - rgb.red) / delta
        case rgb.blue: hue = 4 + (rgb.red - rgb.green) / delta
        default: fatalError("max should always be one of rgb!")
        }
        self.init(hue: hue, saturation: delta.isZero ? 0 : delta / maxVal, brightness: maxVal)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(hsb: HSB(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}
