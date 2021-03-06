import UIKit
import Foundation

public extension UICollectionViewCell {

    public static func dequeue<T: UICollectionViewCell>(in collectionView: UICollectionView, at indexPath: IndexPath) -> T {
        if nil == collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T {
            collectionView.register(cell: T.self)
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T ?? T()
    }
}
