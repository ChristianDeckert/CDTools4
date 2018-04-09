import UIKit
import Foundation

extension UITableView {
    /* Quality of Life convenience function
     */
    func register(cell: UITableViewCell.Type, bundle: Bundle? = Bundle.main) {
        let nib = UINib.init(nibName: cell.className, bundle: bundle)
        register(nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

