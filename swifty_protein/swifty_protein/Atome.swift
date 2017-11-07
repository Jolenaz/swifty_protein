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

    var pos : SCNVector3?
    
    init(pos : SCNVector3) {
        self.pos = pos
    }
    
    override init() {
        self.pos = SCNVector3()
    }
    
}
