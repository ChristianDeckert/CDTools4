import UIKit
import Foundation

extension UICollectionView {
    /* Quality of Life convenience function
     */
    func register(cell: UICollectionViewCell.Type, bundle: Bundle? = Bundle.main) {
        let nib = UINib.init(nibName: cell.className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}

