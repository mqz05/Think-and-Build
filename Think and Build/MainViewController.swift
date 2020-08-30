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
    var modoDeJuegoActual: modoDeJuego = .pausa
    
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
    
    @IBOutlet weak var textoAyuda: UITextView!
    @IBOutlet weak var botonRecolocarTableroJuego: UIButton!
    @IBOutlet weak var botonReady: UIButton!
    
    @IBOutlet weak var switchModoQuitarBloques: UISwitch!
    @IBOutlet weak var marcoModoQuitarBloques: UIImageView!
    
    @IBOutlet weak var botonModoBloqueAzul: UIButton!
    @IBOutlet weak var botonModoBloqueRojo: UIButton!
    @IBOutlet weak var botonModoBloqueAmarillo: UIButton!
    @IBOutlet weak var botonModoBloqueVerde: UIButton!
    
    @IBOutlet weak var barraDeProgresion: UIImageView!
    
    @IBOutlet weak var imagenMedium: UIImageView!
    @IBOutlet weak var imagenHard: UIImageView!
    @IBOutlet weak var imagenInsane: UIImageView!
    
    @IBOutlet weak var imagenTick: UIImageView!
    @IBOutlet weak var imagenCross: UIImageView!
    
    @IBOutlet weak var panelFinal: UIImageView!
    
    // Modos de Bloques (Tipo de Bloques o Quitar Bloques)
    var modoQuitarBloques = false
    
    enum tipoDeBloque {
        case azul, rojo, amarillo, verde
    }
    var tipoDeBloqueActual: tipoDeBloque = .azul
    
    // Paneles de Bloques
    var arrayIndexPanelesQuitados: [Int] = []
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
        superficiePlana.planeDetection = .horizontal
        arView.session.run(superficiePlana)
        
        timerLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 30)
        textoAyuda.font = UIFont(name: "ChalkboardSE-Bold", size: 20)
        textoAyuda.text = "Try to find a flat surface with enough light and move around slowly \nwith the device until the board is placed \n(Make sure the board is placed before pressing READY)"
        
        cargarTableroJuego()
    }
    
    
    //
    //  MARK: Touches Began
    //
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if modoDeJuegoActual == .construccion {
            
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
                    
                    var index = 0
                    
                    for _ in 0...(tableroJuego.children.count - 1) {
                        
                        if index < tableroJuego.children.count {
                            let objeto = tableroJuego.children[index]
                            if (objeto.name == "Panel Lateral Izquierda del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.y == tappedEntity.position.y && objeto.position.x == tappedEntity.position.x - 0.038) || (objeto.name == "Panel Lateral Derecha del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.y == tappedEntity.position.y && objeto.position.x == tappedEntity.position.x + 0.038) || (objeto.name == "Panel Lateral Trasera del Bloque" && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y && objeto.position.z == tappedEntity.position.z + 0.038) || (objeto.name == "Panel Lateral Frontal del Bloque" && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y && objeto.position.z == tappedEntity.position.z - 0.038) || (objeto.name == "Panel Encima del Bloque" && objeto.position.z == tappedEntity.position.z && objeto.position.x == tappedEntity.position.x && objeto.position.y == tappedEntity.position.y + 0.038) {
                                
                                objeto.removeFromParent()
                            } else {
                                index = index + 1
                            }
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
    }
    
    //
    //  MARK: Acciones del Storyboard
    //
    
    @IBAction func activarModoBuild(_ sender: Any) {
        mostrarInterfaz()
        modoDeJuegoActual = .construccion
        
        while tableroJuego.children.count != 1 {
            tableroJuego.children.remove(at: tableroJuego.children.count - 1)
        }
        
        if modoDeJuegoActual == .construccion {
            for i in 1...64 {
                tableroJuego.actions.allActions[i - 1].onAction = colocarBloqueSobreTablero(_:)
            }
        } else {
            for i in 1...64 {
                tableroJuego.actions.allActions[i - 1].onAction = nil
            }
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
        
        if modoDeJuegoActual != .pausa {
            
            modoDeJuegoActual = .pausa
            
            if revisarSolucion() == true {
                animacionCorrectoPasarNivel()
            } else {
                animacionIncorrectoGameOver()
            }
        }
    }
    
    @IBAction func recolocarTablero(_ sender: Any) {
        arView.scene.anchors.removeAll()
        
        tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
        arView.scene.anchors.append(tableroJuego)
        
        for i in 1...64 {
            let casilla = tableroJuego.casillaEntities[i - 1]
            casilla.position = SIMD3(x: round(casilla.position.x * 10000) / 10000, y: round(casilla.position.y * 10000) / 10000, z: round(casilla.position.z * 10000) / 10000)
        }
    }
    
    @IBAction func empezarPartida(_ sender: Any) {
        botonReady.isHidden = true
        botonRecolocarTableroJuego.isHidden = true
        timerLabel.isHidden = false
        textoAyuda.isHidden = true
        barraDeProgresion.isHidden = false
        
        modoDeJuegoActual = .memorizacion
        
        ocultarInterfaz()
        pasarAlSiguenteNivel()
    }
    
    @IBAction func acciónModoQuitarBloques(_ sender: Any) {
        if (sender as AnyObject).isOn {
            modoQuitarBloques = true
            for panelesDeBloques in 1...tableroJuego.children.count {
                let objeto = tableroJuego.children[panelesDeBloques - 1]
                if objeto.name == "Panel Lateral Izquierda del Bloque" || objeto.name == "Panel Lateral Derecha del Bloque" || objeto.name == "Panel Lateral Trasera del Bloque" || objeto.name == "Panel Lateral Frontal del Bloque" || objeto.name == "Panel Encima del Bloque" {
                    objeto.isEnabled = false
                }
            }
            print("Hey! Now you are removing blocks!")
        } else {
            modoQuitarBloques = false
            
            for panelesDeBloques in 1...tableroJuego.children.count {
                let objeto = tableroJuego.children[panelesDeBloques - 1]
                if objeto.name == "Panel Lateral Izquierda del Bloque" || objeto.name == "Panel Lateral Derecha del Bloque" || objeto.name == "Panel Lateral Trasera del Bloque" || objeto.name == "Panel Lateral Frontal del Bloque" || objeto.name == "Panel Encima del Bloque" {
                    objeto.isEnabled = true
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
        let urlPath = Bundle.main.path(forResource: "CuboAzul", ofType: "usdz")
        let url = URL(fileURLWithPath: urlPath!)
        nuevoBloque = try? ModelEntity.loadModel(contentsOf: url)
        nuevoBloque.scale = SIMD3(x: 0.005, y: 0.005, z: 0.005)
        nuevoBloque.name = "Bloque Azul"
        return nuevoBloque
    }
    
    func crearBloqueRojo() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        let urlPath = Bundle.main.path(forResource: "CuboRojo", ofType: "usdz")
        let url = URL(fileURLWithPath: urlPath!)
        nuevoBloque = try? ModelEntity.loadModel(contentsOf: url)
        nuevoBloque.scale = SIMD3(x: 0.005, y: 0.005, z: 0.005)
        nuevoBloque.name = "Bloque Rojo"
        return nuevoBloque
    }
    
    func crearBloqueAmarillo() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        let urlPath = Bundle.main.path(forResource: "CuboAmarillo", ofType: "usdz")
        let url = URL(fileURLWithPath: urlPath!)
        nuevoBloque = try? ModelEntity.loadModel(contentsOf: url)
        nuevoBloque.scale = SIMD3(x: 0.005, y: 0.005, z: 0.005)
        nuevoBloque.name = "Bloque Amarillo"
        return nuevoBloque
    }
    
    func crearBloqueVerde() -> ModelEntity {
        var nuevoBloque: ModelEntity!
        let urlPath = Bundle.main.path(forResource: "CuboVerde", ofType: "usdz")
        let url = URL(fileURLWithPath: urlPath!)
        nuevoBloque = try? ModelEntity.loadModel(contentsOf: url)
        nuevoBloque.scale = SIMD3(x: 0.005, y: 0.005, z: 0.005)
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
        tiempoTotal = tiempo
        timerLabel.text = calcularTiempoParaLabel(segundosTotales: tiempoTotal)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizarTimer), userInfo: nil, repeats: true)
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
    // Cargera Tablero Juego y Cargar Escenas Prototipo
    //
    func cargarTableroJuego() {
        botonModoBuild.isHidden = true
        botonNextLevel.isHidden = true
        switchModoQuitarBloques.isHidden = true
        marcoModoQuitarBloques.isHidden = true
        botonModoBloqueAzul.isHidden = true
        botonModoBloqueRojo.isHidden = true
        botonModoBloqueAmarillo.isHidden = true
        botonModoBloqueVerde.isHidden = true
        timerLabel.isHidden = true
        
        self.arView.scene.anchors.removeAll()
        
        tableroJuego = try! EscenasJuego.loadTableroPrincipalDeJuego()
        self.arView.scene.anchors.append(tableroJuego)
        
        for i in 1...64 {
            let casilla = tableroJuego.casillaEntities[i - 1]
            casilla.position = SIMD3(x: round(casilla.position.x * 10000) / 10000, y: round(casilla.position.y * 10000) / 10000, z: round(casilla.position.z * 10000) / 10000)
        }
    }
    
    func cargarEscenaPrototipo(fase: fasesTotales) {
        
        if fase == .easy {
            numeroRandom = Int.random(in: 0...(arrayPrototiposEasyTotales.count - 1))
            escenaPrototipo = arrayPrototiposEasyTotales[numeroRandom]
            
        } else if fase == .medium {
            numeroRandom = Int.random(in: 0...(arrayPrototiposMediumTotales.count - 1))
            escenaPrototipo = arrayPrototiposMediumTotales[numeroRandom]
            
        } else if fase == .hard {
            numeroRandom = Int.random(in: 0...(arrayPrototiposHardTotales.count - 1))
            escenaPrototipo = arrayPrototiposHardTotales[numeroRandom]
            
        } else if fase == .insane {
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
                tableroJuego.addChild(bloqueAzul)
            }
        }
        
        if bloquesRojosPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesRojosPrototipo.count - 1) {
                let bloqueRojo = crearBloqueRojo()
                bloqueRojo.position = bloquesRojosPrototipo[numeroDelBloque]
                tableroJuego.addChild(bloqueRojo)
            }
        }
        
        if bloquesAmarillosPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesAmarillosPrototipo.count - 1){
                let bloqueAmarillo = crearBloqueAmarillo()
                bloqueAmarillo.position = bloquesAmarillosPrototipo[numeroDelBloque]
                tableroJuego.addChild(bloqueAmarillo)
            }
        }
        
        if bloquesVerdesPrototipo.count != 0 {
            for numeroDelBloque in 0...(bloquesVerdesPrototipo.count - 1) {
                let bloqueVerde = crearBloqueVerde()
                bloqueVerde.position = bloquesVerdesPrototipo[numeroDelBloque]
                tableroJuego.addChild(bloqueVerde)
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
        if modoDeJuegoActual == .construccion {
            
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
    
    func crearPanel() -> ModelEntity {
        var material = SimpleMaterial()
        material.metallic = .float(0.0)
        material.roughness = .float(0.0)
        material.baseColor = .color(UIColor.gray.withAlphaComponent(0.35))
        
        let panel = ModelEntity.init(mesh: .generatePlane(width: 0.065, height: 0.065))
        panel.model?.materials = [material]
        
        panel.generateCollisionShapes(recursive: true)
        
        return panel
    }
    
    func crearPanelEncimaDelBloque(bloque: ModelEntity) {
        let panelEncimaDelBloque = crearPanel()
        
        panelEncimaDelBloque.orientation = simd_quatf(angle: -(Float.pi/2), axis: [1, 0, 0])
        panelEncimaDelBloque.position = SIMD3(x: (bloque.position.x), y: (bloque.position.y) + 0.038, z: (bloque.position.z))
        panelEncimaDelBloque.name = "Panel Encima del Bloque"
        
        tableroJuego.addChild(panelEncimaDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralFrontalDelBloque(bloque: ModelEntity) {
        let panelLateralFrontalDelBloque = crearPanel()
        
        panelLateralFrontalDelBloque.orientation = simd_quatf(angle: Float.pi, axis: [0, 1, 0])
        panelLateralFrontalDelBloque.position = SIMD3(x: (bloque.position.x), y: (bloque.position.y), z: (bloque.position.z) - 0.038)
        panelLateralFrontalDelBloque.name = "Panel Lateral Frontal del Bloque"
        
        tableroJuego.addChild(panelLateralFrontalDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralTraseraDelBloque(bloque: ModelEntity) {
        let panelLateralTraseraDelBloque = crearPanel()
        
        panelLateralTraseraDelBloque.orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
        panelLateralTraseraDelBloque.position = SIMD3(x: (bloque.position.x), y: (bloque.position.y), z: (bloque.position.z) + 0.038)
        panelLateralTraseraDelBloque.name = "Panel Lateral Trasera del Bloque"
        
        tableroJuego.addChild(panelLateralTraseraDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralDerechaDelBloque(bloque: ModelEntity) {
        let panelLateralDerechaDelBloque = crearPanel()
        
        panelLateralDerechaDelBloque.orientation = simd_quatf(angle: Float.pi/2, axis: [0, 1, 0])
        panelLateralDerechaDelBloque.position = SIMD3(x: (bloque.position.x) + 0.038, y: (bloque.position.y), z: (bloque.position.z))
        panelLateralDerechaDelBloque.name = "Panel Lateral Derecha del Bloque"
        
        tableroJuego.addChild(panelLateralDerechaDelBloque)
        seHaCreadoPanel = true
    }
    
    func crearPanelLateralIzquierdaDelBloque(bloque: ModelEntity) {
        let panelLateralIzquierdaDelBloque = crearPanel()
        
        panelLateralIzquierdaDelBloque.orientation = simd_quatf(angle: -(Float.pi/2), axis: [0, 1, 0])
        panelLateralIzquierdaDelBloque.position = SIMD3(x: (bloque.position.x) - 0.038, y: (bloque.position.y), z: (bloque.position.z))
        panelLateralIzquierdaDelBloque.name = "Panel Lateral Izquierda del Bloque"
        
        tableroJuego.addChild(panelLateralIzquierdaDelBloque)
        seHaCreadoPanel = true
    }
    
    
    //
    // Ocultar o Mostrar Interfaz, Pasar de Nivel y Animaciones
    //
    
    func ocultarInterfaz() {
        botonModoBuild.isHidden = false
        botonNextLevel.isHidden = true
        switchModoQuitarBloques.isHidden = true
        marcoModoQuitarBloques.isHidden = true
        botonModoBloqueAzul.isHidden = true
        botonModoBloqueRojo.isHidden = true
        botonModoBloqueAmarillo.isHidden = true
        botonModoBloqueVerde.isHidden = true
    }
    
    func mostrarInterfaz() {
        botonModoBuild.isHidden = true
        botonNextLevel.isHidden = false
        switchModoQuitarBloques.isHidden = false
        marcoModoQuitarBloques.isHidden = false
        botonModoBloqueAzul.isHidden = false
        botonModoBloqueRojo.isHidden = false
        botonModoBloqueAmarillo.isHidden = false
        botonModoBloqueVerde.isHidden = false
    }
    
    func animacionCorrectoPasarNivel() {
        imagenTick.isHidden = false
        UIView.animate(withDuration: 0.75, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.imagenTick.transform = CGAffineTransform(scaleX: 10, y: 10)
        }, completion: { finished in
            self.animacionQuitarTickPasarNivel()
            
        })
    }
    
    func animacionQuitarTickPasarNivel() {
        UIView.animate(withDuration: 0.4, delay: 1.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.imagenTick.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        }, completion: { finished in
            self.imagenTick.isHidden = true
            self.modoDeJuegoActual = .memorizacion
            self.ocultarInterfaz()
            self.pasarAlSiguenteNivel()
        })
    }
    
    func animacionIncorrectoGameOver() {
        imagenCross.isHidden = false
        UIView.animate(withDuration: 0.75, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.imagenCross.transform = CGAffineTransform(scaleX: 10, y: 10)
        }, completion: { finished in
            self.animacionQuitarCrossGameOver()
        })
    }
    
    func animacionQuitarCrossGameOver() {
        UIView.animate(withDuration: 0.4, delay: 1.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.imagenCross.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        }, completion: { finished in
            self.imagenCross.isHidden = true
            self.perform(#selector(self.animacionGameOver), with: nil, afterDelay: 0.75)
        })
    }
    
    func animacionPanelFinal() {
        panelFinal.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.panelFinal.transform = CGAffineTransform(scaleX: 15, y: 15)
        }, completion: nil)
    }
    
    func animacionWin() {
        animacionPanelFinal()
    }
    
    @objc func animacionGameOver() {
        animacionPanelFinal()
    }
    
    func animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: String) {
        UIView.animate(withDuration: 0.75, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.barraDeProgresion.alpha = 0.2
        }, completion: { finished in
            self.barraDeProgresion.image = UIImage(named: siguienteBarraDeProgreso)
            UIView.animate(withDuration: 0.75, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.barraDeProgresion.alpha = 1
            }, completion: { finished in
                if siguienteBarraDeProgreso == "Barra de Progreso 4" {
                    self.animacionTituloFase(fase: self.imagenMedium)
                } else if siguienteBarraDeProgreso == "Barra de Progreso 7" {
                    self.animacionTituloFase(fase: self.imagenHard)
                } else if siguienteBarraDeProgreso == "Barra de Progreso 10" {
                    self.animacionTituloFase(fase: self.imagenInsane)
                }
            })
        })
    }
    
    func animacionTituloFase(fase: UIImageView) {
        fase.isHidden = false
        UIView.animate(withDuration: 0.75, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            fase.transform = CGAffineTransform(scaleX: 6, y: 6)
        }, completion: { finished in
            UIView.animate(withDuration: 1, delay: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
                fase.alpha = 0
            }, completion: nil)
        })
    }
    
    func pasarAlSiguenteNivel()  {
        arrayDePosicionesDeBloquesTotales.removeAll()
        arrayDePosicionesDeBloquesAzules.removeAll()
        arrayDePosicionesDeBloquesRojos.removeAll()
        arrayDePosicionesDeBloquesAmarillos.removeAll()
        arrayDePosicionesDeBloquesVerdes.removeAll()
        
        while tableroJuego.children.count != 1 {
            tableroJuego.children.remove(at: tableroJuego.children.count - 1)
        }
        
        if modoDeJuegoActual == .construccion {
            for i in 1...64 {
                tableroJuego.actions.allActions[i - 1].onAction = colocarBloqueSobreTablero(_:)
            }
        } else {
            for i in 1...64 {
                tableroJuego.actions.allActions[i - 1].onAction = nil
            }
        }

        if nivelFaseActual == .start && faseActual == .start {
            nivelFaseActual = .easy1
            faseActual = .easy
            
        } else if nivelFaseActual == .easy1 || nivelFaseActual == .easy2 || nivelFaseActual == .easy3 {
            
            if nivelFaseActual == .easy1 {
                nivelFaseActual = .easy2
                faseActual = .easy
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 2")
            } else if nivelFaseActual == .easy2 {
                nivelFaseActual = .easy3
                faseActual = .easy
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 3")
            } else if nivelFaseActual == .easy3 {
                nivelFaseActual = .medium1
                faseActual = .medium
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 4")
            }
        } else if nivelFaseActual == .medium1 || nivelFaseActual == .medium2 || nivelFaseActual == .medium3 {
            
            if nivelFaseActual == .medium1 {
                nivelFaseActual = .medium2
                faseActual = .medium
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 5")
            } else if nivelFaseActual == .medium2 {
                nivelFaseActual = .medium3
                faseActual = .medium
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 6")
            } else if nivelFaseActual == .medium3 {
                nivelFaseActual = .hard1
                faseActual = .hard
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 7")
            }
        } else if nivelFaseActual == .hard1 || nivelFaseActual == .hard2 || nivelFaseActual == .hard3 {
            
            if nivelFaseActual == .hard1 {
                nivelFaseActual = .hard2
                faseActual = .hard
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 8")
            } else if nivelFaseActual == .hard2 {
                nivelFaseActual = .hard3
                faseActual = .hard
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 9")
            } else if nivelFaseActual == .hard3 {
                nivelFaseActual = .insane1
                faseActual = .insane
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 10")
            }
        } else if nivelFaseActual == .insane1 || nivelFaseActual == .insane2 || nivelFaseActual == .insane3 {
            
            if nivelFaseActual == .insane1 {
                nivelFaseActual = .insane2
                faseActual = .insane
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 11")
            } else if nivelFaseActual == .insane2 {
                nivelFaseActual = .insane3
                faseActual = .insane
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 12")
            } else if nivelFaseActual == .insane3 {
                nivelFaseActual = .win
                faseActual = .win
                modoDeJuegoActual = .pausa
                animacionSubirBarraDeProgreso1(siguienteBarraDeProgreso: "Barra de Progreso 13")
                
                animacionWin()
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
    
    
    //
    // Revisar la Solución
    //
    
    func revisarSolucion() -> Bool {

        var correctoIncorrecto: Bool!
        
        if faseActual == .easy {
            if escenaPrototipo == arrayPrototipoEasy1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo1) {
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo2){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo3){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo4){
                     
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoEasy5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesEasyPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosEasyPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosEasyPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesEasyPrototipo5){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposEasyTotales.remove(at: numeroRandom)
            }
            
        } else if faseActual == .medium {
            if escenaPrototipo == arrayPrototipoMedium1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo1) {
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoMedium2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo2){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoMedium3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo3){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoMedium4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo4){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoMedium5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesMediumPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosMediumPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosMediumPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesMediumPrototipo5){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposMediumTotales.remove(at: numeroRandom)
            }
                
        } else if faseActual == .hard {
            if escenaPrototipo == arrayPrototipoHard1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo1) {
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoHard2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo2){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoHard3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo3){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoHard4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo4){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoHard5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesHardPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosHardPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosHardPrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesHardPrototipo5){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposHardTotales.remove(at: numeroRandom)
            }
            
        } else if faseActual == .insane {
            if escenaPrototipo == arrayPrototipoInsane1 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo1) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo1) {
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoInsane2 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo2) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo2){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoInsane3 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo3) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo3){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoInsane4 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo4) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo4){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            } else if escenaPrototipo == arrayPrototipoInsane5 {
                if comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAzules, arraySolucion: arraySolucionesBloquesAzulesInsanePrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesRojos, arraySolucion: arraySolucionesBloquesRojosInsanePrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesAmarillos, arraySolucion: arraySolucionesBloquesAmarillosInsanePrototipo5) && comprobarArrays(arrayPosiciones: arrayDePosicionesDeBloquesVerdes, arraySolucion: arraySolucionesBloquesVerdesInsanePrototipo5){
                    correctoIncorrecto = true
                } else {
                    correctoIncorrecto = false
                }
            }
            
            if correctoIncorrecto == true {
                arrayPrototiposInsaneTotales.remove(at: numeroRandom)
            }
        }
        
        return correctoIncorrecto
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
}
