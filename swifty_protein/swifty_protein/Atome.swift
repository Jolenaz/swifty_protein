//
//  Atome.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/7/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import SceneKit



class Atome: NSObject {

    enum kind : String{
        case C
        case H
        case O
        case N
        case S
        case P
        case Cl
        case Other
    }
    
    var name : String
    var pos : SCNVector3
    var type : kind
    
    init(pos : SCNVector3, type : kind, name : String) {
        self.pos = pos
        self.type = type
        self.name = name
    }
    
    init(pos : SCNVector3, type : kind) {
        self.pos = pos
        self.type = type
        self.name = ""
    }
    
    init(pos : SCNVector3) {
        self.pos = pos
        self.type = .Other
        self.name = ""
    }
    
    override init() {
        self.pos = SCNVector3Zero
        self.type = .Other
        self.name = ""
    }
    
}
