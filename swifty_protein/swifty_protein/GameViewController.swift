//
//  GameViewController.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/7/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var renderManager : RenderManager?
    var dataManager : DataManager?
    @IBOutlet weak var gameView: SCNView!
    
    @IBAction func testButton(_ sender: UIButton) {
        self.renderManager?.print_ball()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.renderManager = RenderManager(view: self.gameView)
        self.dataManager = DataManager()
        self.renderManager?.dataManager = self.dataManager
        self.renderManager?.initWorld()
        
        let a1 = Atome(pos: SCNVector3())
        let a2 = Atome(pos: SCNVector3(x:2, y:2, z:0))
        
        self.dataManager?.addAtome(newAtome: a1, ind: 1)
        self.dataManager?.addAtome(newAtome: a2, ind: 2)
        
        self.dataManager?.addLiaison(newLiaison: (1,2))
        self.dataManager?.addLiaison(newLiaison: (1,3))
        self.dataManager?.addLiaison(newLiaison: (1,2))
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
