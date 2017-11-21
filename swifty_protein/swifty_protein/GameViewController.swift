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
    
    let parser = ParserManager()
    
    @IBOutlet weak var displayStyle: UISegmentedControl!
    
    @IBAction func displayStyleButton(_ sender: UISegmentedControl) {
        self.renderManager?.print_ball(withH, displayStyle.selectedSegmentIndex)
    }
    
    var ligandName : String?{
        didSet{
            print(self.ligandName ?? "a girl as no name")
            
        }
    }
    @IBOutlet weak var atomName: UILabel!
    
    var withH : Bool = true
    
    @IBOutlet weak var gameView: SCNView!
    
    @IBAction func testButton(_ sender: UIButton) {
        withH = !withH
        self.renderManager?.print_ball(withH, displayStyle.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.atomName.text = ""
        DataManager.atomes = [:]
        DataManager.liaisons = []
        self.renderManager = RenderManager(view: self.gameView)
        self.renderManager?.initWorld()
        self.parser.renderManager = self.renderManager
        self.parser.getLigand(nameSearchLigand: (self.ligandName ?? "a girl as no name"))

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.gameView)
        let hitList = self.gameView.hitTest(location, options: nil)
        
        if let hitObject = hitList.first{
            if let node = hitObject.node as? AtomeNode{
                self.renderManager?.highLightAtome(node: node)
                self.atomName.text = node.atome?.name
            }else{
                self.atomName.text = ""
                self.renderManager?.highLightAtome(node: nil)
            }
        }else{
            self.atomName.text = ""
            self.renderManager?.highLightAtome(node: nil)
        }
    }
    
    override var shouldAutorotate: Bool {
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
