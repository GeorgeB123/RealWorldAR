//  CLLocations+E.swift
//  RealWorldAR
//
//  Created by George Bonnici-Carter on 20/01/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import CoreLocation
import GLKit
import SceneKit

//MARK: Extension CLLocation

extension CLLocation {
    
    //MARK: functions
    
    func bearingToLocationRadian(_ destinationLocation: CLLocation) -> Double {
        
        let lat1 = self.coordinate.latitude.toRadians()
        let lon1 = self.coordinate.longitude.toRadians()
        let lat2 = destinationLocation.coordinate.latitude.toRadians()
        let lon2 = destinationLocation.coordinate.longitude.toRadians()
        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x)
        return radiansBearing
    }
    
}
