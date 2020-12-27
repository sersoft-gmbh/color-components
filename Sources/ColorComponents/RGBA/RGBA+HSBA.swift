extension RGB where Value: BinaryFloatingPoint {
    public init(hsb: HSB<Value>) {
        let chroma = hsb.brightness * hsb.saturation
        let hueDeg: Value = {
            var tmp = hsb.hue * 180 / .pi
            if tmp < 0 {
                tmp = abs(tmp)
            }
            if tmp > 360 {
                tmp.formTruncatingRemainder(dividingBy: 360)
            }
            return tmp
        }()
        let hueSixty = hueDeg / 60
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

        let match = hsb.saturation - chroma
        self.init(red: r + match, green: g + match, blue: b + match)
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(hsba: HSBA<Value>) {
        self.init(rgb: RGB(hsb: hsba.hsb), alpha: hsba.alpha)
    }
}
