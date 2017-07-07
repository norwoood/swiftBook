//: Playground - noun: a place where people can play

import UIKit


func complte(_ array: [Int], _ transfrom: (Int) -> Int) -> [Int] {
    
    var result: [Int] = []
    
    for x in array {
        
        result.append(transfrom(x))
        
    }
    
    return result
}


func double(_ array: [Int]) -> [Int] {
    
    return complte(array){$0 * 2}
    
}


//类型签名 type signature

//函数族，Element,T每选择一个不同类型的参数，都会唯一确定一个函数
func map<Element, T>(_ array: [Element], transfrom: (Element) -> T) -> [T]{
    
    var result: [T] = []
    
    for x in array {
        
        result.append(transfrom(x))
        
    }
    
    return result
}


//作为一个顶层函数与作为一个函数的扩展

extension Array {

    func map<T>(_ transfrom: (Element) -> T) -> [T] {
        
        var result: [T] = []
        
        for x in self {
            
            result.append(transfrom(x))
            
        }
        return result
    }
    
}


extension Array {
    
    func filter(_ transfrom: (Element) -> Bool) -> [Element] {
        
        var result: [Element] = []
        
        for x in self where transfrom(x) {
            result.append(x)
        }
        
        return result
    }
    
}

[1,2,3,4,5].filter{ $0 % 2 == 0 }


extension Array {
    
    func reduce<T>(_ initialize: T, combine: (T,Element) -> T) -> T {
        var result = initialize
        
        for x in self {
            result = combine(result,x)
        }
        
        return result
    }
    
}


[1,2,3,4,5].reduce(1, combine: { $0 * $1 })
["a","b","c"].reduce("", combine: { $0 + $1 })


extension Array {
    
    func mapReduce<T>(_ transfrom: (Element) -> T) -> [T] {
        
        return reduce([], combine: { (x, y) -> [T] in
           return x + [transfrom(y)]
        })
        
    }
    
    func mapFilter(_ transfrom: (Element) -> Bool) -> [Element] {
        
        return reduce([], combine: { (result, x) -> [Element] in
            return transfrom(x) ? result + [x] : result
        })
        
    }
    
}













