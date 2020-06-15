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
    
    // ARView y Tablero
    @IBOutlet weak var arView: ARView!
    
    let superficiePlana = ARWorldTrackingConfiguration()
    
    var tableroJuego: EscenasJuego.TableroPrincipalDeJuego!
    
    // Objetos en la Interfaz
    @IBOutlet weak var switchModoQuitarBloques: UISwitch!
    
    @IBOutlet weak var botonModoBloqueAzul: UIButton!
    @IBOutlet weak var botonModoBloqueRojo: UIButton!
    @IBOutlet weak var botonModoBloqueAmarillo: UIButton!
    @IBOutlet weak var botonModoBloqueMorado: UIButton!
    
    // Modos de Bloques (Tipo de Bloques o Quitar Bloques)
    var modoQuitarBloques = false
    
    enum tipoDeBloque {
        case azul, rojo, amarillo, morado
    }
    var tipoDeBloqueActual: tipoDeBloque = .azul
    
    // Paneles de Bloques
    var seHaCreadoPanel = false
    
    // Arrays de Posiciones de Bloques
    var arrayDePosicionesDeBloquesTotales: Array<SIMD3<Float>> = []
    
    var arrayDePosicionesDeBloquesAzules: Array<SIMD3<Float>> = []
    var arrayDePosicionesDeBloquesRojos: Array<SIMD3<Float>> = []
    var arrayDePosicionesDeBloquesAmarillos: Array<SIMD3<Float>> = []
    var arrayDePosicionesDeBloquesMorados: Array<SIMD3<Float>> = []
    
    // Arrays de Posiciones de Soluciones (PONER POSICIONES CORRECTAS DE CADA BLOQUE EN EL ARRAY)
    var arrayDeSolucionesDeBloquesAzules: Array<SIMD3<Float>> = []
    var arrayDeSolucionesDeBloquesRojos: Array<SIMD3<Float>> = []
    var arrayDeSolucionesDeBloquesAmarillos: Array<SIMD3<Float>> = []
    var arrayDeSolucionesDeBloquesMorados: Array<SIMD3<Float>> = []
    
    
    //
    //  MARK: View Did Load
    //
    
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
    
    
    //
    //  MARK: Touches Began
    //
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchLocation = (touches.first?.location(in: arView)), let tappedEntity = arView.hitTest(touchLocation, query: .nearest, mask: .default).first?.entity else { return }
        
        if seHaCreadoPanel == true && modoQuitarBloques == false {
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
            
        } else if modoQuitarBloques == true {
            if tappedEntity.name == "Bloque Azul" || tappedEntity.name == "Bloque Rojo" || tappedEntity.name == "Bloque Amarillo" || tappedEntity.name == "Bloque Morado" {
                for panelesDeBloques in 1...tableroJuego.children.count {
                    let objeto = tableroJuego.children[panelesDeBloques - 1]
                    if (objeto.name == "Panel Lateral Izquierda del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.y == tappedEntity.position.y + 10000 && objeto.position.x == tappedEntity.position.x - 0.038) || (objeto.name == "Panel Lateral Derecha del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.y == tappedEntity.position.y + 10000 && objeto.position.x == tappedEntity.position.x + 0.038) || (objeto.name == "Panel Lateral Trasera del Bloque" && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y + 10000 && objeto.position.z == tappedEntity.position.z + 0.038) || (objeto.name == "Panel Lateral Frontal del Bloque" && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y + 10000 && objeto.position.z == tappedEntity.position.z - 0.038) || (objeto.name == "Panel Encima del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.x == tappedEntity.position.x && (round(objeto.position.y * 100) / 100 == round((tappedEntity.position.y + 10000.038) * 100) / 100)) {
                        
                        objeto.isEnabled = false
                    }
                }
                
                tappedEntity.isEnabled = false
                tappedEntity.removeFromParent()
                
                for (index, valor) in arrayDePosicionesDeBloquesTotales.enumerated() {
                    if valor == tappedEntity.position {
                        arrayDePosicionesDeBloquesTotales.remove(at: index)
                    }
                }
            }
        }
    }
    
    //
    //  MARK: Acciones del Storyboard
    //
    
    @IBAction func acciónModoQuitarBloques(_ sender: Any) {
        if (sender as AnyObject).isOn {
            modoQuitarBloques = true
            
            for panelesDeBloques in 1...tableroJuego.children.count {
                let objeto = tableroJuego.children[panelesDeBloques - 1]
                if objeto.name == "Panel Lateral Izquierda del Bloque" || objeto.name == "Panel Lateral Derecha del Bloque" || objeto.name == "Panel Lateral Trasera del Bloque" || objeto.name == "Panel Lateral Frontal del Bloque" || objeto.name == "Panel Encima del Bloque" {
                    objeto.position = SIMD3(x: objeto.position.x, y: objeto.position.y + 10000, z: objeto.position.z)
                }
            }
            print("Hey! Now you are removing blocks!")
            
        } else {
            modoQuitarBloques = false
            
            for panelesDeBloques in 1...tableroJuego.children.count {
                let objeto = tableroJuego.children[panelesDeBloques - 1]
                if objeto.name == "Panel Lateral Izquierda del Bloque" || objeto.name == "Panel Lateral Derecha del Bloque" || objeto.name == "Panel Lateral Trasera del Bloque" || objeto.name == "Panel Lateral Frontal del Bloque" || objeto.name == "Panel Encima del Bloque" {
                    objeto.position = SIMD3(x: objeto.position.x, y: objeto.position.y - 10000, z: objeto.position.z)
                }
            }
            print("Hey! Now you are placing blocks!")
        }
    }
    
    @IBAction func accionTipoDeBloqueAzul(_ sender: Any) {
        tipoDeBloqueActual = .azul
    }
    
    @IBAction func accionTipoDeBloqueRojo(_ sender: Any) {
        tipoDeBloqueActual = .rojo
    }
    
    @IBAction func accionTipoDeBloqueAmarillo(_ sender: Any) {
        tipoDeBloqueActual = .amarillo
    }
    
    @IBAction func accionTipoDeBloqueMorado(_ sender: Any) {
        tipoDeBloqueActual = .morado
    }
    
    //
    //  MARK: Funciones
    //
    
    //
    // Creación de los Tipos de Bloques
    //
    
    func crearTipoDeBloqueSeleccionado() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        
        if tipoDeBloqueActual == .azul {
            nuevoBloque =  ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.blue, isMetallic: false)))
            nuevoBloque.name = "Bloque Azul"
            
        } else if tipoDeBloqueActual == .rojo {
            nuevoBloque = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.red, isMetallic: false)))
            nuevoBloque.name = "Bloque Rojo"
            
        } else if tipoDeBloqueActual == .amarillo {
            nuevoBloque = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.yellow, isMetallic: false)))
            nuevoBloque.name = "Bloque Amarillo"
            
        } else if tipoDeBloqueActual == .morado {
            nuevoBloque = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.purple, isMetallic: false)))
            nuevoBloque.name = "Bloque Morado"
        }
        
        nuevoBloque.generateCollisionShapes(recursive: true)
        
        return nuevoBloque
    }
    
    //
    // Introducir Nueva Posición a los Arrays de Posiciones
    //
    func introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: SIMD3<Float>) {
        arrayDePosicionesDeBloquesTotales.append(posicionBloqueNuevo)
        
        if tipoDeBloqueActual == .azul {
            arrayDePosicionesDeBloquesAzules.append(posicionBloqueNuevo)
            
        } else if tipoDeBloqueActual == .rojo {
            arrayDePosicionesDeBloquesRojos.append(posicionBloqueNuevo)
            
        } else if tipoDeBloqueActual == .amarillo {
            arrayDePosicionesDeBloquesAmarillos.append(posicionBloqueNuevo)
            
        } else if tipoDeBloqueActual == .morado {
            arrayDePosicionesDeBloquesMorados.append(posicionBloqueNuevo)
        }
    }
    
    //
    // Colocación de los Bloques
    //
    
    func colocarBloqueSobreTablero(_ entity: Entity?) {
           guard entity != nil else { return }
           
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.04, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueEncimaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)! + 0.037, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralFrontalDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)!, z: (entity?.position.z)! - 0.037)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralTraseraDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: (entity?.position.y)!, z: (entity?.position.z)! + 0.037)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralDerechaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)! + 0.037, y: (entity?.position.y)!, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralIzquierdaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)! - 0.037, y: (entity?.position.y)!, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque de ladrillo ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
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
        if arrayDePosicionesDeBloquesAzules == arrayDeSolucionesDeBloquesAzules /*&& arrayDe...*/ {
            print("¡Correcto!")
            return true
        } else {
            print("¡Incorrecto! Inténtalo de nuevo")
            return false
        }
    }
}
