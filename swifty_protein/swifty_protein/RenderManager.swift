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
    
    func print_ball(_ withHydrogene : Bool = true){
        clear_scene()
        for at in (dataManager?.atomes)!{
            if withHydrogene == false && at.value.type == .H{
                continue
            }
            self.displayAtome(atome: at.value)
        }
        for li in (dataManager?.liaisons)!{
            if withHydrogene == false && (dataManager?.atomes[li.0]?.type == .H || dataManager?.atomes[li.1]?.type == .H){
                continue
            }
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
        
        let mid0 = 3 * atomes.0.pos / 4 + atomes.1.pos / 4
        let geo0 = SCNCylinder(radius: 0.2, height: CGFloat(hg/2.0))
        geo0.materials.first?.diffuse.contents = self.AtomeColor[atomes.0.type.rawValue] ?? self.AtomeColor["Other"]
        let geoNode0 = SCNNode(geometry: geo0)
        geoNode0.position = mid0
        
        let mid1 = atomes.0.pos / 4 + 3 * atomes.1.pos / 4
        let geo1 = SCNCylinder(radius: 0.2, height: CGFloat(hg/2.0))
        geo1.materials.first?.diffuse.contents = self.AtomeColor[atomes.1.type.rawValue] ?? self.AtomeColor["Other"]
        let geoNode1 = SCNNode(geometry: geo1)
        geoNode1.position = mid1
        
        let axis = SCNVector3.cross(SCNVector3(x: 0 , y : 1, z : 0), objectif).normalized()
        let angle = SCNVector3.angle(SCNVector3(x: 0 , y : 1, z : 0), objectif)
        
        if angle != nil, axis != nil{
            geoNode0.rotation = SCNVector4(axis!, angle!)
            geoNode1.rotation = SCNVector4(axis!, angle!)
        }
        
        gameScene?.rootNode.addChildNode(geoNode0)
        gameScene?.rootNode.addChildNode(geoNode1)
        
    }
    
    func highLightAtome (node : AtomeNode?){
        self.selectedNode.removeFromParentNode()
        if node == nil{
            return
        }
        self.selectedNode.position = node!.position
        self.gameScene?.rootNode.addChildNode(self.selectedNode)
        
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

