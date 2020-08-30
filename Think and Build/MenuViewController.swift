//
//  MenuViewController.swift
//  Think and Build
//
//  Created by Mu qi Zhang on 24/08/2020.
//  Copyright © 2020 tallerapps. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    // Objetos Interfaz
    @IBOutlet weak var tituloThinkBuild: UIImageView!
    
    @IBOutlet weak var botonEmpezarPartida: UIButton!
    
    // Video Fondo
    var video: AVPlayerItem!
    var reproductor: AVQueuePlayer!
    var reproductorEnBucle: AVPlayerLooper!
    var capaVideo: AVPlayerLayer!
    
    override func viewDidLoad() {
        
        // Video Fondo
        guard let videoPath = Bundle.main.path(forResource: "Video Pantalla Inicio", ofType: "mp4") else {
            print("Error: Video not found")
            return
        }
        
        video = AVPlayerItem(url: URL(fileURLWithPath: videoPath))
        reproductor = AVQueuePlayer(playerItem: video)
        reproductorEnBucle = AVPlayerLooper(player: reproductor, templateItem: video)
        capaVideo = AVPlayerLayer(player: reproductor)
        
        capaVideo.frame = self.view.bounds
        
        self.view.layer.addSublayer(capaVideo)
        reproductor.play()
        
        // Objetos Interfaz
        self.view.addSubview(tituloThinkBuild)
        self.view.addSubview(botonEmpezarPartida)
        
        botonEmpezarPartida.isHidden = false
    }
}
