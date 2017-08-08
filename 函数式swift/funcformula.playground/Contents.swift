
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

    
}


extension BinarySearchTree {
    
    
    var count: Int{
        /*
        switch self {
        case .leaf:
            return 0
        case let .node(left,_,right):
            return 1 + left.count + right.count
            
        }*/
        
        return reduce(leaf: 0){
            1 + $0 + $2
        }
        
    }
    
    var elements: [Element] {
        /*
        switch self {
        case .leaf:
            return []
        case let .node(left,x,right):
            return left.elements + [x] + right.elements
            
        }*/
        
        return reduce(leaf: []){
            
            $0 + [$1] + $2
            
        }
        
        
        
    }
    
    
    func reduce<A>(leaf leafF: A, node nodeF: (A,Element,A) -> A) -> A {
        
        switch self {
        case .leaf:
            return leafF
        case let .node(left,x,right):
            return nodeF(left.reduce(leaf: leafF, node: nodeF),x,right.reduce(leaf: leafF, node: nodeF))
        }
        
    }
    
    
    var isEmpty: Bool {
        
        if case .leaf = self{
            return true
        }
        
        return false
    }
    
    
}

extension BinarySearchTree where Element: Equatable {
    
    var isBST: Bool {
        
        
        switch self {
        case .leaf:
            return true
        case let .node(left,x,right):
            return left.elements.all{ y in y < x }
                && right.elements.all{ y in y > x }
                && left.isBST
                && right.isBST
        }
        
        
    }
    
}


extension Sequence{
    
    func all(predicate:(Iterator.Element) -> Bool) -> Bool {
        
        for x in self where !predicate(x){
            return false
        }
        
        return true
    }
    
}




extension BinarySearchTree {
    
    func contains(_ element: Element) -> Bool {
        
        switch self {
        case .leaf:
            return false
        case let .node(_,x,_) where x == element:
            return true
        case let .node(left,x,_) where element < x:
            return left.contains(element)
        case let .node(_,x,right) where element > x:
            return right.contains(element)
        default:
            fatalError("include all sitautions")
        }
        
    }
    
    mutating func insert(_ x: Element) -> Void {
        
        switch self {
        case .leaf:
            self = BinarySearchTree(x)
        case .node(var left,let y,var right):
            if x > y { right.insert(x) }
            if x < y { left.insert(x) }
            self = .node(left,y,right)
        }
        
    }
    
}



var x: BinarySearchTree<Int> = .leaf

for y in stride(from: 1, to: 8, by: 1){
    
    x.insert(y)
    
}

//字典树
//


extension Array {
    var slice: ArraySlice<Element>{
        
        return ArraySlice(self)
    }
}


extension ArraySlice {
    
    var decomposed: (Element,ArraySlice<Element>)? {
        
        return isEmpty ? nil : (self[startIndex],self.dropFirst())
        
    }
    
    
}



func sum(_ integers: ArraySlice<Int>) -> Int {
    
    guard let (head,last) = integers.decomposed else { return 0 }
    
    return head + sum(last)
    
}

struct Trie<Element: Hashable>{
    
    let isElement: Bool
    
    let children: [Element: Trie<Element>]
    
}


extension Trie {
    
    init() {
        
        isElement = false
        children = [:]
        
    }
    
    func complete(key: ArraySlice<Element>) -> [[Element]] {
        return loookUp(key)?.elements ?? []
    }
    
}

extension Trie{
    
    var elements: [[Element]] {
        
        var result: [[Element]] = isElement ? [[]] : []
        
        for (key,value) in children {
            
            result += value.elements.map{ [key] + $0 }
            
        }
        
        return result
        
    }
    
}

extension Trie {
    
    func loookUp(_ key: ArraySlice<Element>) -> Trie<Element>? {
        
        guard let (head,last) = key.decomposed else { return nil }
        //print("\(head) \(last)")
        
        guard let subtrie = children[head] else { return nil }
        
        return subtrie.loookUp(last)
        
    }
    
}


extension Trie {
    
    init(_ key: ArraySlice<Element>) {
        
        if let (head, trail) = key.decomposed {
            
            let children = [head: Trie(trail)]
            self = Trie.init(isElement: false, children: children)
            
        }else{
            
            self = Trie.init(isElement: true, children: [:])
            
        }
        
    }
    
}

extension Trie {
    
    
    func insert(_ key: ArraySlice<Element>) -> Trie<Element> {
        
        guard let (head,trail) = key.decomposed else {
            return Trie.init(isElement: true, children: children)
        }
        
        var newChildren = children

        if let nexttril = children[head] {
            
            newChildren[head] = nexttril.insert(trail)
            
        }else{
            
            newChildren[head] = Trie(trail)
            //print(newChildren)
            //print(trail)
        }
        
        return Trie.init(isElement: isElement, children: newChildren)
    }
    
    
}



extension Trie {
    
    static func buildWorlds(_ worlds: [String]) -> Trie<Character> {
        
        
        let empty = Trie<Character>()
        
        return worlds.reduce(empty){
            
            trie ,world in
            //print(world)
            return trie.insert(Array(world.characters).slice)
            
        }
    }
    
}


extension String {
    
    func complement(_ knownWorlds:Trie<Character>) -> [String] {
        
        let chars = Array(characters).slice
        let complement = knownWorlds.complete(key: chars)
        return complement.map{
            
            charss in
            self + String(chars)
            
        }
    }
    
}


let conentssss = ["cat","dog","car","cart"]

let trieworlds = Trie<Character>.buildWorlds(conentssss)

let str = "cat".complement(trieworlds)
print(str)











