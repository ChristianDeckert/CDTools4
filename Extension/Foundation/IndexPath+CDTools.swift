import Foundation

extension IndexPath {
    
    static var zero: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    var nextRow: IndexPath {
        return IndexPath(row: self.row + 1, section: self.section)
    }
    
    var nextItem: IndexPath {
        return IndexPath(item: self.item + 1, section: self.section)
    }
    
    var previousRow: IndexPath {
        let row: Int = self.row - 1 < 0 ? 0 : self.row - 1
        return IndexPath(row: row, section: self.section)
    }
    
    var previousItem: IndexPath {
        let item: Int = self.item - 1 < 0 ? 0 : self.item - 1
        return IndexPath(item: item, section: self.section)
    }
}
