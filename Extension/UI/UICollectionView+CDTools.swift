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

public extension UICollectionView {
    
    public func reloadSections(at index: Int) {
        reloadSections(IndexSet(integer: index))
    }
    
    public func reloadSections(indices: [Int]) {
        let indexSet = NSMutableIndexSet()
        for index in indices {
            indexSet.add(index)
        }
        reloadSections(indexSet as IndexSet)
    }
    
}
