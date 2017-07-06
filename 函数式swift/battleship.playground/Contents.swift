//: Playground - noun: a place where people can play

import UIKit
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
    
    func canSafeEnage(ship target: Ship, friend: Ship) -> Bool {
        
        let rangeRegion = subtract(circle(radius: firingRange), from: circle(radius: unsafeRange))
        
        let firRange = shift(rangeRegion, by: position)
        
        let friendlyRange = shift(circle(radius: unsafeRange), by: friend.position)
        
        let resultRegion = subtract(firRange, from: friendlyRange)
        
        return resultRegion(target.position)
    }
    //求交集的问题
}

//函数式编程

typealias Region = (Position) -> Bool


func circle(radius: Distance) -> Region{
    //返回一个闭包, 闭包的函数唯一表达式就是Region, Region的运算法则都写在了闭包中
    return { point in point.length <= radius }
}

func circle2(radius: Distance, center: Position) -> Region  {
    //圆心在任意位置，半径为radius的圆， 返回一个函数，判断是否一个点在圆内
    return { point in point.distancePosition(center).length <= radius }
    
}

//逃逸闭包当函数返回的时候需要使用其参数，那么这个参数需要被标记为@escaping
func shift(_ region: @escaping Region, by offset: Position) -> Region {
    
    return { point in region(point.distancePosition(offset)) }
    
}

//中心在圆点的圆外所有点的判断
func invert(_ region: @escaping Region) -> Region {
    
    return { point in !region(point) }
    
}


//两个区域的交集
func intersect(_ region: @escaping Region, with other: @escaping Region) -> Region{
    
    return { point in region(point) && other(point) }
    
}


//两个区域的并集
func union(_ region: @escaping Region, with other: @escaping Region) -> Region{
    
    return { point in region(point) || other(point) }
    
}


//所有在第一个区域且不再第二个区域的点构建函数
func subtract(_ region: @escaping Region, from origion: @escaping Region) -> Region{
    
    return intersect(region, with: invert(origion))
    
}





circle(radius: 3)(x)
circle2(radius: 15, center: Position(x: 5, y: 5))(Position(x: 20, y: 5))

//圆心为5，5  半径为10的圆
shift(circle(radius: 10), by: Position(x: 5, y: 5))(Position(x: 5, y: 15))


invert(circle(radius: 5))(Position(x: 3, y: 4))


//类型驱动开发  类型一定程度上可以左右开发的流程

//针对此案例我们还可以采用结构体的形式


struct Regionn {
    
    let lookup: (Position) -> Bool
    
}









