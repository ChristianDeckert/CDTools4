import UIKit
import Foundation

public extension UITableViewCell {
    
    public static func dequeue<T: UITableViewCell>(in tableView: UITableView) -> T {
        if nil == tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
            tableView.register(cell: T.self)
        }
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T ?? T()
    }
}
