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

    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var colors: [UIColor]
    
}


extension Camera: Managed{
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
        
    }
    
}



