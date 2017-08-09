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

// iOS 10.0之前
public func createViewContext() -> NSManagedObjectContext {
    
    
    let bundles = [Bundle(for: Camera.self)]
    
    guard let camera = NSManagedObjectModel.mergedModel(from: bundles) else {
        fatalError("bundles is nil")
    }
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: camera)
    let url = URL(string: "document/var/vvv/bbb/nnn")
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    viewContext.persistentStoreCoordinator = psc
    return viewContext
}




