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

class MainViewController: UIViewController {
    
    // ARView, Tablero y Prototipos
    @IBOutlet weak var arView: ARView!
    
    let superficiePlana = ARWorldTrackingConfiguration()
    
    var tableroJuego: EscenasJuego.TableroPrincipalDeJuego!
    
    // Controlador de Niveles y Fases
    enum modoDeJuego {
        case memorizacion, construccion, pausa
    }
    var modoDeJuegoActual: modoDeJuego = .memorizacion
    
    enum nivelFase {
        case start, easy1, easy2, easy3, medium1, medium2, medium3, hard1, hard2, hard3, insane1, insane2, insane3, win
    }
    var nivelFaseActual: nivelFase = .start
    
    enum fasesTotales {
        case start, easy, medium, hard, insane, win
    }
    var faseActual: fasesTotales = .start
    
    var escenaPrototipo: [Array<SIMD3<Float>>]!
    
    var numeroRandom: Int!
    
    // Timer
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer?
    var tiempoTotal = 0
    
    // Objetos en la Interfaz
    @IBOutlet weak var botonModoBuild: UIButton!
    @IBOutlet weak var botonNextLevel: UIButton!
    
    @IBOutlet weak var switchModoQuitarBloques: UISwitch!
    @IBOutlet weak var labelModoQuitarBloques: UILabel!
    
    @IBOutlet weak var botonModoBloqueAzul: UIButton!
    @IBOutlet weak var botonModoBloqueRojo: UIButton!
    @IBOutlet weak var botonModoBloqueAmarillo: UIButton!
    @IBOutlet weak var botonModoBloqueVerde: UIButton!
    
    // Modos de Bloques (Tipo de Bloques o Quitar Bloques)
    var modoQuitarBloques = false
    
    enum tipoDeBloque {
        case azul, rojo, amarillo, verde
    }
    var tipoDeBloqueActual: tipoDeBloque = .azul
    
    // Paneles de Bloques
    var seHaCreadoPanel = false
    
    // Arrays de Posiciones de Bloques
    var arrayDePosicionesDeBloquesTotales: Array<SIMD3<Float>> = []
    
    var arrayDePosicionesDeBloquesAzules: Array<SIMD3<Float>> = []
    var arrayDePosicionesDeBloquesRojos: Array<SIMD3<Float>> = []
    var arrayDePosicionesDeBloquesAmarillos: Array<SIMD3<Float>> = []
    var arrayDePosicionesDeBloquesVerdes: Array<SIMD3<Float>> = []
    
    
    //
    //  MARK: View Did Load
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ocultarInterfaz()
        pasarAlSiguenteNivel()
        
        superficiePlana.planeDetection = .horizontal
        arView.session.run(superficiePlana)
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
            if tappedEntity.name == "Bloque Azul" || tappedEntity.name == "Bloque Rojo" || tappedEntity.name == "Bloque Amarillo" || tappedEntity.name == "Bloque Verde" {
                for panelesDeBloques in 1...tableroJuego.children.count {
                    let objeto = tableroJuego.children[panelesDeBloques - 1]
                    if (objeto.name == "Panel Lateral Izquierda del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.y == tappedEntity.position.y + 1000 && objeto.position.x == tappedEntity.position.x - 0.038) || (objeto.name == "Panel Lateral Derecha del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.y == tappedEntity.position.y + 1000 && objeto.position.x == tappedEntity.position.x + 0.038) || (objeto.name == "Panel Lateral Trasera del Bloque" && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y + 1000 && objeto.position.z == tappedEntity.position.z + 0.038) || (objeto.name == "Panel Lateral Frontal del Bloque" && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y + 1000 && objeto.position.z == tappedEntity.position.z - 0.038) || (objeto.name == "Panel Encima del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.x == tappedEntity.position.x && (round(objeto.position.y * 100) / 100 == round((tappedEntity.position.y + 1000.038) * 100) / 100)) {
                        
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
                for (index, valor) in arrayDePosicionesDeBloquesAzules.enumerated() {
                    if valor == tappedEntity.position {
                        arrayDePosicionesDeBloquesAzules.remove(at: index)
                    }
                }
                for (index, valor) in arrayDePosicionesDeBloquesRojos.enumerated() {
                    if valor == tappedEntity.position {
                        arrayDePosicionesDeBloquesRojos.remove(at: index)
                    }
                }
                for (index, valor) in arrayDePosicionesDeBloquesAmarillos.enumerated() {
                    if valor == tappedEntity.position {
                        arrayDePosicionesDeBloquesAmarillos.remove(at: index)
                    }
                }
                for (index, valor) in arrayDePosicionesDeBloquesVerdes.enumerated() {
                    if valor == tappedEntity.position {
                        arrayDePosicionesDeBloquesVerdes.remove(at: index)
                    }
                }

            }
        }
    }
    
