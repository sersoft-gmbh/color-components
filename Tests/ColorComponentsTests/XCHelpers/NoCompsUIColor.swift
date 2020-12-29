#if canImport(UIKit)
import UIKit

final class NoCompsUIColor: UIColor {
    override func getWhite(_ white: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool {
        false
    }

    override func getHue(_ hue: UnsafeMutablePointer<CGFloat>?,
                         saturation: UnsafeMutablePointer<CGFloat>?,
                         brightness: UnsafeMutablePointer<CGFloat>?,
                         alpha: UnsafeMutablePointer<CGFloat>?) -> Bool {
        false
    }

    override func getRed(_ red: UnsafeMutablePointer<CGFloat>?,
                         green: UnsafeMutablePointer<CGFloat>?,
                         blue: UnsafeMutablePointer<CGFloat>?,
                         alpha: UnsafeMutablePointer<CGFloat>?) -> Bool {
        false
    }
}
#endif
