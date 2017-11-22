//
//  PopUpManager.swift
//  swifty_protein
//
//  Created by Emmanuelle TERMEAU on 11/22/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class PopUpManager: UIAlertController {

    
    func displayPopup (code : Int) {
        
        let title = "Oups !"
        var message : String?
        
        if code == 0 {
            message = "An error has occurred"
        }
        if code == 1 {
            message = "You are not connected"
        }
//        if code == 2 {
//            message = "Authentication error, try again pls"
//        }
        
        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(popup, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
