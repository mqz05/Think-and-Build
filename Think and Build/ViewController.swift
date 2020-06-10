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
    
    var panelArribaDelCubo: ModelEntity!
    var seHaCreadoPanel = false
    
    var arrayDePosicionesDeBloquesTotales: Array<SIMD3<Float>> = []
    
    var arrayDePosicionesDeBloquesLadrillos: Array<SIMD3<Float>> = []
    
    
    // Arrays de Soluciones (PONER POSICIONES CORRECTAS DE CADA BLOQUE EN EL ARRAY)
    var arrayDeSolucionesDeBloquesLadrillos: Array<SIMD3<Float>> = []
    
    func crearBloqueLadrillo() -> ModelEntity {
        let cubo = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.blue, isMetallic: false)))
        return cubo
    }
    
    func crearPanelArribaDelCubo(cubo: ModelEntity) {
        panelArribaDelCubo = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        panelArribaDelCubo.orientation = simd_quatf(angle: -(Float.pi/2),
        axis: [1, 0, 0])
        
        panelArribaDelCubo.generateCollisionShapes(recursive: true)
        panelArribaDelCubo.name = "Panel Encima del Cubo"
        /*if let hasCollision = panelArribaDelCubo {
           arView.installGestures(.translation, for: hasCollision)
        }*/
        
        panelArribaDelCubo.position = SIMD3(x: (cubo.position.x), y: (cubo.position.y) + 0.038, z: (cubo.position.z))
        
        tableroJuego.addChild(panelArribaDelCubo)
        seHaCreadoPanel = true
    }
    
    func revisarSolucion() -> Bool {
        if arrayDePosicionesDeBloquesLadrillos == arrayDeSolucionesDeBloquesLadrillos /*&& arrayDe...*/ {
            print("¡Correcto!")
            return true
        } else {
            print("¡Incorrecto! Inténtalo de nuevo")
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superficiePlana.planeDetection = .horizontal
        arView.session.run(superficiePlana)
       
        tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
        
        self.arView.scene.anchors.append(tableroJuego)
        
        for i in 1...49 {
            tableroJuego.actions.allActions[i - 1].onAction = colocarBloqueSobreTablero(_:)
        }
    }
    
    func colocarBloqueSobreTablero(_ entity: Entity?) {
           guard entity != nil else { return }
           
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.035, z: (entity?.position.z)!)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)

        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            print("¡Ya hay un bloque ahí!")
        } else {
            crearPanelArribaDelCubo(cubo: nuevoBloqueLadrillo)
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
        }
        
    }
    
    func colocarBloqueSobreBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.035, z: (entity?.position.z)!)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)
        
        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            print("¡Ya hay un bloque ahí!")
        } else {
            crearPanelArribaDelCubo(cubo: nuevoBloqueLadrillo)
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if seHaCreadoPanel == true {
            guard let touchLocation = touches.first?.location(in: arView),
                let tappedEntity = arView.hitTest(touchLocation, query: .nearest, mask: .default).first?.entity,
            tappedEntity.name == "Panel Encima del Cubo" else {
                    return
            }
                colocarBloqueSobreBloque(_: tappedEntity)
        }
    }
}
