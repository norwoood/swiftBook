//: ## 不可变性的价值


//: ### 控制值的使用方式,这些机制的工作方式
//: ### 值类型和引用类型
//: ### 限制可变状态使用的良好理念


//: let var 

//: 值类型与引用类型 
//关键区别, 被赋予一个新值或者作为一个参数传递给函数时，值类型会被复制。
struct Point {
    
    var x: Double
    var y: Double
    
    var person: Person
    
    
    
    //值类型的不可变性
    func setPersonNil() {
        
        person.name = ""
        person.age = 0
        
    }
    
    //x,y immutable 是不可变的，不能修改，非要修改的话需要加上关键字 mutating
    mutating func setPointOrigin() -> Void {
        
        x = 0
        y = 0
        
    }
    
}

class Person{
    
    var name: String
    var age: Int
    
    init(_ age: Int, _ name: String) {
        
        self.name = name
        self.age = age
        
    }
    
}



let origin = Point(x: 3, y: 4, person: Person(4, "111"))

var new = origin
new.person = Person(3, "xxx")

origin.person.name

// 可变与不可变



// 值类型和引用类型


// 可变与不可变得合理使用会降低代码的复杂度，也会


// 引用透明函数  松耦合，不存在共享状态
// 使的函数更加模块化





























