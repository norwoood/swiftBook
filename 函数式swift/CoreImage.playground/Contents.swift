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













