//: Playground - noun: a place where people can play


//只要遵循IteratorProtocol 就是迭代器

//

struct ReverseIndexIterator: IteratorProtocol{
    
    var index: Int
    
    init<T>(_ array: [T]) {
        
        index = array.endIndex-1
        
    }
    
    mutating func next() -> Int? {
    
        guard index >= 0 else {
            return nil
        }
        
        defer {
            
            index -= 1
        }
        
        //
        return index
        
        
    }
    
}


extension IteratorProtocol {
    
    
    mutating func find(predicate: (Element) -> Bool) -> Element? {
        
        while let x = next() {
            
            if predicate(x) {
                return x
            }
            
        }
        
        return nil
        
    }
    
    
}


struct LimitIterator<I: IteratorProtocol>: IteratorProtocol {
    
    var limit = 0
    var iterator: I
    
    init(_ limit: Int, iterator: I) {
        self.limit = limit
        self.iterator = iterator
    }
    
    mutating func next() -> I.Element? {
    
        guard limit > 0 else {
            return nil
        }
        
        limit -= 1
        
        return iterator.next()
        
    }
    
}



extension Int {
    
    func countDown() -> AnyIterator<Int> {
        
        var i = self - 1
        
        return AnyIterator.init{
            
            guard i >= 0 else { return nil }
            
            i -= 1
            
            return i
            
        }
        
    }
    
}

infix operator +++

func +++ <I: IteratorProtocol, J: IteratorProtocol>(first: I, second: @escaping @autoclosure () -> J) -> AnyIterator<I.Element> where I.Element == J.Element {
    var one = first
    var jj: J? = nil
    
    return AnyIterator {
        
        if jj != nil {
            return jj!.next()
        }else if let result = one.next() {
            return result
        }else{
            
            jj = second()
            return jj?.next()
            
        }
        
    }
    
}




///Sequence
///Iterator 单次触发机制,不支持反查和重新生成已经生产过得元素

struct ReversedSequence<T>: Sequence {
    
    let array: [T]
    
    init(_ array: [T]) {
        self.array = array
    }
    
    func makeIterator() -> ReverseIndexIterator {
        return ReverseIndexIterator(array)
    }
    
    
}

//创建和使用分离 高内聚  低耦合

let array = [1,2,3,4,5,6]

var reverss = ReversedSequence(array)

var reveriii = reverss.makeIterator()

while let x = reveriii.next() {
    
    //print("\(x) is  \(array[x])")
    
}

for x in reverss {
    
    //print("\(x) is \(array[x])")
}
for x in reverss {
    
    //print("\(x) is \(array[x])")
}

//let lazyResult = (0...10).lazy.filter{ $0 % 3 == 0 }.map{ $0 * $0 }

//let lazyarraysss = Array(lazyResult)

precedencegroup Apply { associativity: left }
infix operator <*>: Apply

func <*><A, B>(optionalTransform: ((A) -> B)?, optionalValue: A?) -> B? {
    
    guard let transform = optionalTransform,
        let value = optionalValue else { return nil }
    return transform(value)

}


func pure<A>(_ value: A) -> A? {

    return value

}

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {

    return { a in { b in f(a, b) } }

}


func addOption(_ optionX: Int?, _ optionY: Int?) -> Int? {
    
    
    return pure(curry(+)) <*> optionX <*> optionY
    
}




struct Position {
    
    var x: Double
    var y: Double
}



struct Region<T> {
    
    let value: (Position) -> T
    
}

infix operator +++++: Apply

extension Region {
    
    
    
    func map<U>(_ transfrom: @escaping (T) -> U) -> Region<U> {
        
        return Region<U>{ pos in transfrom(self.value(pos)) }
        
    }
    
    func pure<A>(_ value: A) -> Region<A> {
        return Region<A> { pos in value }
    }
    
    func everyWhere() -> Region<Bool> {
        return pure(true)
    }
    
    /*static func +++++<A,B>(regionF: Region<(A) -> B>, regionX: Region<A>) -> Region<B> {
    
        return Region { pos in regionF.value(pos)(regionX.value(pos)) }
    
    }*/
    
}




