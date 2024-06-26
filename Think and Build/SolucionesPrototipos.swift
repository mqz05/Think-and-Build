//
//  EscenasPrototiposConSoluciones.swift
//  Think and Build
//
//  Created by Mu qi Zhang on 17/06/2020.
//  Copyright © 2020 tallerapps. All rights reserved.
//

import UIKit
import ARKit
import RealityKit


//
// Soluciones Arrays
//

// Easy
var arraySolucionesBloquesAzulesEasyPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.1125, 0.0425, -0.1125), SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.1175, -0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(-0.0375, 0.1175, 0.0375), SIMD3<Float>(0.1125, 0.0425, 0.1125)]
var arraySolucionesBloquesRojosEasyPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(0.1125, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.1175, -0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.1125)]
var arraySolucionesBloquesAmarillosEasyPrototipo1: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesEasyPrototipo1: Array<SIMD3<Float>> = []
var arrayPrototipoEasy1 = [arraySolucionesBloquesAzulesEasyPrototipo1, arraySolucionesBloquesRojosEasyPrototipo1, arraySolucionesBloquesAmarillosEasyPrototipo1, arraySolucionesBloquesVerdesEasyPrototipo1]

var arraySolucionesBloquesAzulesEasyPrototipo2: Array<SIMD3<Float>> = []
var arraySolucionesBloquesRojosEasyPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.2625, 0.0425, -0.2625), SIMD3<Float>(0.1125, 0.0425, -0.2625), SIMD3<Float>(0.1125, 0.1175, -0.2625), SIMD3<Float>(0.1875, 0.0425, -0.1875), SIMD3<Float>(0.1875, 0.1175, -0.1875), SIMD3<Float>(0.1875, 0.1925, -0.1875), SIMD3<Float>(0.2625, 0.0425, -0.1125), SIMD3<Float>(0.2625, 0.1175, -0.1125), SIMD3<Float>(-0.2625, 0.0425, 0.2625), SIMD3<Float>(-0.1875, 0.0425, 0.1875), SIMD3<Float>(-0.1875, 0.1175, 0.1875), SIMD3<Float>(-0.1875, 0.1925, 0.1875), SIMD3<Float>(-0.1125, 0.0425, 0.2625), SIMD3<Float>(-0.2625, 0.0425, 0.1125), SIMD3<Float>(-0.2625, 0.1175, 0.1125), SIMD3<Float>(-0.1125, 0.1175, 0.2625)]
var arraySolucionesBloquesAmarillosEasyPrototipo2: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesEasyPrototipo2: Array<SIMD3<Float>> = []
var arrayPrototipoEasy2 = [arraySolucionesBloquesAzulesEasyPrototipo2, arraySolucionesBloquesRojosEasyPrototipo2, arraySolucionesBloquesAmarillosEasyPrototipo2, arraySolucionesBloquesVerdesEasyPrototipo2]

var arraySolucionesBloquesAzulesEasyPrototipo3: Array<SIMD3<Float>> = []
var arraySolucionesBloquesRojosEasyPrototipo3: Array<SIMD3<Float>> = []
var arraySolucionesBloquesAmarillosEasyPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(0.1125, 0.0425, -0.2625), SIMD3<Float>(0.1125, 0.0425, 0.1125), SIMD3<Float>(-0.2625, 0.0425, 0.1125), SIMD3<Float>(-0.1875, 0.0425, -0.1125)]
var arraySolucionesBloquesVerdesEasyPrototipo3: Array<SIMD3<Float>> = []
var arrayPrototipoEasy3 = [arraySolucionesBloquesAzulesEasyPrototipo3, arraySolucionesBloquesRojosEasyPrototipo3, arraySolucionesBloquesAmarillosEasyPrototipo3, arraySolucionesBloquesVerdesEasyPrototipo3]

var arraySolucionesBloquesAzulesEasyPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.1875), SIMD3<Float>(-0.2625, 0.1175, -0.1875), SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(-0.2625, 0.0425, 0.1125), SIMD3<Float>(-0.2625, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.0425, -0.1125), SIMD3<Float>(0.0375, 0.0425, 0.0375)]
var arraySolucionesBloquesRojosEasyPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.0375), SIMD3<Float>(0.2625, 0.0425, -0.1875), SIMD3<Float>(0.2625, 0.1175, -0.1875), SIMD3<Float>(0.2625, 0.0425, 0.1125), SIMD3<Float>(0.2625, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, -0.1125)]
var arraySolucionesBloquesAmarillosEasyPrototipo4: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesEasyPrototipo4: Array<SIMD3<Float>> = []
var arrayPrototipoEasy4 = [arraySolucionesBloquesAzulesEasyPrototipo4, arraySolucionesBloquesRojosEasyPrototipo4, arraySolucionesBloquesAmarillosEasyPrototipo4, arraySolucionesBloquesVerdesEasyPrototipo4]

var arraySolucionesBloquesAzulesEasyPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.1125, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.1175, -0.0375), SIMD3<Float>(-0.1125, 0.1925, -0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.1125, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.1925, 0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.2625), SIMD3<Float>(-0.1875, 0.1175, 0.2625), SIMD3<Float>(0.1125, 0.0425, 0.1125), SIMD3<Float>(0.1125, 0.0425, -0.1875), SIMD3<Float>(-0.2625, 0.0425, -0.1125), SIMD3<Float>(-0.2625, 0.1175, -0.1125)]
var arraySolucionesBloquesRojosEasyPrototipo5: Array<SIMD3<Float>> = []
var arraySolucionesBloquesAmarillosEasyPrototipo5: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesEasyPrototipo5: Array<SIMD3<Float>> = []
var arrayPrototipoEasy5 = [arraySolucionesBloquesAzulesEasyPrototipo5, arraySolucionesBloquesRojosEasyPrototipo5, arraySolucionesBloquesAmarillosEasyPrototipo5, arraySolucionesBloquesVerdesEasyPrototipo5]

var arrayPrototiposEasyTotales = [arrayPrototipoEasy1, arrayPrototipoEasy2, arrayPrototipoEasy3, arrayPrototipoEasy4, arrayPrototipoEasy5]


// Medium
var arraySolucionesBloquesAzulesMediumPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(0.1875, 0.0425, -0.1875), SIMD3<Float>(0.1875, 0.1175, -0.1875), SIMD3<Float>(0.2625, 0.0425, -0.2625), SIMD3<Float>(0.2625, 0.1175, -0.2625), SIMD3<Float>(0.2625, 0.1925, -0.2625), SIMD3<Float>(-0.1875, 0.0425, 0.1875), SIMD3<Float>(-0.1875, 0.1175, 0.1875), SIMD3<Float>(-0.2625, 0.0425, 0.2625), SIMD3<Float>(-0.2625, 0.1175, 0.2625), SIMD3<Float>(-0.2625, 0.1925, 0.2625)]
var arraySolucionesBloquesRojosMediumPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.1875, 0.0425, -0.1875), SIMD3<Float>(-0.2625, 0.0425, -0.2625), SIMD3<Float>(-0.2625, 0.1175, -0.2625), SIMD3<Float>(-0.2625, 0.1925, -0.2625), SIMD3<Float>(-0.1875, 0.1175, -0.1875), SIMD3<Float>(0.1875, 0.0425, 0.1875), SIMD3<Float>(0.1875, 0.1175, 0.1875), SIMD3<Float>(0.2625, 0.0425, 0.2625), SIMD3<Float>(0.2625, 0.1175, 0.2625), SIMD3<Float>(0.2625, 0.1925, 0.2625)]
var arraySolucionesBloquesAmarillosMediumPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.2625), SIMD3<Float>(0.0375, 0.0425, 0.2625), SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(-0.2625, 0.0425, 0.0375)]
var arraySolucionesBloquesVerdesMediumPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, -0.2625), SIMD3<Float>(-0.2625, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.2625), SIMD3<Float>(0.2625, 0.0425, 0.0375)]
var arrayPrototipoMedium1 = [arraySolucionesBloquesAzulesMediumPrototipo1, arraySolucionesBloquesRojosMediumPrototipo1, arraySolucionesBloquesAmarillosMediumPrototipo1, arraySolucionesBloquesVerdesMediumPrototipo1]

var arraySolucionesBloquesAzulesMediumPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.2625, 0.0425, -0.1875), SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(0.2625, 0.1175, -0.0375), SIMD3<Float>(0.2625, 0.0425, 0.1125), SIMD3<Float>(0.2625, 0.0425, 0.2625), SIMD3<Float>(0.2625, 0.1175, 0.2625)]
var arraySolucionesBloquesRojosMediumPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.2625), SIMD3<Float>(-0.1125, 0.0425, -0.2625), SIMD3<Float>(-0.1125, 0.1175, -0.2625), SIMD3<Float>(0.0375, 0.0425, -0.2625), SIMD3<Float>(0.1875, 0.0425, -0.2625), SIMD3<Float>(0.1875, 0.1175, -0.2625)]
var arraySolucionesBloquesAmarillosMediumPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.1125, 0.0425, 0.2625), SIMD3<Float>(-0.0375, 0.0425, 0.2625), SIMD3<Float>(-0.0375, 0.1175, 0.2625), SIMD3<Float>(-0.1875, 0.0425, 0.2625)]
var arraySolucionesBloquesVerdesMediumPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.1125), SIMD3<Float>(-0.2625, 0.1175, -0.1125), SIMD3<Float>(-0.2625, 0.0425, 0.0375), SIMD3<Float>(-0.2625, 0.0425, 0.1875), SIMD3<Float>(-0.2625, 0.1175, 0.1875)]
var arrayPrototipoMedium2 = [arraySolucionesBloquesAzulesMediumPrototipo2, arraySolucionesBloquesRojosMediumPrototipo2, arraySolucionesBloquesAmarillosMediumPrototipo2, arraySolucionesBloquesVerdesMediumPrototipo2]

var arraySolucionesBloquesAzulesMediumPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.2625), SIMD3<Float>(-0.0375, 0.0425, -0.1875), SIMD3<Float>(-0.2625, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.0425, -0.0375)]
var arraySolucionesBloquesRojosMediumPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.2625), SIMD3<Float>(-0.0375, 0.0425, 0.1875)]
var arraySolucionesBloquesAmarillosMediumPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, -0.1125), SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375)]
var arraySolucionesBloquesVerdesMediumPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, 0.1125), SIMD3<Float>(0.1125, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375)]
var arrayPrototipoMedium3 = [arraySolucionesBloquesAzulesMediumPrototipo3, arraySolucionesBloquesRojosMediumPrototipo3, arraySolucionesBloquesAmarillosMediumPrototipo3, arraySolucionesBloquesVerdesMediumPrototipo3]

var arraySolucionesBloquesAzulesMediumPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(0.1125, 0.0425, 0.1875), SIMD3<Float>(0.1125, 0.0425, 0.1125), SIMD3<Float>(0.1125, 0.1175, 0.1125), SIMD3<Float>(0.1125, 0.1175, 0.1875), SIMD3<Float>(0.0375, 0.0425, 0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.1125), SIMD3<Float>(-0.1125, 0.0425, 0.1125), SIMD3<Float>(-0.1125, 0.1175, 0.1125), SIMD3<Float>(-0.1125, 0.0425, 0.1875), SIMD3<Float>(-0.1125, 0.1175, 0.1875), SIMD3<Float>(0.1125, 0.0425, -0.1875), SIMD3<Float>(0.1125, 0.0425, -0.1125), SIMD3<Float>(0.1125, 0.1175, -0.1875), SIMD3<Float>(0.1125, 0.1175, -0.1125), SIMD3<Float>(0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.1125, 0.0425, -0.1125), SIMD3<Float>(-0.1125, 0.0425, -0.1875), SIMD3<Float>(-0.1125, 0.1175, -0.1875), SIMD3<Float>(-0.1125, 0.1175, -0.1125)]
var arraySolucionesBloquesRojosMediumPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.1875, 0.0425, -0.1875), SIMD3<Float>(-0.1875, 0.0425, -0.1125), SIMD3<Float>(-0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.1125), SIMD3<Float>(-0.1875, 0.0425, 0.1875), SIMD3<Float>(-0.1875, 0.1175, -0.1875), SIMD3<Float>(-0.1875, 0.1175, -0.1125), SIMD3<Float>(-0.1875, 0.1175, -0.0375), SIMD3<Float>(-0.1875, 0.1175, 0.0375), SIMD3<Float>(-0.1875, 0.1175, 0.1125), SIMD3<Float>(-0.1875, 0.1175, 0.1875), SIMD3<Float>(-0.1875, 0.1925, -0.1875), SIMD3<Float>(-0.1875, 0.1925, -0.1125), SIMD3<Float>(-0.1875, 0.1925, 0.1125), SIMD3<Float>(-0.1875, 0.1925, 0.1875), SIMD3<Float>(0.1875, 0.0425, -0.1875), SIMD3<Float>(0.1875, 0.0425, -0.1125), SIMD3<Float>(0.1875, 0.1175, -0.1125), SIMD3<Float>(0.1875, 0.1175, -0.1875), SIMD3<Float>(0.1875, 0.1925, -0.1875), SIMD3<Float>(0.1875, 0.1925, -0.1125), SIMD3<Float>(0.1875, 0.0425, -0.0375), SIMD3<Float>(0.1875, 0.1175, -0.0375), SIMD3<Float>(0.1875, 0.0425, 0.0375), SIMD3<Float>(0.1875, 0.1175, 0.0375), SIMD3<Float>(0.1875, 0.0425, 0.1125), SIMD3<Float>(0.1875, 0.1175, 0.1125), SIMD3<Float>(0.1875, 0.1925, 0.1125), SIMD3<Float>(0.1875, 0.0425, 0.1875), SIMD3<Float>(0.1875, 0.1175, 0.1875), SIMD3<Float>(0.1875, 0.1925, 0.1875)]
var arraySolucionesBloquesAmarillosMediumPrototipo4: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesMediumPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375)]
var arrayPrototipoMedium4 = [arraySolucionesBloquesAzulesMediumPrototipo4, arraySolucionesBloquesRojosMediumPrototipo4, arraySolucionesBloquesAmarillosMediumPrototipo4, arraySolucionesBloquesVerdesMediumPrototipo4]

var arraySolucionesBloquesAzulesMediumPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.1175, -0.0375), SIMD3<Float>(0.0375, 0.1175, 0.0375), SIMD3<Float>(0.0375, 0.1925, -0.0375), SIMD3<Float>(0.0375, 0.1925, 0.0375), SIMD3<Float>(0.1125, 0.1925, -0.0375), SIMD3<Float>(0.1125, 0.1925, 0.0375), SIMD3<Float>(0.1125, 0.2675, -0.0375), SIMD3<Float>(0.1125, 0.2675, 0.0375)]
var arraySolucionesBloquesRojosMediumPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.2625), SIMD3<Float>(-0.1125, 0.0425, -0.1875), SIMD3<Float>(-0.0375, 0.0425, -0.1875), SIMD3<Float>(-0.1125, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.1125, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.1125), SIMD3<Float>(-0.1125, 0.0425, 0.1875), SIMD3<Float>(-0.0375, 0.0425, 0.1875), SIMD3<Float>(-0.0375, 0.0425, 0.2625), SIMD3<Float>(-0.0375, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.1175, -0.0375), SIMD3<Float>(-0.0375, 0.1175, -0.0375), SIMD3<Float>(-0.0375, 0.1175, -0.1125)]
var arraySolucionesBloquesAmarillosMediumPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.0375), SIMD3<Float>(-0.2625, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.0425, -0.1125), SIMD3<Float>(-0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.1125)]
var arraySolucionesBloquesVerdesMediumPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(0.1875, 0.1925, -0.0375), SIMD3<Float>(0.1875, 0.1925, 0.0375), SIMD3<Float>(0.1875, 0.2675, -0.0375), SIMD3<Float>(0.1875, 0.2675, 0.0375), SIMD3<Float>(0.2625, 0.2675, -0.0375), SIMD3<Float>(0.2625, 0.2675, 0.0375), SIMD3<Float>(0.2625, 0.3425, -0.0375), SIMD3<Float>(0.2625, 0.3425, 0.0375)]
var arrayPrototipoMedium5 = [arraySolucionesBloquesAzulesMediumPrototipo5, arraySolucionesBloquesRojosMediumPrototipo5, arraySolucionesBloquesAmarillosMediumPrototipo5, arraySolucionesBloquesVerdesMediumPrototipo5]

var arrayPrototiposMediumTotales = [arrayPrototipoMedium1, arrayPrototipoMedium2, arrayPrototipoMedium3, arrayPrototipoMedium4, arrayPrototipoMedium5]


// Hard
var arraySolucionesBloquesAzulesHardPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.1175, -0.1125), SIMD3<Float>(-0.1125, 0.1175, -0.1125), SIMD3<Float>(-0.0375, 0.1175, -0.1125), SIMD3<Float>(-0.0375, 0.1925, -0.0375), SIMD3<Float>(0.0375, 0.1925, -0.0375), SIMD3<Float>(0.1125, 0.1925, -0.0375), SIMD3<Float>(0.1125, 0.2675, 0.0375), SIMD3<Float>(0.1875, 0.2675, 0.0375), SIMD3<Float>(0.2625, 0.2675, 0.0375)]
var arraySolucionesBloquesRojosHardPrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.1175, 0.1125), SIMD3<Float>(-0.1125, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.1925, 0.1875), SIMD3<Float>(0.0375, 0.1925, 0.1875), SIMD3<Float>(0.1125, 0.1925, 0.1875), SIMD3<Float>(0.1125, 0.2675, 0.2625), SIMD3<Float>(0.1875, 0.2675, 0.2625), SIMD3<Float>(0.2625, 0.2675, 0.2625)]
var arraySolucionesBloquesAmarillosHardPrototipo1: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesHardPrototipo1: Array<SIMD3<Float>> = []
var arrayPrototipoHard1 = [arraySolucionesBloquesAzulesHardPrototipo1, arraySolucionesBloquesRojosHardPrototipo1, arraySolucionesBloquesAmarillosHardPrototipo1, arraySolucionesBloquesVerdesHardPrototipo1]

var arraySolucionesBloquesAzulesHardPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.1925, 0.0375), SIMD3<Float>(0.1125, 0.1175, 0.1125), SIMD3<Float>(0.1875, 0.0425, -0.1875), SIMD3<Float>(0.2625, 0.0425, -0.2625)]
var arraySolucionesBloquesRojosHardPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.1925, -0.0375), SIMD3<Float>(-0.1125, 0.1175, -0.1125), SIMD3<Float>(-0.1875, 0.0425, 0.1875), SIMD3<Float>(-0.2625, 0.0425, 0.2625)]
var arraySolucionesBloquesAmarillosHardPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.1925, -0.0375), SIMD3<Float>(-0.1125, 0.1175, 0.1125), SIMD3<Float>(0.1875, 0.0425, 0.1875), SIMD3<Float>(0.2625, 0.0425, 0.2625)]
var arraySolucionesBloquesVerdesHardPrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.1925, 0.0375), SIMD3<Float>(0.1125, 0.1175, -0.1125), SIMD3<Float>(-0.1875, 0.0425, -0.1875), SIMD3<Float>(-0.2625, 0.0425, -0.2625)]
var arrayPrototipoHard2 = [arraySolucionesBloquesAzulesHardPrototipo2, arraySolucionesBloquesRojosHardPrototipo2, arraySolucionesBloquesAmarillosHardPrototipo2, arraySolucionesBloquesVerdesHardPrototipo2]

