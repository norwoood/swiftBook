//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//为类型定义别名, API更加代码即文章
typealias Distance = Double

struct Position {
    
    var x: Distance
    var y: Distance
    
}

//计算一个点是否在一个圆内
extension Position {
    
    func inCircular(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
    
    func distancePosition(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
    
}

//example
let x = Position(x: 3, y: 4)

x.inCircular(range: 5)


struct Ship {

    var firingRange: Distance
    var position: Position
    var unsafeRange: Distance
    
}

//是否能射击到一个船，算出相对距离

extension Ship {
    
    func isEnable(ship: Ship) -> Bool {
        
        let dx = ship.position.x - position.x
        let dy = ship.position.y - position.y
        let distance = sqrt(dx * dx + dy * dy)
        return distance <= firingRange
    }
    
    func isSafeEnable(ship: Ship) -> Bool {
        
        let dx = ship.position.x - position.x
        let dy = ship.position.y - position.y
        let distance = sqrt(dx * dx + dy * dy)
        return distance <= firingRange && distance > unsafeRange
    }
    
    func isSafeEnableFriend(ship target: Ship, friend: Ship) -> Bool {
        
        let distance = target.position.distancePosition(position).length
        
        let safd = target.position.distancePosition(friend.position).length
        
        return distance <= firingRange && distance > unsafeRange && safd > unsafeRange
    }
    
}


//函数式编程

typealias Region = (Position) -> Bool


func circle(radius: Distance) -> Region{
    //返回一个闭包, 闭包的函数唯一表达式就是Region, Region的运算法则都写在了闭包中
    return { point in point.length < radius }
}







