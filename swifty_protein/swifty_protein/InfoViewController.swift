//
//  InfoViewController.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/21/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var ligandName : String?{
        didSet{
            print ("ok desu")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.nameLabel.text = "name"
        self.formulaLabel.text = "formula"
        self.typeLabel.text = "type"
        self.weightLabel.text = "weight"
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
