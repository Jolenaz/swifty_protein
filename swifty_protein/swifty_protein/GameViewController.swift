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
import Social

class GameViewController: UIViewController {

    var renderManager : RenderManager?
    
    @IBOutlet weak var rotationSwitch: UISwitch!
    @IBAction func rotationButton(_ sender: UISwitch) {
        self.renderManager?.rotation = !(self.renderManager?.rotation ?? false)
    }
    
    
    let parser = ParserManager()
    let popup = PopUpManager()
    
    @IBOutlet weak var displayStyle: UISegmentedControl!
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        
        let gameImage = self.gameView.renderToImage()
        
        let alert = UIAlertController(title: "Share", message: "Share this picture", preferredStyle: .actionSheet)
        
        let actionOne = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                
                post.setInitialText("the text")
                post.add(gameImage)
                
                self.present(post, animated: true, completion: nil)
            } else{ print ("yout not connected to facebook"); self.popup.displayPopup(code: 1) }
        }
        
        let actionTwo = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                
                post.setInitialText("the text")
                post.add(gameImage)
                
                self.present(post, animated: true, completion: nil)
            } else{ print ("yout not connected to twitter"); self.popup.displayPopup(code: 1) }
        }
        
        let actionTree = UIAlertAction(title: "Share on Linkedin", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeLinkedIn){
                let post = SLComposeViewController(forServiceType: SLServiceTypeLinkedIn)!
                
                post.setInitialText("the text")
                post.add(gameImage)
                
                self.present(post, animated: true, completion: nil)
            } else{ print ("yout not connected to Linkedin"); self.popup.displayPopup(code: 1) }
        }
        
        let actionFour = UIAlertAction(title: "Save on Library", style: .default) { (action) in
                UIImageWriteToSavedPhotosAlbum(gameImage, nil, nil, nil)
        }
        
        let actionFive = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.removeFromParentViewController()
        }
        
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionTree)
        alert.addAction(actionFour)
        alert.addAction(actionFive)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func infoButton(_ sender: UIButton) {
            performSegue(withIdentifier: "goInfo", sender: "")
    }
    
    
    @IBAction func displayStyleButton(_ sender: UISegmentedControl) {
        self.renderManager?.print_ball(withH, displayStyle.selectedSegmentIndex)
    }
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var ligandName : String?{
        didSet{
            print(self.ligandName ?? "a girl as no name")
            self.navTitle.title = ligandName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goInfo"{
            if let dest = segue.destination as? InfoViewController{
                dest.ligandName = self.ligandName
            }
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       self.renderManager?.gameView?.pointOfView = nil
        
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
        self.rotationSwitch.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

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

public extension UIView {
    public func renderToImage(_ afterScreenUpdates: Bool = false) -> UIImage {
        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.opaque = isOpaque
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: rendererFormat)
        
        let snapshotImage = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        }
        return snapshotImage
    }
}

