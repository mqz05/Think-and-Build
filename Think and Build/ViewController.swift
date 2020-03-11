//
//  ViewController.swift
//  Think and Build
//
//  Created by tallerapps on 12/02/2020.
//  Copyright © 2020 tallerapps. All rights reserved.
//

import UIKit
import ARKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    var tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let superficiePlana = ARWorldTrackingConfiguration()
        superficiePlana.planeDetection = .horizontal
        arView.session.run(superficiePlana)
        self.arView.scene.anchors.append(tableroJuego)
        
    }
}
