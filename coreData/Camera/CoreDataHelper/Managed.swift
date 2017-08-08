//
//  Managed.swift
//  Camera
//
//  Created by zqj on 2017/8/8.
//  Copyright © 2017年 zqj. All rights reserved.
//

import CoreData

public protocol Managed: class, NSFetchRequestResult {

    static var entity: NSEntityDescription { get }
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension Managed{
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    public static var sortedFetchRequest: NSFetchRequest<Self> {
        
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
}

extension Managed where Self: NSManagedObject {
    
    public static var entity: NSEntityDescription { return entity() }
    public static var entityName: String { return entity.name! }
    
}