    //
    //  MARK: Acciones del Storyboard
    //
    
    @IBAction func activarModoBuild(_ sender: Any) {
        mostrarInterfaz()
        modoDeJuegoActual = .construccion
        
        self.arView.scene.anchors.removeAll()
        
        tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
        self.arView.scene.anchors.append(tableroJuego)
        
        for i in 1...64 {
            tableroJuego.actions.allActions[i - 1].onAction = colocarBloqueSobreTablero(_:)
        }
        
        for i in 1...64 {
            let casilla = tableroJuego.casillaEntities[i - 1]
            casilla.position = SIMD3(x: round(casilla.position.x * 10000) / 10000, y: round(casilla.position.y * 10000) / 10000, z: round(casilla.position.z * 10000) / 10000)
        }
        
        if faseActual == .easy {
            empezarTimer(tiempo: 60)
        } else if faseActual == .medium {
            empezarTimer(tiempo: 105)
        } else if faseActual == .hard {
            empezarTimer(tiempo: 150)
        } else if faseActual == .insane {
            empezarTimer(tiempo: 195)
        }
    }
    
    @IBAction func pasarDeNivel(_ sender: Any) {
        print("Bloques Azules: \(arrayDePosicionesDeBloquesAzules)")
        print("Bloques Rojos: \(arrayDePosicionesDeBloquesRojos)")
        print("Bloques Verdes: \(arrayDePosicionesDeBloquesVerdes)")
        print("Bloques Amarillos: \(arrayDePosicionesDeBloquesAmarillos)")
        
        if revisarSolucion() == true {
            print("Pasas al siguiente nivel :D")
            /// Animación Pasar de Nivel
            modoDeJuegoActual = .memorizacion
            ocultarInterfaz()
            pasarAlSiguenteNivel()
            
        } else {
            print("No puedes pasar al siguiente nivel D:")
            /// Animación Game Over
            
            //modoDeJuegoActual = .pausa
        }
    }
    
