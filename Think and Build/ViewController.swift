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
    
    func crearCubo() -> ModelEntity {
        let cubo = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.blue, isMetallic: false)))
        return cubo
    }
    
    func crearPanelArribaDelCubo(cubo: ModelEntity) {
        let panelArribaDelCubo = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        
        panelArribaDelCubo.orientation = simd_quatf(angle: -(Float.pi/2),
        axis: [1, 0, 0])
        
        
        panelArribaDelCubo.position = SIMD3(x: (cubo.position.x), y: (cubo.position.y) + 0.038, z: (cubo.position.z))
        
        tableroJuego.addChild(panelArribaDelCubo)
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
        print(tableroJuego.actions.allActions.count)
    }
    
    func handleTapOnEntity(_ entity: Entity?) {
           guard entity != nil else { return }
           
        let cuboNuevo = crearCubo()
        cuboNuevo.position = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.035, z: (entity?.position.z)!)
        tableroJuego.addChild(cuboNuevo)
        
        crearPanelArribaDelCubo(cubo: cuboNuevo)
        
          }
}
