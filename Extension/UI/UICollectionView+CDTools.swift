import UIKit
import Foundation

public extension UICollectionView {
    /* Quality of Life convenience function
     */
    public func register(cell: UICollectionViewCell.Type, bundle: Bundle? = Bundle.main) {
        let nib = UINib.init(nibName: cell.className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}

