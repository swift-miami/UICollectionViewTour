
import UIKit

extension UIView {

    static var onePixel: CGFloat {
        get {
            return 1.0 / UIScreen.main.scale
        }
    }
}
