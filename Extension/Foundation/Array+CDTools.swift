import Foundation

public extension Array {
    public mutating func shuffle(iterations: Int = 10) {
        for _ in 0..<iterations{
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
