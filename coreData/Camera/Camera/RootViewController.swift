//
//  RootViewController.swift
//  Camera
//
//  Created by zqj on 2017/8/9.
//  Copyright © 2017年 zqj. All rights reserved.
//

import UIKit
import CoreData
import CameraModel


class RootViewController: UIViewController, SegueHandler {
    
    enum SegueIdentifer: String {
        case embedNavigation = "embedCameraContainerViewController"
        case embedCamera = "embedCameraViewController"
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch fecthSugueIdentifier(for: segue) {
        case .embedNavigation:
         
            guard let navvv = segue.destination as? UINavigationController,
                  let vc = navvv.viewControllers.first as? CameraContainerViewController else {
                fatalError("wrong wrong") }
            
            vc.managedObjectContext = managedObjectContext
            navvv.delegate = self
            
        case .embedCamera:
            
            guard let cameraVC = segue.destination as? CameraViewController else {
                fatalError("wrong wrong")
            }
            
            cameraController = cameraVC
            
        }
        
    }


    
    fileprivate var cameraController: CameraViewController?

    
    fileprivate func setCameraVisiable(_ show: Bool){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    fileprivate func saveCameraWithImage(_ image: UIImage){
        
        self.managedObjectContext.performChanges {
            let _ = Camera.insert(into: self.managedObjectContext, image: image)
        }
        
    }
    
    
}


extension RootViewController: UINavigationControllerDelegate{
    
    
    
}
