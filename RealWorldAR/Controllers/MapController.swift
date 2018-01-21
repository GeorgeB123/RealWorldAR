//
//  ViewController.swift
//  RealWorldAR
//
//  Created by George Bonnici-Carter on 20/01/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var locationNeedsUpdating = true
    var userLocation: CLLocation? = nil
    var objectLocation: CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.transparentNavigationBar()
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
            addTapGesture()
        }
    }
    
    //MARK: Actions
    
    @IBAction func arView(_ sender: UIBarButtonItem) {
        guard let ARController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARController") as? ARController else {
            fatalError("View does not exist")
        }
        if let current = userLocation, let target = objectLocation {
            ARController.currentLocation = current
            ARController.objectLocation = target
        }
        self.navigationController!.pushViewController(ARController, animated: true)
        
    }

}

extension MapController {
    
    internal func addTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapController.handleTap(_:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    //Selector function for tap gesture
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        objectLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

//MARK: Extension CLLocationMangerDelegate

extension MapController: CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[Constants.userLocationInArray]
        userLocation = location
        if(locationNeedsUpdating == true) {
            let span: MKCoordinateSpan = MKCoordinateSpanMake(Constants.mapSpan, Constants.mapSpan)
            let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            locationNeedsUpdating = false
        }
    }

}