var arraySolucionesBloquesAzulesHardPrototipo3: Array<SIMD3<Float>> = []
var arraySolucionesBloquesRojosHardPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.1125, 0.0425, -0.1125), SIMD3<Float>(0.1125, 0.1175, -0.1125), SIMD3<Float>(0.1125, 0.0425, 0.0375), SIMD3<Float>(0.1125, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.0425, -0.1125), SIMD3<Float>(-0.1125, 0.1175, -0.1125), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.1125, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(0.1125, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375)]
var arraySolucionesBloquesAmarillosHardPrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.1875), SIMD3<Float>(0.0375, 0.0425, -0.1875), SIMD3<Float>(-0.0375, 0.1175, -0.1875), SIMD3<Float>(0.0375, 0.1175, -0.1875), SIMD3<Float>(-0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.1175, -0.0375), SIMD3<Float>(0.1875, 0.0425, -0.0375), SIMD3<Float>(0.1875, 0.1175, -0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.1125), SIMD3<Float>(0.0375, 0.0425, 0.1125), SIMD3<Float>(-0.0375, 0.1175, 0.1125), SIMD3<Float>(0.0375, 0.1175, 0.1125), SIMD3<Float>(0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.0375)]
var arraySolucionesBloquesVerdesHardPrototipo3: Array<SIMD3<Float>> = []
var arrayPrototipoHard3 = [arraySolucionesBloquesAzulesHardPrototipo3, arraySolucionesBloquesRojosHardPrototipo3, arraySolucionesBloquesAmarillosHardPrototipo3, arraySolucionesBloquesVerdesHardPrototipo3]

var arraySolucionesBloquesAzulesHardPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.1125, 0.1175, -0.1125), SIMD3<Float>(0.1125, 0.1175, 0.1125), SIMD3<Float>(0.1875, 0.1175, -0.1875), SIMD3<Float>(-0.1875, 0.1175, 0.1875), SIMD3<Float>(-0.2625, 0.1925, 0.2625), SIMD3<Float>(-0.1875, 0.1925, 0.2625), SIMD3<Float>(-0.1125, 0.1925, 0.2625), SIMD3<Float>(-0.0375, 0.1925, 0.2625), SIMD3<Float>(0.0375, 0.1925, -0.2625), SIMD3<Float>(0.1125, 0.1925, -0.2625), SIMD3<Float>(0.1875, 0.1925, -0.2625), SIMD3<Float>(0.2625, 0.1925, -0.2625)]
var arraySolucionesBloquesRojosHardPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.1125, 0.1925, -0.2625), SIMD3<Float>(-0.1875, 0.1925, -0.2625), SIMD3<Float>(-0.2625, 0.1925, -0.2625), SIMD3<Float>(-0.1875, 0.1175, -0.1875), SIMD3<Float>(0.1875, 0.1175, 0.1875), SIMD3<Float>(0.1125, 0.1175, -0.1125), SIMD3<Float>(-0.1125, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.1925, -0.2625), SIMD3<Float>(0.0375, 0.1925, 0.2625), SIMD3<Float>(0.1125, 0.1925, 0.2625), SIMD3<Float>(0.1875, 0.1925, 0.2625), SIMD3<Float>(0.2625, 0.1925, 0.2625)]
var arraySolucionesBloquesAmarillosHardPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375)]
var arraySolucionesBloquesVerdesHardPrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375)]
var arrayPrototipoHard4 = [arraySolucionesBloquesAzulesHardPrototipo4, arraySolucionesBloquesRojosHardPrototipo4, arraySolucionesBloquesAmarillosHardPrototipo4, arraySolucionesBloquesVerdesHardPrototipo4]

var arraySolucionesBloquesAzulesHardPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.1925, -0.0375), SIMD3<Float>(-0.0375, 0.1925, 0.0375), SIMD3<Float>(0.1875, 0.0425, -0.1875), SIMD3<Float>(0.1875, 0.0425, -0.1125), SIMD3<Float>(0.2625, 0.0425, -0.1125), SIMD3<Float>(-0.2625, 0.0425, 0.1125), SIMD3<Float>(-0.1875, 0.0425, 0.1125), SIMD3<Float>(-0.1875, 0.0425, 0.1875)]
var arraySolucionesBloquesRojosHardPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, 0.1125), SIMD3<Float>(0.0375, 0.0425, 0.1125), SIMD3<Float>(0.1125, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.0425, -0.0375), SIMD3<Float>(0.1125, 0.0425, -0.2625), SIMD3<Float>(-0.1125, 0.0425, -0.2625)]
var arraySolucionesBloquesAmarillosHardPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.1125), SIMD3<Float>(0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.2625), SIMD3<Float>(0.1125, 0.0425, 0.2625)]
var arraySolucionesBloquesVerdesHardPrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.1925, 0.0375), SIMD3<Float>(-0.0375, 0.1925, -0.0375), SIMD3<Float>(0.2625, 0.0425, 0.1125), SIMD3<Float>(0.1875, 0.0425, 0.1125), SIMD3<Float>(0.1875, 0.0425, 0.1875), SIMD3<Float>(-0.1875, 0.0425, -0.1875), SIMD3<Float>(-0.1875, 0.0425, -0.1125), SIMD3<Float>(-0.2625, 0.0425, -0.1125)]
var arrayPrototipoHard5 = [arraySolucionesBloquesAzulesHardPrototipo5, arraySolucionesBloquesRojosHardPrototipo5, arraySolucionesBloquesAmarillosHardPrototipo5, arraySolucionesBloquesVerdesHardPrototipo5]