    @IBAction func acciónModoQuitarBloques(_ sender: Any) {
        if (sender as AnyObject).isOn {
            modoQuitarBloques = true
            
            for panelesDeBloques in 1...tableroJuego.children.count {
                let objeto = tableroJuego.children[panelesDeBloques - 1]
                if objeto.name == "Panel Lateral Izquierda del Bloque" || objeto.name == "Panel Lateral Derecha del Bloque" || objeto.name == "Panel Lateral Trasera del Bloque" || objeto.name == "Panel Lateral Frontal del Bloque" || objeto.name == "Panel Encima del Bloque" {
                    objeto.position = SIMD3(x: objeto.position.x, y: objeto.position.y + 1000, z: objeto.position.z)
                }
            }
            print("Hey! Now you are removing blocks!")
            
        } else {
            modoQuitarBloques = false
            
            for panelesDeBloques in 1...tableroJuego.children.count {
                let objeto = tableroJuego.children[panelesDeBloques - 1]
                if objeto.name == "Panel Lateral Izquierda del Bloque" || objeto.name == "Panel Lateral Derecha del Bloque" || objeto.name == "Panel Lateral Trasera del Bloque" || objeto.name == "Panel Lateral Frontal del Bloque" || objeto.name == "Panel Encima del Bloque" {
                    objeto.position = SIMD3(x: objeto.position.x, y: objeto.position.y - 1000, z: objeto.position.z)
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
    
    @IBAction func accionTipoDeBloqueVerde(_ sender: Any) {
        tipoDeBloqueActual = .verde
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
            nuevoBloque = crearBloqueAzul()
            
        } else if tipoDeBloqueActual == .rojo {
            nuevoBloque = crearBloqueRojo()
            
        } else if tipoDeBloqueActual == .amarillo {
            nuevoBloque = crearBloqueAmarillo()
            
        } else if tipoDeBloqueActual == .verde {
            nuevoBloque = crearBloqueVerde()
        }
        
        nuevoBloque.generateCollisionShapes(recursive: true)
        return nuevoBloque
    }
    
    func crearBloqueAzul() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        nuevoBloque =  ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.blue, isMetallic: false)))
        nuevoBloque.name = "Bloque Azul"
        return nuevoBloque
    }
    
    func crearBloqueRojo() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        let urlPath = Bundle.main.path(forResource: "Cubo Rojo Prueba", ofType: "usdz")
        let url = URL(fileURLWithPath: urlPath!)
        nuevoBloque = try? ModelEntity.loadModel(contentsOf: url)
        nuevoBloque.name = "Bloque Rojo"
        return nuevoBloque
    }
    
    func crearBloqueAmarillo() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        nuevoBloque = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.yellow, isMetallic: false)))
        nuevoBloque.name = "Bloque Amarillo"
        return nuevoBloque
    }
    
    func crearBloqueVerde() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        nuevoBloque = ModelEntity.init(mesh: .generateBox(size: SIMD3(x: 0.075, y: 0.075, z: 0.075)), materials: [Material].init(arrayLiteral: SimpleMaterial.init(color: SimpleMaterial.Color.green, isMetallic: false)))
        nuevoBloque.name = "Bloque Verde"
        return nuevoBloque
    }
    
    //
    // Cargar Temporizador
    //
    private func empezarTimer(tiempo: Int) {
        if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
        }
        self.tiempoTotal = tiempo
        self.timerLabel.text = calcularTiempoParaLabel(segundosTotales: tiempoTotal)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizarTimer), userInfo: nil, repeats: true)
    }

    @objc func actualizarTimer() {
        if modoDeJuegoActual != .pausa {
            self.timerLabel.text = calcularTiempoParaLabel(segundosTotales: tiempoTotal)
                if tiempoTotal != 0 {
                    tiempoTotal -= 1
                } else {
                    if modoDeJuegoActual == .memorizacion {
                        activarModoBuild((Any).self)
                    } else if modoDeJuegoActual == .construccion {
                        pasarDeNivel((Any).self)
                    }
            }
        }
    }
    
    func calcularTiempoParaLabel(segundosTotales: Int) -> String {
        let segundos: Int = segundosTotales % 60
        let minutos: Int = (segundosTotales / 60) % 60
        return String(format: "%02d:%02d", minutos, segundos)
    }
    
    //
    // Cargar Escenas Prototipo
    //
    func cargarEscenaPrototipo(fase: fasesTotales) {
        tableroPrototipos = try? EscenasJuego.loadTablero()
        arView.scene.anchors.append(tableroPrototipos)
        
        if fase == .easy {
            numeroRandom = Int.random(in: 0...(arrayPrototiposEasyTotales.count - 1))
            escenaPrototipo = arrayPrototiposEasyTotales[numeroRandom]
            
        } else if fase == .medium {
            numeroRandom = Int.random(in: 0...(arrayPrototiposMediumTotales.count - 1))
            escenaPrototipo = arrayPrototiposMediumTotales[numeroRandom]
            
        } else if fase == .hard {
            numeroRandom = Int.random(in: 0...(arrayPrototiposHardTotales.count - 1))
            escenaPrototipo = arrayPrototiposHardTotales[numeroRandom]
            
        } else {
            numeroRandom = Int.random(in: 0...(arrayPrototiposInsaneTotales.count - 1))
            escenaPrototipo = arrayPrototiposInsaneTotales[numeroRandom]
        }
        
        let bloquesAzulesPrototipo = escenaPrototipo[0]
        let bloquesRojosPrototipo = escenaPrototipo[1]
        let bloquesAmarillosPrototipo = escenaPrototipo[2]
        let bloquesVerdesPrototipo = escenaPrototipo[3]
        
        if bloquesAzulesPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesAzulesPrototipo.count - 1) {
                let bloqueAzul = crearBloqueAzul()
                bloqueAzul.position = bloquesAzulesPrototipo[numeroDelBloque]
                tableroPrototipos.addChild(bloqueAzul)
            }
        }
        
        if bloquesRojosPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesRojosPrototipo.count - 1) {
                let bloqueRojo = crearBloqueRojo()
                bloqueRojo.position = bloquesRojosPrototipo[numeroDelBloque]
                tableroPrototipos.addChild(bloqueRojo)
            }
        }
        
        if bloquesAmarillosPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesAmarillosPrototipo.count - 1){
                let bloqueAmarillo = crearBloqueAmarillo()
                bloqueAmarillo.position = bloquesAmarillosPrototipo[numeroDelBloque]
                tableroPrototipos.addChild(bloqueAmarillo)
            }
        }
        
        if bloquesVerdesPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesVerdesPrototipo.count - 1) {
                let bloqueVerde = crearBloqueVerde()
                bloqueVerde.position = bloquesVerdesPrototipo[numeroDelBloque]
                tableroPrototipos.addChild(bloqueVerde)
            }
        }
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
            
        } else if tipoDeBloqueActual == .verde {
            arrayDePosicionesDeBloquesVerdes.append(posicionBloqueNuevo)
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
                print("¡Un nuevo bloque ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueEncimaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: round(((entity?.position.y)! + 0.037) * 10000) / 10000, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralFrontalDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: round(((entity?.position.y)!) * 10000) / 10000, z: round(((entity?.position.z)! - 0.037) * 10000) / 10000)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralTraseraDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: (entity?.position.x)!, y: round(((entity?.position.y)!) * 10000) / 10000, z: round(((entity?.position.z)! + 0.037) * 10000) / 10000)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralDerechaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: round(((entity?.position.x)! + 0.037) * 10000) / 10000, y: round(((entity?.position.y)!) * 10000) / 10000, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque ha sido colocado con éxito!")
                crearTodosLosPanelesDelBloque(bloque: nuevoBloque)
                
                introducirPosicionDelBloqueNuevo(posicionBloqueNuevo: posicionBloqueNuevo)
            }
        }
    }
    
    func colocarBloqueLateralIzquierdaDelBloque(_ entity: Entity?) {
           guard entity != nil else { return }
        if modoQuitarBloques == false {
            let nuevoBloque = crearTipoDeBloqueSeleccionado()
            let posicionBloqueNuevo = SIMD3(x: round(((entity?.position.x)! - 0.037) * 10000) / 10000, y: round(((entity?.position.y)!) * 10000) / 10000, z: (entity?.position.z)!)
            nuevoBloque.position = posicionBloqueNuevo
            
            tableroJuego.addChild(nuevoBloque)

            if arrayDePosicionesDeBloquesTotales.contains(posicionBloqueNuevo) {
                print("¡Ya hay un bloque ahí!")
                tableroJuego.removeChild(nuevoBloque)
            
            } else {
                print("¡Un nuevo bloque ha sido colocado con éxito!")
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
    // Ocultar o Mostrar Interfaz y Pasar de Nivel
    //
    
    func ocultarInterfaz() {
        botonModoBuild.isHidden = false
        botonNextLevel.isHidden = true
        switchModoQuitarBloques.isHidden = true
        labelModoQuitarBloques.isHidden = true
        botonModoBloqueAzul.isHidden = true
        botonModoBloqueRojo.isHidden = true
        botonModoBloqueAmarillo.isHidden = true
        botonModoBloqueVerde.isHidden = true
    }
    
    func mostrarInterfaz() {
        botonModoBuild.isHidden = true
        botonNextLevel.isHidden = false
        switchModoQuitarBloques.isHidden = false
        labelModoQuitarBloques.isHidden = false
        botonModoBloqueAzul.isHidden = false
        botonModoBloqueRojo.isHidden = false
        botonModoBloqueAmarillo.isHidden = false
        botonModoBloqueVerde.isHidden = false
    }
    
    func pasarAlSiguenteNivel()  {
        self.arView.scene.anchors.removeAll()
        arrayDePosicionesDeBloquesTotales.removeAll()
        arrayDePosicionesDeBloquesAzules.removeAll()
        arrayDePosicionesDeBloquesRojos.removeAll()
        arrayDePosicionesDeBloquesAmarillos.removeAll()
        arrayDePosicionesDeBloquesVerdes.removeAll()

        if nivelFaseActual == .start && faseActual == .start {
            nivelFaseActual = .easy1
            faseActual = .easy
            
        } else if nivelFaseActual == .easy1 || nivelFaseActual == .easy2 || nivelFaseActual == .easy3 {
            
            if nivelFaseActual == .easy1 {
                nivelFaseActual = .easy2
                faseActual = .easy
            } else if nivelFaseActual == .easy2 {
                nivelFaseActual = .easy3
                faseActual = .easy
            } else if nivelFaseActual == .easy3 {
                nivelFaseActual = .medium1
                faseActual = .medium
            }
        } else if nivelFaseActual == .medium1 || nivelFaseActual == .medium2 || nivelFaseActual == .medium3 {
            
            if nivelFaseActual == .medium1 {
                nivelFaseActual = .medium2
                faseActual = .medium
            } else if nivelFaseActual == .medium2 {
                nivelFaseActual = .medium3
                faseActual = .medium
            } else if nivelFaseActual == .medium3 {
                nivelFaseActual = .hard1
                faseActual = .hard
            }
        } else if nivelFaseActual == .hard1 || nivelFaseActual == .hard2 || nivelFaseActual == .hard3 {
            
            if nivelFaseActual == .hard1 {
                nivelFaseActual = .hard2
                faseActual = .hard
            } else if nivelFaseActual == .hard2 {
                nivelFaseActual = .hard3
                faseActual = .hard
            } else if nivelFaseActual == .hard3 {
                nivelFaseActual = .insane1
                faseActual = .insane
            }
        } else if nivelFaseActual == .insane1 || nivelFaseActual == .insane2 || nivelFaseActual == .insane3 {
            
            if nivelFaseActual == .insane1 {
                nivelFaseActual = .insane2
                faseActual = .insane
            } else if nivelFaseActual == .insane2 {
                nivelFaseActual = .insane3
                faseActual = .insane
            } else if nivelFaseActual == .insane3 {
                nivelFaseActual = .win
                faseActual = .win
                // Añadir funcion de animacion de ¡WIN!
                
            }
        }
        
        cargarEscenaPrototipo(fase: faseActual)
        
        if faseActual == .easy {
            empezarTimer(tiempo: 20)
        } else if faseActual == .medium {
            empezarTimer(tiempo: 30)
        } else if faseActual == .hard {
            empezarTimer(tiempo: 40)
        } else if faseActual == .insane {
            empezarTimer(tiempo: 50)
        }

    }
    
    
    func comprobarArrays(arrayPosiciones: [SIMD3<Float>], arraySolucion: [SIMD3<Float>]) -> Bool {
        
        var correctoIncorrecto: Bool!
        var indexCorrectos: [Int]! = []
        
        if arrayPosiciones.count == arraySolucion.count {
            for (index, posicion) in arrayPosiciones.enumerated() {
                for (_, posicionSolucion) in arraySolucion.enumerated() {
                    if posicion == posicionSolucion {
                        indexCorrectos.append(index)
                    }
                }
            }
            if indexCorrectos.count == arraySolucion.count {
                correctoIncorrecto = true
            } else {
                correctoIncorrecto = false
            }
        } else {
            correctoIncorrecto = false
        }
        
        return correctoIncorrecto
    }
    
    //
    // Revisar la Solución
    //
    
    func revisarSolucion() -> Bool {

        let numeroDePrototipo = (numeroRandom + 1)
        var correctoIncorrecto: Bool!
        
        if faseActual == .easy {
            if escenaPrototipo == arrayPrototipoEasy1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo1) {
                    print("¡Correcto!")
                    correctoIncorrecto = true
                    
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo 1")
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo2){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo 2")
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo3){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo 3")
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo4){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo 4")
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo5){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo 5")
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposEasyTotales.remove(at: numeroRandom)
            }
            
        } else if faseActual == .medium {
            if numeroDePrototipo == 1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo1) {
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo2){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo3){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo4){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo5){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposMediumTotales.remove(at: numeroRandom)
            }
                
        } else if faseActual == .hard {
            if numeroDePrototipo == 1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo1) {
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo2){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo3){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo4){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo5){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposHardTotales.remove(at: numeroRandom)
            }
            
        } else if faseActual == .insane {
            if numeroDePrototipo == 1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo1) {
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo2){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo3){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo4){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            } else if numeroDePrototipo == 5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo5){
                    print("¡Correcto!")
                    correctoIncorrecto = true
                } else {
                    print("¡Incorrecto! Inténtalo de nuevo")
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposInsaneTotales.remove(at: numeroRandom)
            }
        }
        
        return correctoIncorrecto
    }
}
