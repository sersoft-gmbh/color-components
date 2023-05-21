extension RGB where Value: BinaryFloatingPoint {
    var hsbvValues: (hue: Value, x: (min: Value, max: Value), delta: Value) {
        let xMin = min(red, green, blue)
        let xMax = max(red, green, blue)
        let delta = xMax - xMin
        let hue: Value
        if delta.isZero {
            hue = .zero
        } else {
            switch xMax {
            case red:   hue =     (green - blue)  / delta
            case green: hue = 2 + (blue  - red)   / delta
            case blue:  hue = 4 + (red   - green) / delta
            default: fatalError("max(r, g, b) must be one of r, g, b!")
            }
        }
        return (hue / 6, (xMin, xMax), delta)
    }

    init(hue: Value, chroma: Value, match: Value) {
        let hueSixty = max(0, min(hue, 1)) / (60 / 360)
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

        self.init(red: r + match, green: g + match, blue: b + match)
    }
}
