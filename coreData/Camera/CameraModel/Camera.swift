//
//  Camerra.swift
//  Camera
//
//  Created by zqj on 2017/8/8.
//  Copyright © 2017年 zqj. All rights reserved.
//


import CoreData
import CoreDataHelper

public class Camera: NSManagedObject {

    @NSManaged public var date: Date
    @NSManaged public fileprivate(set) var colors: [UIColor]
    
}


extension Camera: Managed{
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
        
    }
    
}


extension Camera {
    
    public static func insert(into: NSManagedObjectContext, image: UIImage) -> Camera{
        
        let camera: Camera = into.insertObject()
        camera.date = Date()
        //camera.colors = image.colors
        return camera
    }
    
    
}



