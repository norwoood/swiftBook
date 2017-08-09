//
//  SegueHandler.swift
//  Camera
//
//  Created by zqj on 2017/8/9.
//  Copyright © 2017年 zqj. All rights reserved.
//

import UIKit

public protocol SegueHandler {
    
    associatedtype SegueIdentifer: RawRepresentable

}

extension SegueHandler where Self: UIViewController, SegueIdentifer.RawValue == String {
    
    public func fecthSugueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifer {
        
        guard let identifier = segue.identifier, let sugeIdentifierr = SegueIdentifer(rawValue: identifier) else {
            
            fatalError("unknow \(segue)")
        }
        
        return sugeIdentifierr

    }
    
    
    public func performSegue(withIdentifier segueIdentifier: SegueIdentifer) {
    
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
        
    }
    
}
