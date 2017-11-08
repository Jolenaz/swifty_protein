//
//  AtomeNode.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/8/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import SceneKit

class AtomeNode: SCNNode {

    var atome : Atome?
    
    init(geometry : SCNGeometry) {
        super.init()
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
