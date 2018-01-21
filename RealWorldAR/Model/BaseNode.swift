//
//  BaseNode.swift
//  RealWorldAR
//
//  Created by George Bonnici-Carter on 20/01/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import SceneKit
import UIKit
import ARKit
import CoreLocation

class BaseNode: SCNNode {
    
    //MARK: Properties
    
    var anchor: ARAnchor? 
    var location: CLLocation!
    
    //MARK: Initialization
    
    init(location: CLLocation) {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    func addRocket() {
        let rocketShip = SCNScene(named: "art.scnassets/ship.scn")
        if let rocketNode = rocketShip?.rootNode.childNodes[Constants.firstChildNode] {
            addChildNode(rocketNode)
        } else {
            print("Could Not find file")
        }
    }
}
