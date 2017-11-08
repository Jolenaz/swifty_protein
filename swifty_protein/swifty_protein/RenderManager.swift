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

    let AtomeColor = [
        "C" : UIColor(rgb : 0x202020),
        "H" : UIColor(rgb : 0xffffff),
        "O" : UIColor(rgb : 0xee2010),
        "N" : UIColor(rgb : 0x2060ff),
        "S" : UIColor(rgb : 0xffff00),
        "P" : UIColor(rgb : 0x8020ff),
        "Cl" : UIColor(rgb : 0x00bb00),
        "Other" : UIColor(rgb : 0xff1493)]
    
    var dataManager : DataManager?
    
    var gameView : SCNView?
    var gameScene : SCNScene?
    var cameraNode : SCNNode?
    
    var selectedNode : SCNNode
    
    init(view : SCNView) {
        self.gameView = view
        let geo = SCNSphere(radius: 1.2)
        geo.materials.first?.diffuse.contents = UIColor.blue
        self.selectedNode = SCNNode(geometry : geo)
        self.selectedNode.opacity = 0.2
    }
    
    func initWorld(){
        gameView?.allowsCameraControl = true
        gameView?.autoenablesDefaultLighting = true
        gameScene = SCNScene()
        gameView?.scene = gameScene
        gameView?.isPlaying = true
        cameraNode = SCNNode()
        cameraNode?.camera = SCNCamera()
        cameraNode?.position = SCNVector3(x: 0, y:5, z: 30)
        gameScene?.rootNode.addChildNode(cameraNode!)
    }
    
    func print_ball(){
        for at in (dataManager?.atomes)!{
            self.displayAtome(atome: at.value)
        }
        for li in (dataManager?.liaisons)!{
            self.displayLiaison(atomes: ((dataManager?.atomes[li.0])!,  (dataManager?.atomes[li.1])!))
        }
    }
    
    func displayAtome(atome : Atome){

        let geo = SCNSphere(radius: 1)
        geo.materials.first?.diffuse.contents = self.AtomeColor[atome.type.rawValue] ?? self.AtomeColor["Other"]
        let geoNode = AtomeNode(geometry: geo)
        geoNode.atome = atome
        
        geoNode.position = atome.pos
        
        gameScene?.rootNode.addChildNode(geoNode)
        
    }
    
    func displayLiaison(atomes : (Atome,Atome)){
        
        let objectif = atomes.0.pos - atomes.1.pos
        
        let hg = objectif.magnitude()
        if hg == 0 {
            return
        }
        
        let mid = (atomes.0.pos + atomes.1.pos) / 2.0
        
        let geo = SCNCylinder(radius: 0.2, height: CGFloat(hg))
        
        geo.materials.first?.diffuse.contents = UIColor.black
        
        let geoNode = SCNNode(geometry: geo)
        geoNode.position = mid
        
        
        let axis = SCNVector3.cross(SCNVector3(x: 0 , y : 1, z : 0), objectif).normalized()
        let angle = SCNVector3.angle(SCNVector3(x: 0 , y : 1, z : 0), objectif)
        
        if angle != nil, axis != nil{
            geoNode.rotation = SCNVector4(axis!, angle!)
        }
        
        gameScene?.rootNode.addChildNode(geoNode)
        
    }
    
    func highLightAtome (node : AtomeNode?){
        self.selectedNode.removeFromParentNode()
        if node == nil{
            return
        }
        self.selectedNode.position = node!.position
        self.gameScene?.rootNode.addChildNode(self.selectedNode)
        print("added")
        
        
    }
    
    private func clear_scene(){
        gameScene?.rootNode.enumerateChildNodes{
            (child,smt) in
            child.removeFromParentNode()
        }
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

