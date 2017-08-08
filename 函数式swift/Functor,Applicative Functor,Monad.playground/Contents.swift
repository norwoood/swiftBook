//: Playground - noun: a place where people can play

import UIKit


//牛顿  爱因斯坦  麦克斯韦 薛定谔 海森堡  狄拉克  杨振宁

//Map 
//两个参数: 即将被映射的数据结构, 一个类型为(T) -> U 的transfrom函数，这种支持map运算的类型构造体也可以被称为Functor

//functor 称为容纳特定值得容器,map对存储在容器中的值进行转换
//


// [T] == Array<T>, T? == Option<T>
// 类型构造体，需要一个泛型参数来构造一个具体的类型


struct Position {
    
    var x: Double
    var y: Double
    
}

struct Result<T>{
    
    let value: (Position) -> T
    
}


extension Result {
    
    func map<U>(transform: @escaping (T) -> U) -> Result<U> {
        return Result<U>.init(value: { (pos) -> U in
            return transform(self.value(pos))
        })
    }
    
}

//函子大部分时候都是容器，但上面这个就不是容器，用一个函数类型来表示区域,可以关联



