

import UIKit

extension UITableView {
    
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
}
