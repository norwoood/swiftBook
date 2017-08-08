//
//  CameraStack.swift
//  Camera
//
//  Created by zqj on 2017/8/8.
//  Copyright © 2017年 zqj. All rights reserved.
//

import CoreData


public func createPersistent(complement: @escaping (NSPersistentContainer) -> ()){
    
    let persistent = NSPersistentContainer.init(name: "Camera")
    
    persistent.loadPersistentStores { _, error in
        
        guard error == nil else { fatalError(" database can't be nil error:\(String(describing: error))") }
        
        DispatchQueue.main.async {
            
            complement(persistent)
        
        }
        
        
    }
    
    
}
