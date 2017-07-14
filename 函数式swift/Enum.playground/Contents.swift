
import UIKit


//: 高效利用类型来排除程序缺陷
//: ### 枚举
//: 类型


// swift中的枚举与整数或者其他类型没有关系，swift中的枚举值创建了新的类型

enum Encoding {
    
    case ascii
    case nextstep
    case japaneseEUC
    case utf8
    
}


extension Encoding {
    
    var nsStringEncoding: String.Encoding {
        
        switch self {
        case .ascii:
            return String.Encoding.ascii
        case .nextstep:
            return String.Encoding.nextstep
        case .japaneseEUC:
            return String.Encoding.japaneseEUC
        case .utf8:
            return String.Encoding.utf8
        }
        
    }
    
    
    init?(_ encoding: String.Encoding) {
        
        switch encoding {
        case String.Encoding.ascii:
             self = .ascii
        case String.Encoding.nextstep:
            self = .nextstep
        case String.Encoding.japaneseEUC:
            self = .japaneseEUC
        case String.Encoding.utf8:
            self = .utf8
        default:
            return nil
        }
        
    }
    
    var localName: String {
        
        return String.localizedName(of: nsStringEncoding)
        
    }
}



enum LookUpError: Error {
    
    case capitalNotFound
    case populationNotFound
    
}

enum PopulatiobREsult {
    //关联值
    case success(Int)
    case error(LookUpError)
    
}
/*
func populationOfCapital(country: String) -> PopulationResult {
    guard let capital = capitals[country] else {
        return .error(.capitalNotFound)
    }
    guard let population = cities[capital] else {
        return .error(.populationNotFound)
    }
    return .success(population)
}*/

/*
 
 /**/
 
 
 /**/
 
 
 */

//添加泛型
enum Result<T>{
    
    case success(T)
    case error(Error)
    
}

//swift的错误处理
//swift使用throws指明哪些地方会抛出错误,使用try 可以保证错误得到处理
//必须借助函数的返回类型来触发，当我们构建一个参数会失败的情况，使用throws的方式会变得复杂
//换用result或者编码起来就没有那个复杂，就是采用返回枚举类型，关联值关联结果
/*
func populationOfCapital(country: String)throws -> Int {
    guard let capital = capitals[country] else {
        return LookUpError.capitalNotFound
    }
    guard let population = cities[capital] else {
        return LookUpError.populationNotFound
    }
    return population
}*/


//数据类型中的代数学
//








