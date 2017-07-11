//: Playground - noun: a place where people can play

import UIKit


//滤镜类型， 图片滤镜可能有多个操作，每次操作都会需要一张图片和输出一张新的图片.
typealias Filter = (CIImage) -> CIImage


//func myFilter() -> Filter{}

//CIConstantColorGenerator 颜色生成
//CIGaussianBlur  高斯滤镜
//CISourceOverCompositing 图像覆盖合成

func blur(_ radius: Double) -> Filter {
    
    return {
        
        image in
        
        let paraeters: [String: Any] = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: paraeters) else { fatalError() }
        
        guard  let outputImage = filter.outputImage else {
            fatalError()
        }
        
        return outputImage
    
    }
    
}


func generator(_ color: UIColor) -> Filter {
    
    
    return {
        
        _ in
        
        let paramtes: [String: Any] = [ kCIInputColorKey: CIColor.init(cgColor: color.cgColor) ]
        
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: paramtes) else {
            fatalError()
        }
        
        guard let outputimage = filter.outputImage else {
            fatalError()
        }
        
        return outputimage
    }
    
}


func sourceOverCompositing(_ overlay: CIImage) -> Filter{
    
    return {
        
        image in
        //kCIInputBackgroundImageKey 背景图像
        let paramaters: [String: Any] = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: paramaters) else {
            fatalError()
        }
        
        guard  let outputimage = filter.outputImage else {
            fatalError()
        }
        //裁剪为和原图像一样的
        return outputimage.cropping(to: image.extent)
    }
    
}



func overlay(_ color: UIColor) -> Filter {
    
    return {
        
        image in
        
        let overlay = generator(color)(image).cropping(to: image.extent)
        
        return sourceOverCompositing(overlay)(image)
        
    }
    
}


let url = URL(string: "http://www.objc.io/images/covers/16.jpg")!
let image = CIImage(contentsOf: url)!
let burimage = blur(5)(image)

//let overlayimage = overlay(UIColor.red)(burimage)

//let result = overlay(UIColor.red)(blur(5)(image))

//filter1的结果作为filter2的输入  filter的输出作为最终结果

infix operator >>>

func >>>(filter1:  @escaping Filter, filter2: @escaping Filter) -> Filter {
    
    return { image in filter2(filter1(image)) }
    
}


//let result =  blur(5) >>> overlay(UIColor.red))(image)



//柯里化版本
//函数接受参数可以自由的选择
//柯里化可以说是和函数作为一等值 导致和反哺的关系   柯里化让我们操作函数参数更加自由，对我们的函数作为一等值得一种体现。

//总结: 开始封装一些模块时，基础类型的选定一定程度上可以左右我们的开发，也可以展示出我们对一个语言的是否有着更好的理解  函数作为一等值，让他可以作为参数，也能作为返回值，所以有时候称swift为函数式编程还是有一定道理的。自定义操作符一定程度上简化了我们的书写，更大的是说swift提供给我们的便利 柯里化是函数作为一等值得一种结果，反过来柯里化让我们操作函数，利用函数进行开发更加的便捷










