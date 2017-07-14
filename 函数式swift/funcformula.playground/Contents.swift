
import UIKit

//纯函数式数据结构

struct MySet<Element: Equatable>{
    
    var elemsnts: [Element] = []
    
    var isEmpty: Bool {
        
        return elemsnts.isEmpty
    }
    
    func contains(_ element: Element) -> Bool {
        return elemsnts.contains(element)
    }
    
    func insert(_ x: Element) -> MySet {
        return contains(x) ? self : MySet(elemsnts: elemsnts + [x])
    }
    
}

indirect enum BinarySearchTree<Element: Comparable> {
    //没有关联值得叶子
    case leaf
    //一个带有三个关联值的节点node
    case node(BinarySearchTree<Element>,
        Element, BinarySearchTree<Element>)

}

extension BinarySearchTree {
    
    init() {
        
        self = .leaf
        
    }
    
    init(_ value: Element){
        
        self = .node(.leaf,value,.leaf)
        
    }
    
    var count: Int{
        
        switch self {
        case .leaf:
            return 0
        case let .node(left,_,right):
            return 1 + left.count + right.count
            
        }
    }
    
    
    
        
        
        
}








