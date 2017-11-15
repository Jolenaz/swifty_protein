//
//  LogViewController.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/8/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

// Pour download PDB : https://files.rcsb.org/ligands/download/011_ideal.pdb

import UIKit
import LocalAuthentication

class LogViewController: UIViewController {

    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var touchIdButton: UIButton!
    
    @IBAction func passCode(_ sender: UIButton) {
        let context : LAContext = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthentication , localizedReason: "PLeaze authentify"){
            (success, error) in
            if success{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goList", sender: nil)
                }
            }
            else{
                print ("error")
            }
        }
    }
    @IBAction func log(_ sender: UIButton) {
        
        let context : LAContext = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "PLeaze authentify"){
            (success, error) in
            if success{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goList", sender: nil)
                }
            }
            else{
                print ("error")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTouchId()

        // Do any additional setup after loading the view.
    }

    func showTouchId(){
        self.orLabel.isHidden = true
        self.touchIdButton.isHidden = true
        let context : LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            self.orLabel.isHidden = false
            self.touchIdButton.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
