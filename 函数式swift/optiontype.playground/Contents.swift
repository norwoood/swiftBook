//: Playground - noun: a place where people can play

import UIKit

//swift可选值表示一个值得缺失，或者计算失败


let dictionary = ["beijing": 30000000, "chongqing": 40000000, "hebei": 100000000]



//可选绑定  don't force unwrapping

if let cq = dictionary["chongqing"] {
    
    print("cq population is \(cq)")
    
}else{
    
    print("undefine key of chongqing")
    
}


//let cqqq = dictionary["hebei"] ?? 11111

infix operator ????

func ???? <T>(_ option: T? , defaultVAlue: @autoclosure ()throws -> T)rethrows -> T {
    
    if let x = option {
        return x
    }else{
        return try defaultVAlue()
    }
}

//可选链
struct Order {
    
    let orderNumber: Int
    let person: Person?
    
}


struct Person{
    
    let name: String
    let address: Address?
}

struct Address{
    
    let state: String?
    let city: String
    let streetName: String
    
}


let order1 = Order(orderNumber: 1, person: nil)

order1.person?.address?.state
// 任何一个可选值的返回nil都会终止可选链


//分支上的可选值  switch语句    guard 语句，当可选值为空的时候，需要提前退出就用这个guard语句 
//与可选绑定一起处理没有值得情况

// 可选映射

func add(_ optionX: Int?, _ optionY: Int?) -> Int? {
    
    if let x = optionX , let y = optionY {
        
        return x + y
        
    }
    
    return nil
}

func addg(_ optionX: Int?, _ optionY: Int?) -> Int? {
    
    guard let x = optionX, let y = optionY else {
        return nil
    }
    
    return x + y
}








extension Optional {
    

    func flatMap<U>(_ transfrom: (Wrapped) -> U?) -> U? {
        
        guard let x = self else {
            return nil
        }
        
        return transfrom(x)
    }
    
}


func addf1(_ optionX: Int?, _ optionY: Int?) -> Int? {

    return optionX.flatMap{
        
        x in
        
        optionY.flatMap{
            
            y in
            return x + y
        }
        
    }
    
}


//为什么使用可选型
//增强了代码的静态安全性
//提供了更加丰富的函数签名，代码即文档的感觉
//类型系统的安全性的补充

















