//
//  SCNVector3.swift
//  RealWorldAR
//
//  Created by George Bonnici-Carter on 20/01/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import SceneKit

//MARK: Extension SCNVector3

extension SCNVector3 {
    
    static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
}
