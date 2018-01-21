//
//  ARController.swift
//  RealWorldAR
//
//  Created by George Bonnici-Carter on 20/01/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation
import MapKit

class ARController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var sceneView: ARSCNView!
    var objectLocation: CLLocation? = nil
    var currentLocation: CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.transparentNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        sceneView.session.run(configuration)
        if let object = objectLocation {
            addObjectInSpace(for: object)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    //MARK: Actions
    
    @IBAction func backToMap(_ sender: UIBarButtonItem) {
        guard let MapController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapController") as? MapController else {
            fatalError("View does not exist")
        }
        MapController.userLocation = nil
        MapController.locationNeedsUpdating = true
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private Methods
    
    private func addObjectInSpace(for location: CLLocation) {
        guard let origin = currentLocation else {
            return
        }
        let locationTransform = MatrixHelper.transformMatrix(for: matrix_identity_float4x4, originLocation: origin, location: location)
        let Anchor = ARAnchor(transform: locationTransform)
        let node = BaseNode(location: location)
        node.position = SCNVector3.positionFromTransform(locationTransform)
        node.addRocket()
        self.sceneView.session.add(anchor: Anchor)
        self.sceneView.scene.rootNode.addChildNode(node)
        node.anchor = Anchor
    }

}

