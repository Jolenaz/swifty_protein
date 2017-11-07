//
//  RenderManager.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/7/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import SceneKit

class RenderManager: NSObject {

    var gameView : SCNView?
    
    init(view : SCNView) {
        self.gameView = view
    }
    
    
}
