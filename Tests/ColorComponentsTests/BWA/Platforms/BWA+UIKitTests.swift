import Testing
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

extension BWATests {
    @Suite(.enabled(if: .uiKitAvailable))
    struct UIKitTests {
        @Test
        func uiColorCreationWithFloatingPoint() throws {
            // The compiler(6.0) check here is needed due to a bug in Swift 6.0. Remove this as of 6.1.
#if compiler(>=6.0) && canImport(UIKit)
            let bw = BW<CGFloat>(white: 0.5)
            let bwa = BWA(bw: bw, alpha: 0.25)
            
            let opaqueColor = UIColor(bw)
            let alphaColor = UIColor(bwa)
            
            var (white, alpha) = (CGFloat(), CGFloat())
#if compiler(>=6.2)
            #expect(unsafe opaqueColor.getWhite(&white, alpha: &alpha))
#else
            #expect(opaqueColor.getWhite(&white, alpha: &alpha))
#endif
            #expect(white == bw.white)
            #expect(alpha == 1)
            (white, alpha) = (0, 0)
#if compiler(>=6.2)
            #expect(unsafe alphaColor.getWhite(&white, alpha: &alpha))
#else
            #expect(alphaColor.getWhite(&white, alpha: &alpha))
#endif
            #expect(white == bwa.white)
            #expect(alpha == bwa.alpha)
#endif
        }
        
        @Test
        func creationFromUIColorWithFloatingPoint() throws {
#if canImport(UIKit)
            let white: CGFloat = 0.5
            let alpha: CGFloat = 0.25
            let color = UIColor(white: white, alpha: alpha)
            
            let bw = BW<CGFloat>(color)
            let bwa = BWA<CGFloat>(color)
            
            #expect(bw.white == white)
            #expect(bwa.white == white)
            #expect(bwa.alpha == alpha)
            #expect(BW<InexactFloat>(exactly: NoCompsUIColor(white: white, alpha: alpha)) == nil)
            #expect(BW<InexactFloat>(exactly: NoCompsUIColor(white: white, alpha: alpha)) == nil)
            #expect(BW<InexactFloat>(exactly: color) == nil)
            #expect(BW<InexactFloat>(exactly: color) == nil)
#endif
        }
        
        @Test
        func uiColorCreationWithInteger() throws {
            // The compiler(6.0) check here is needed due to a bug in Swift 6.0. Remove this as of 6.1.
#if compiler(>=6.0) && canImport(UIKit)
            let bw = BW<UInt8>(white: 0x80)
            let bwa = BWA(bw: bw, alpha: 0x40)
            
            let opaqueColor = UIColor(bw)
            let alphaColor = UIColor(bwa)
            
            var (white, alpha) = (CGFloat(), CGFloat())
#if compiler(>=6.2)
            #expect(unsafe opaqueColor.getWhite(&white, alpha: &alpha))
#else
            #expect(opaqueColor.getWhite(&white, alpha: &alpha))
#endif
            #expect(white == CGFloat(bw.white) / 0xFF)
            #expect(alpha == 1)
            (white, alpha) = (0, 0)
#if compiler(>=6.2)
            #expect(unsafe alphaColor.getWhite(&white, alpha: &alpha))
#else
            #expect(alphaColor.getWhite(&white, alpha: &alpha))
#endif
            #expect(white == CGFloat(bwa.white) / 0xFF)
            #expect(alpha == CGFloat(bwa.alpha) / 0xFF)
#endif
        }
        
        @Test
        func creationFromUIColorWithInteger() throws {
#if canImport(UIKit)
            let white: CGFloat = 0.75
            let alpha: CGFloat = 0.25
            let color = UIColor(white: white, alpha: alpha)
            
            let bw = BW<UInt8>(color)
            let bwa = BWA<UInt8>(color)
            
            #expect(bw.white == UInt8(white * 0xFF))
            #expect(bwa.white == UInt8(white * 0xFF))
            #expect(bwa.alpha == UInt8(alpha * 0xFF))
            #expect(BW<Int8>(exactly: NoCompsUIColor(white: white, alpha: alpha)) == nil)
            #expect(BW<Int8>(exactly: NoCompsUIColor(white: white, alpha: alpha)) == nil)
            #expect(BW<Int8>(exactly: color) == nil)
            #expect(BW<Int8>(exactly: color) == nil)
#endif
        }
    }
}
