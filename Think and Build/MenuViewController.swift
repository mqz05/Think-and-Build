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
    
    @IBOutlet weak var botonEmpezarPartida: UIButton!
    
    override func viewDidLoad() {
        // Se puede mostrar más tarde, después de la animacion del video
        botonEmpezarPartida.isHidden = false
    }
}
