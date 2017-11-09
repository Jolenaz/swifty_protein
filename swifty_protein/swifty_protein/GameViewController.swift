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
    
    var withH : Bool = true
    
    @IBOutlet weak var gameView: SCNView!
    
    @IBAction func testButton(_ sender: UIButton) {
        withH = !withH
        self.renderManager?.print_ball(withH)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.renderManager = RenderManager(view: self.gameView)
        self.dataManager = DataManager()
        self.renderManager?.dataManager = self.dataManager
        self.renderManager?.initWorld()
        
        let a1 = Atome(pos: SCNVector3(x:-2, y:0, z:-4), type : .C)
        let a2 = Atome(pos: SCNVector3(x:2, y:2, z:0), type : .H)
        
        self.dataManager?.addAtome(newAtome: a1, ind: 1)
        self.dataManager?.addAtome(newAtome: a2, ind: 2)
        
        self.dataManager?.addLiaison(newLiaison: (1,2))
        self.dataManager?.addLiaison(newLiaison: (1,3))
        self.dataManager?.addLiaison(newLiaison: (1,2))
        
        self.renderManager?.print_ball()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.gameView)
        let hitList = self.gameView.hitTest(location, options: nil)
        
        if let hitObject = hitList.first{
            if let node = hitObject.node as? AtomeNode{
                self.renderManager?.highLightAtome(node: node)
            }else{
                self.renderManager?.highLightAtome(node: nil)
            }
        }else{
            self.renderManager?.highLightAtome(node: nil)
        }
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