var arrayPrototiposHardTotales = [arrayPrototipoHard1, arrayPrototipoHard2, arrayPrototipoHard3, arrayPrototipoHard4, arrayPrototipoHard5]


// Insane
var arraySolucionesBloquesAzulesInsanePrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.2625), SIMD3<Float>(-0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.1875), SIMD3<Float>(-0.0375, 0.0425, -0.1875), SIMD3<Float>(0.0375, 0.0425, 0.0375), SIMD3<Float>(0.1125, 0.0425, 0.2625), SIMD3<Float>(0.1875, 0.0425, -0.1125), SIMD3<Float>(0.2625, 0.0425, 0.1125)]
var arraySolucionesBloquesRojosInsanePrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, 0.1875), SIMD3<Float>(-0.1875, 0.0425, -0.1875), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, -0.1125), SIMD3<Float>(0.1125, 0.0425, 0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.2625), SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(0.1875, 0.0425, -0.2625)]
var arraySolucionesBloquesAmarillosInsanePrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.1125), SIMD3<Float>(-0.1875, 0.0425, 0.1125), SIMD3<Float>(-0.1125, 0.0425, -0.2625), SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.0425, 0.1875), SIMD3<Float>(0.1125, 0.0425, -0.1875), SIMD3<Float>(0.1875, 0.0425, 0.0375), SIMD3<Float>(0.2625, 0.0425, 0.2625)]
var arraySolucionesBloquesVerdesInsanePrototipo1: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.2625), SIMD3<Float>(-0.1125, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.1125), SIMD3<Float>(0.0375, 0.0425, -0.2625), SIMD3<Float>(0.1125, 0.0425, -0.0375), SIMD3<Float>(0.1875, 0.0425, 0.1875), SIMD3<Float>(0.2625, 0.0425, -0.1875)]
var arrayPrototipoInsane1 = [arraySolucionesBloquesAzulesInsanePrototipo1, arraySolucionesBloquesRojosInsanePrototipo1, arraySolucionesBloquesAmarillosInsanePrototipo1, arraySolucionesBloquesVerdesInsanePrototipo1]

var arraySolucionesBloquesAzulesInsanePrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.1175, -0.0375), SIMD3<Float>(-0.0375, 0.1175, 0.2625), SIMD3<Float>(0.2625, 0.1175, -0.2625)]
var arraySolucionesBloquesRojosInsanePrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.0425, -0.1125), SIMD3<Float>(0.1125, 0.0425, -0.1875)]
var arraySolucionesBloquesAmarillosInsanePrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(-0.0375, 0.1175, 0.0375), SIMD3<Float>(-0.0375, 0.1925, 0.0375), SIMD3<Float>(-0.0375, 0.2675, 0.0375), SIMD3<Float>(0.1125, 0.2675, 0.1125)]
var arraySolucionesBloquesVerdesInsanePrototipo2: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.1175, -0.0375), SIMD3<Float>(0.0375, 0.1925, -0.0375), SIMD3<Float>(-0.2625, 0.1925, 0.1125)]
var arrayPrototipoInsane2 = [arraySolucionesBloquesAzulesInsanePrototipo2, arraySolucionesBloquesRojosInsanePrototipo2, arraySolucionesBloquesAmarillosInsanePrototipo2, arraySolucionesBloquesVerdesInsanePrototipo2]

var arraySolucionesBloquesAzulesInsanePrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.1175, 0.0375), SIMD3<Float>(0.1125, 0.0425, 0.0375), SIMD3<Float>(0.1125, 0.1175, 0.0375), SIMD3<Float>(0.1125, 0.1925, 0.0375), SIMD3<Float>(0.1875, 0.0425, 0.0375), SIMD3<Float>(0.1875, 0.1175, 0.0375), SIMD3<Float>(0.2625, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, 0.1125), SIMD3<Float>(0.0375, 0.1175, 0.1125), SIMD3<Float>(0.0375, 0.1925, 0.1125), SIMD3<Float>(0.0375, 0.0425, 0.1875), SIMD3<Float>(0.0375, 0.1175, 0.1875), SIMD3<Float>(0.0375, 0.0425, 0.2625)]
var arraySolucionesBloquesRojosInsanePrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, 0.0375), SIMD3<Float>(-0.2625, 0.1175, 0.0375), SIMD3<Float>(-0.1875, 0.0425, 0.0375), SIMD3<Float>(-0.1875, 0.1175, 0.0375), SIMD3<Float>(-0.1875, 0.1925, 0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.1125, 0.1175, 0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(0.1125, 0.0425, -0.0375), SIMD3<Float>(0.1125, 0.1175, -0.0375), SIMD3<Float>(0.1875, 0.0425, -0.0375), SIMD3<Float>(0.1875, 0.1175, -0.0375), SIMD3<Float>(0.1875, 0.1925, -0.0375), SIMD3<Float>(0.2625, 0.0425, -0.0375), SIMD3<Float>(0.2625, 0.1175, -0.0375)]
var arraySolucionesBloquesAmarillosInsanePrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.2625), SIMD3<Float>(-0.0375, 0.0425, -0.1875), SIMD3<Float>(-0.0375, 0.1175, -0.1875), SIMD3<Float>(-0.0375, 0.0425, -0.1125), SIMD3<Float>(-0.0375, 0.1175, -0.1125), SIMD3<Float>(-0.0375, 0.1925, -0.1125), SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.1175, -0.0375), SIMD3<Float>(-0.1125, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.1175, -0.0375), SIMD3<Float>(-0.1125, 0.1925, -0.0375), SIMD3<Float>(-0.1875, 0.0425, -0.0375), SIMD3<Float>(-0.1875, 0.1175, -0.0375), SIMD3<Float>(-0.2625, 0.0425, -0.0375)]
var arraySolucionesBloquesVerdesInsanePrototipo3: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, -0.1125), SIMD3<Float>(0.0375, 0.1175, -0.1125), SIMD3<Float>(0.0375, 0.0425, -0.1875), SIMD3<Float>(0.0375, 0.1175, -0.1875), SIMD3<Float>(0.0375, 0.1925, -0.1875), SIMD3<Float>(0.0375, 0.0425, -0.2625), SIMD3<Float>(0.0375, 0.1175, -0.2625), SIMD3<Float>(-0.0375, 0.0425, 0.1125), SIMD3<Float>(-0.0375, 0.1175, 0.1125), SIMD3<Float>(-0.0375, 0.0425, 0.1875), SIMD3<Float>(-0.0375, 0.1175, 0.1875), SIMD3<Float>(-0.0375, 0.1925, 0.1875), SIMD3<Float>(-0.0375, 0.0425, 0.2625), SIMD3<Float>(-0.0375, 0.1175, 0.2625)]
var arrayPrototipoInsane3 = [arraySolucionesBloquesAzulesInsanePrototipo3, arraySolucionesBloquesRojosInsanePrototipo3, arraySolucionesBloquesAmarillosInsanePrototipo3, arraySolucionesBloquesVerdesInsanePrototipo3]

var arraySolucionesBloquesAzulesInsanePrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375)]
var arraySolucionesBloquesRojosInsanePrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.3425, 0.0375), SIMD3<Float>(-0.0375, 0.3425, -0.0375), SIMD3<Float>(0.0375, 0.3425, 0.0375), SIMD3<Float>(0.0375, 0.3425, -0.0375)]
var arraySolucionesBloquesAmarillosInsanePrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(-0.2625, 0.0425, -0.2625), SIMD3<Float>(-0.2625, 0.1175, -0.1875), SIMD3<Float>(-0.2625, 0.1175, -0.1125), SIMD3<Float>(-0.2625, 0.1925, -0.0375), SIMD3<Float>(-0.1875, 0.1925, -0.0375), SIMD3<Float>(-0.1875, 0.1925, 0.0375), SIMD3<Float>(-0.1875, 0.2675, 0.1125), SIMD3<Float>(-0.1125, 0.2675, 0.1125), SIMD3<Float>(-0.0375, 0.2675, 0.1125), SIMD3<Float>(0.0375, 0.2675, 0.1125), SIMD3<Float>(0.1125, 0.2675, -0.0375), SIMD3<Float>(0.1125, 0.2675, 0.0375), SIMD3<Float>(0.1125, 0.2675, 0.1125)]
var arraySolucionesBloquesVerdesInsanePrototipo4: Array<SIMD3<Float>> = [SIMD3<Float>(0.2625, 0.0425, 0.2625), SIMD3<Float>(0.2625, 0.1175, 0.1875), SIMD3<Float>(0.2625, 0.1175, 0.1125), SIMD3<Float>(0.2625, 0.1925, 0.0375), SIMD3<Float>(0.1875, 0.1925, 0.0375), SIMD3<Float>(0.1875, 0.1925, -0.0375), SIMD3<Float>(0.1875, 0.2675, -0.1125), SIMD3<Float>(0.1125, 0.2675, -0.1125), SIMD3<Float>(0.0375, 0.2675, -0.1125), SIMD3<Float>(-0.0375, 0.2675, -0.1125), SIMD3<Float>(-0.1125, 0.2675, 0.0375), SIMD3<Float>(-0.1125, 0.2675, -0.0375), SIMD3<Float>(-0.1125, 0.2675, -0.1125)]
var arrayPrototipoInsane4 = [arraySolucionesBloquesAzulesInsanePrototipo4, arraySolucionesBloquesRojosInsanePrototipo4, arraySolucionesBloquesAmarillosInsanePrototipo4, arraySolucionesBloquesVerdesInsanePrototipo4]

var arraySolucionesBloquesAzulesInsanePrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.1925, -0.0375), SIMD3<Float>(-0.0375, 0.2675, -0.0375), SIMD3<Float>(-0.0375, 0.3425, -0.0375), SIMD3<Float>(0.0375, 0.2675, -0.0375), SIMD3<Float>(0.1125, 0.0425, -0.0375), SIMD3<Float>(-0.1125, 0.2675, 0.0375), SIMD3<Float>(-0.1125, 0.3425, 0.0375), SIMD3<Float>(-0.1125, 0.4175, 0.0375), SIMD3<Float>(-0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.0425, 0.0375), SIMD3<Float>(0.0375, 0.1175, 0.0375), SIMD3<Float>(0.0375, 0.1925, 0.0375), SIMD3<Float>(0.0375, 0.2675, 0.0375)]
var arraySolucionesBloquesRojosInsanePrototipo5: Array<SIMD3<Float>> = []
var arraySolucionesBloquesAmarillosInsanePrototipo5: Array<SIMD3<Float>> = []
var arraySolucionesBloquesVerdesInsanePrototipo5: Array<SIMD3<Float>> = [SIMD3<Float>(-0.0375, 0.0425, -0.0375), SIMD3<Float>(-0.0375, 0.1175, -0.0375), SIMD3<Float>(0.0375, 0.0425, -0.0375), SIMD3<Float>(0.0375, 0.1175, -0.0375), SIMD3<Float>(0.0375, 0.1925, -0.0375), SIMD3<Float>(0.1125, 0.1175, -0.0375), SIMD3<Float>(0.1125, 0.1925, -0.0375), SIMD3<Float>(0.1125, 0.2675, -0.0375), SIMD3<Float>(0.1125, 0.3425, -0.0375), SIMD3<Float>(0.1125, 0.4175, -0.0375), SIMD3<Float>(-0.1125, 0.0425, 0.0375), SIMD3<Float>(-0.1125, 0.1175, 0.0375), SIMD3<Float>(-0.1125, 0.1925, 0.0375), SIMD3<Float>(-0.0375, 0.1175, 0.0375), SIMD3<Float>(-0.0375, 0.1925, 0.0375), SIMD3<Float>(-0.0375, 0.2675, 0.0375), SIMD3<Float>(0.0375, 0.3425, 0.0375)]
var arrayPrototipoInsane5 = [arraySolucionesBloquesAzulesInsanePrototipo5, arraySolucionesBloquesRojosInsanePrototipo5, arraySolucionesBloquesAmarillosInsanePrototipo5, arraySolucionesBloquesVerdesInsanePrototipo5]

var arrayPrototiposInsaneTotales = [arrayPrototipoInsane1, arrayPrototipoInsane2, arrayPrototipoInsane3, arrayPrototipoInsane4, arrayPrototipoInsane5]



func generarPrototipoRandom(prototipo1: Array<Array<SIMD3<Float>>>, prototipo2: Array<Array<SIMD3<Float>>>) -> Array<Array<SIMD3<Float>>> {
    
    var prototipoModificado = prototipo1
    
    let numeroRandomDeBloquesCambiados = generarNumeroRandom(rango: 1...3)
    
    for _ in 0...numeroRandomDeBloquesCambiados {
        var colorBloque1 = generarNumeroRandom(rango: 0...3)
        var arrayColorSeleccionado1 = prototipo1[colorBloque1]
        
        while arrayColorSeleccionado1.count == 0 {
            colorBloque1 = generarNumeroRandom(rango: 0...3)
            arrayColorSeleccionado1 = prototipo1[colorBloque1]
        }
        
        let numeroBloque1 = generarNumeroRandom(rango: 0...arrayColorSeleccionado1.count - 1)
        
        prototipoModificado[colorBloque1].remove(at: numeroBloque1)
    }
    
    for _ in 0...numeroRandomDeBloquesCambiados {
        var colorBloque2 = generarNumeroRandom(rango: 0...3)
        var arrayColorSeleccionado2 = prototipo2[colorBloque2]
        
        while arrayColorSeleccionado2.count == 0 {
            colorBloque2 = generarNumeroRandom(rango: 0...3)
            arrayColorSeleccionado2 = prototipo2[colorBloque2]
        }
        
        let numeroBloque2 = generarNumeroRandom(rango: 0...arrayColorSeleccionado2.count - 1)
        
        prototipoModificado[colorBloque2].append(prototipo2[colorBloque2][numeroBloque2])
    }
    
    return prototipoModificado
}

func generarNumeroRandom(rango: ClosedRange<Int>) -> Int {
    let numeroRandom = Int.random(in: rango)
    return numeroRandom
}



/*
 
 NUEVOS POSIBLES PROTOTIPOS:
 
 - Easy:
    var arraySolucionesBloquesAzulesEasyPrototipo6: Array<SIMD3<Float>> = []
    var arraySolucionesBloquesRojosEasyPrototipo6: Array<SIMD3<Float>> = []
    var arraySolucionesBloquesAmarillosEasyPrototipo6: Array<SIMD3<Float>> = []
    var arraySolucionesBloquesVerdesEasyPrototipo6: Array<SIMD3<Float>> = []
    var arrayPrototipoEasy6 = [arraySolucionesBloquesAzulesEasyPrototipo6, arraySolucionesBloquesRojosEasyPrototipo6, arraySolucionesBloquesAmarillosEasyPrototipo6, arraySolucionesBloquesVerdesEasyPrototipo6]
    
    
    
    
    
    
 - Medium:
    
    
    
    
    
    
    
 - Hard:
     
    
    
    
    
    
    
    
    
 - Insane:
    
    
    
    
    
 */
