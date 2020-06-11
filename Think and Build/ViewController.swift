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
    
    var seHaCreadoPanel = false
    
    var arrayDePosicionesDeBloquesTotales: Array<SIMD3<Float>> = []
    
    var arrayDePosicionesDeBloquesLadrillos: Array<SIMD3<Float>> = []
    
    
    // Arrays de Soluciones (PONER POSICIONES CORRECTAS DE CADA BLOQUE EN EL ARRAY)
    var arrayDeSolucionesDeBloquesLadrillos: Array<SIMD3<Float>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superficiePlana.planeDetection = .horizontal
        arView.session.run(superficiePlana)
       
        tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
        
        self.arView.scene.anchors.append(tableroJuego)
        
        for i in 1...49 {
            tableroJuego.actions.allActions[i - 1].onAction = colocarBloqueSobreTablero(_:)
        }
        
        print((tableroJuego.casilla00?.position.z)! - (tableroJuego.casilla01?.position.z)!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if seHaCreadoPanel == true {
            guard let touchLocation = (touches.first?.location(in: arView)), let tappedEntity = arView.hitTest(touchLocation, query: .nearest, mask: .default).first?.entity else { return }
            
            if tappedEntity.name == "Panel Encima del Bloque" {
                colocarBloqueEncimaDelBloque(_: tappedEntity)
                
            } else if tappedEntity.name == "Panel Lateral Frontal del Bloque" {
                colocarBloqueLateralFrontalDelBloque(_: tappedEntity)
                
            } else if tappedEntity.name == "Panel Lateral Trasera del Bloque" {
                colocarBloqueLateralTraseraDelBloque(_: tappedEntity)
                
            } else if tappedEntity.name == "Panel Lateral Derecha del Bloque" {
                colocarBloqueLateralDerechaDelBloque(_: tappedEntity)
                
            } else if tappedEntity.name == "Panel Lateral Izquierda del Bloque" {
                colocarBloqueLateralIzquierdaDelBloque(_: tappedEntity)
                
            }
        }
    }
    
    
    //
    // Creación de los Tipos de Bloques
    //
    
    func crearBloqueLadrillo() -> ModelEntity {
        let cubo = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.blue, isMetallic: false)))
        return cubo
    }
    
    
    //
    // Colocación de los Bloques
    //
    
    func colocarBloqueSobreTablero(_ entity: Entity?) {
           guard entity != nil else { return }
           
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.04, z: (entity?.position.z)!)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)

        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            print("¡Ya hay un bloque ahí!")
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            
        } else {
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            
            crearTodosLosPanelesDelBloque(bloque: nuevoBloqueLadrillo)
        }
    }
    
    func colocarBloqueEncimaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.037, z: (entity?.position.z)!)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)
        
        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            print("¡Ya hay un bloque ahí!")
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            
        } else {
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            
            crearTodosLosPanelesDelBloque(bloque: nuevoBloqueLadrillo)
        }
    }
    
    func colocarBloqueLateralFrontalDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)!, z: (entity?.position.z)! - 0.037)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)
        
        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            print("¡Ya hay un bloque ahí!")
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            
        } else {
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            
            crearTodosLosPanelesDelBloque(bloque: nuevoBloqueLadrillo)
        }
    }
    
    func colocarBloqueLateralTraseraDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)!, z: (entity?.position.z)! + 0.037)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)
        
        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            print("¡Ya hay un bloque ahí!")
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            
        } else {
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            
            crearTodosLosPanelesDelBloque(bloque: nuevoBloqueLadrillo)
        }
    }
    
    func colocarBloqueLateralDerechaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)! + 0.037, y: (entity?.position.y)!, z: (entity?.position.z)!)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)
        
        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            print("¡Ya hay un bloque ahí!")
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            
        } else {
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            
            crearTodosLosPanelesDelBloque(bloque: nuevoBloqueLadrillo)
        }
    }
    
    func colocarBloqueLateralIzquierdaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        let nuevoBloqueLadrillo = crearBloqueLadrillo()
        let posicionBloqueLadrillo = SIMD3(x: (entity?.position.x)! - 0.037, y: (entity?.position.y)!, z: (entity?.position.z)!)
        nuevoBloqueLadrillo.position = posicionBloqueLadrillo
        tableroJuego.addChild(nuevoBloqueLadrillo)
        
        if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueLadrillo) {
            print("¡Ya hay un bloque ahí!")
            tableroJuego.removeChild(nuevoBloqueLadrillo)
            
        } else {
            print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
            arrayDePosicionesDeBloquesTotales.append(posicionBloqueLadrillo)
            arrayDePosicionesDeBloquesLadrillos.append(posicionBloqueLadrillo)
            
            crearTodosLosPanelesDelBloque(bloque: nuevoBloqueLadrillo)
        }
    }
    
    
    //
    // Paneles de los Bloques
    //
    
    func crearTodosLosPanelesDelBloque(bloque: ModelEntity) {
        crearPanelEncimaDelBloque(bloque: bloque)
        crearPanelLateralFrontalDelBloque(bloque: bloque)
        crearPanelLateralTraseraDelBloque(bloque: bloque)
        crearPanelLateralDerechaDelBloque(bloque: bloque)
        crearPanelLateralIzquierdaDelBloque(bloque: bloque)
    }
    
    func crearPanelEncimaDelBloque(bloque: ModelEntity) {
        let panelEncimaDelBloque = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        panelEncimaDelBloque.orientation = simd_quatf(angle: -(Float.pi/2), axis: [1, 0, 0])
        
        panelEncimaDelBloque.generateCollisionShapes(recursive: true)
        panelEncimaDelBloque.name = "Panel Encima del Bloque"
        
        panelEncimaDelBloque.position = SIMD3(x: (bloque.position.x), y: (bloque.position.y) + 0.038, z: (bloque.position.z))
        
        tableroJuego.addChild(panelEncimaDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralFrontalDelBloque(bloque: ModelEntity) {
        let panelLateralFrontalDelBloque = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        panelLateralFrontalDelBloque.orientation = simd_quatf(angle: Float.pi, axis: [0, 1, 0])
        
        panelLateralFrontalDelBloque.generateCollisionShapes(recursive: true)
        panelLateralFrontalDelBloque.name = "Panel Lateral Frontal del Bloque"
        
        panelLateralFrontalDelBloque.position = SIMD3(x: (bloque.position.x), y: (bloque.position.y), z: (bloque.position.z) - 0.038)
        
        tableroJuego.addChild(panelLateralFrontalDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralTraseraDelBloque(bloque: ModelEntity) {
        let panelLateralTraseraDelBloque = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        panelLateralTraseraDelBloque.orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
        
        panelLateralTraseraDelBloque.generateCollisionShapes(recursive: true)
        panelLateralTraseraDelBloque.name = "Panel Lateral Trasera del Bloque"
        
        panelLateralTraseraDelBloque.position = SIMD3(x: (bloque.position.x), y: (bloque.position.y), z: (bloque.position.z) + 0.038)
        
        tableroJuego.addChild(panelLateralTraseraDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralDerechaDelBloque(bloque: ModelEntity) {
        let panelLateralDerechaDelBloque = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        panelLateralDerechaDelBloque.orientation = simd_quatf(angle: Float.pi/2, axis: [0, 1, 0])
        
        panelLateralDerechaDelBloque.generateCollisionShapes(recursive: true)
        panelLateralDerechaDelBloque.name = "Panel Lateral Derecha del Bloque"
        
        panelLateralDerechaDelBloque.position = SIMD3(x: (bloque.position.x) + 0.038, y: (bloque.position.y), z: (bloque.position.z))
        
        tableroJuego.addChild(panelLateralDerechaDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralIzquierdaDelBloque(bloque: ModelEntity) {
        let panelLateralIzquierdaDelBloque = ModelEntity.init(mesh: .generatePlane(width: 0.07, height: 0.07), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.white, isMetallic: false)))
        
        panelLateralIzquierdaDelBloque.orientation = simd_quatf(angle: -(Float.pi/2), axis: [0, 1, 0])
        
        panelLateralIzquierdaDelBloque.generateCollisionShapes(recursive: true)
        panelLateralIzquierdaDelBloque.name = "Panel Lateral Izquierda del Bloque"
        
        panelLateralIzquierdaDelBloque.position = SIMD3(x: (bloque.position.x) - 0.038, y: (bloque.position.y), z: (bloque.position.z))
        
        tableroJuego.addChild(panelLateralIzquierdaDelBloque)
        seHaCreadoPanel = true
    }
    
    
    //
    // Revisar la Solución
    //
    
    func revisarSolucion() -> Bool {
        if arrayDePosicionesDeBloquesLadrillos == arrayDeSolucionesDeBloquesLadrillos /*&& arrayDe...*/ {
            print("¡Correcto!")
            return true
        } else {
            print("¡Incorrecto! Inténtalo de nuevo")
            return false
        }
    }
}
