//
//  NSManagedObjectContext+Extensions.swift
//  Camera
//
//  Created by zqj on 2017/8/9.
//  Copyright © 2017年 zqj. All rights reserved.
//

import CoreData


extension NSManagedObjectContext {
    
    public func insertObject<A: NSManagedObject>() -> A where A: Managed {
        
        guard let object = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("wrong object type")
        }
        
        return object
    }
    
    public func saveOrRollBack() -> Bool {
        
        do {
            try save()
            return true
        } catch  {
            
            rollback()
            
            return false
        }
        
    }
    
    public func performChanges(block: @escaping() -> () ){
        
        perform {
            
            block()
            _ = self.saveOrRollBack()
        }
        
    }
    
    
}
