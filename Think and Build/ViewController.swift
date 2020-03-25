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
    
    
    @IBOutlet weak var arView: ARView!
    
    let superficiePlana = ARWorldTrackingConfiguration()
    
    var tableroJuego: EscenasJuego.TableroPrincipalDeJuego!
    
    func handleTapOnEntity(_ entity: Entity?) {
        guard entity != nil else { return }
           print("HEYYYY")
        tableroJuego.cubo?.position = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.035, z: (entity?.position.z)!)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superficiePlana.planeDetection = .horizontal
        arView.session.run(superficiePlana)
       
        tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
        
        self.arView.scene.anchors.append(tableroJuego)
       
        
        
        for i in 1...49 {
            tableroJuego.actions.allActions[i - 1].onAction = handleTapOnEntity(_:)
        }
        
    }
}
