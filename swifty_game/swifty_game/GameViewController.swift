//
//  GameViewController.swift
//  swifty_game
//
//  Created by Jonas BELLESSA on 10/30/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    
    var gameView : SCNView?
    var gameScene : SCNScene?
    var cameraNode : SCNNode?
    var targetCreationTime : TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        
        createEau()
    }
    
    func initView(){
        gameView = self.view as? SCNView
        gameView?.allowsCameraControl = true
        gameView?.autoenablesDefaultLighting = true
    }
    
    func initScene(){
        gameScene = SCNScene()
        gameView?.scene = gameScene
        
        gameView?.isPlaying = true
    }
    
    func initCamera(){
        cameraNode = SCNNode()
        cameraNode?.camera = SCNCamera()
        
        cameraNode?.position = SCNVector3(x:0, y:5, z:10)
    }
    
    
    func createEau(){
        let ox : SCNGeometry = SCNSphere(radius : 2)
        ox.materials.first?.diffuse.contents = UIColor.red
        let oxNode = SCNNode(geometry: ox)
        gameScene?.rootNode.addChildNode(oxNode)
        
        let hyd : SCNGeometry = SCNSphere(radius: 1)
        hyd.materials.first?.diffuse.contents = UIColor.white
        
        let hydNode1 = SCNNode(geometry: hyd)
        hydNode1.position = SCNVector3(x:3,y:3,z:0)
        gameScene?.rootNode.addChildNode(hydNode1)
        
        let hydNode2 = SCNNode(geometry: hyd)
        hydNode2.position = SCNVector3(x:-3,y:3,z:0)
        gameScene?.rootNode.addChildNode(hydNode2)
        
        let source = SCNGeometrySource(vertices: [SCNVector3(x:0, y:0, z:0), SCNVector3(x:3, y:3, z:0)])
        let indices  : [Int32] = [0,1]
        
        let elemnt = SCNGeometryElement(indices: indices, primitiveType: .line)
        //let geo = SCNGeometry(sources: [source], elements: [elemnt])
        let geo = SCNCylinder(radius: <#T##CGFloat#>, height: <#T##CGFloat#>)
        geo.materials.first?.diffuse.contents = UIColor.white
        

        
        let geoNode = SCNNode(geometry: geo)
        gameScene?.rootNode.addChildNode(geoNode)
        
        
        
        
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
