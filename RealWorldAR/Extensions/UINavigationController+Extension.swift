//
//  UINavigationController+Extension.swift
//  RealWorldAR
//
//  Created by George Bonnici-Carter on 21/01/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit

//MARK: Extension UINavigationController
extension UINavigationController {
    
    func transparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    
}
