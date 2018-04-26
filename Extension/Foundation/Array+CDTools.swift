import Foundation

public extension Array {
    
    public mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }

    public func index(of item: AnyObject) -> Int? {
        
        for current in enumerated() where (current.element as AnyObject) === item {
            return current.offset
        }
        
        return nil
    }
    
}
