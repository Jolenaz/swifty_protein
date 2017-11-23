//
//  InfoViewController.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/21/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//
//https://files.rcsb.org/ligands/view/011.cif

import UIKit
import Alamofire

class InfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var infoImage: UIImageView!
    
    
    var ligandName : String?
    let popup = PopUpManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let img : UIImage = UIImage(named: "backInfo.jpeg")!
        infoImage.image = img
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.nameLabel.text = ""
        self.formulaLabel.text = ""
        self.typeLabel.text = ""
        self.weightLabel.text = ""
        getInfo(nameLigand:  self.ligandName ?? "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInfo(nameLigand: String) {
        
        Alamofire.request("https://files.rcsb.org/ligands/view/\(nameLigand).cif").response { response in
            if response.error == nil {
                if let data = response.data, let textData = String(data: data, encoding: .utf8) {
                    let infoTxt = textData.components(separatedBy: .newlines)
                    for elem in infoTxt {
                        let nameTmp = elem.range(of: "chem_comp.name") // CHECK AVEC LE LIGAND 1SZ -> pb
                        if nameTmp != nil && self.nameLabel.text == "" {
                            let nameArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                            var name = nameArr.filter { $0 != ""}
                            name.remove(at: 0)
                            let joinName = name.joined(separator: " ")
                            self.nameLabel.text = joinName.replacingOccurrences(of: "\"", with: "")
                        }
                        let formulaTmp = elem.range(of: "chem_comp.formula")
                        if formulaTmp != nil && self.formulaLabel.text == "" {
                            let formArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                            var form = formArr.filter { $0 != ""}
                            form.remove(at: 0)
                            let joinForm = form.joined(separator: " ")
                            self.formulaLabel.text = joinForm.replacingOccurrences(of: "\"", with: "")
                        }
                        let typeTmp = elem.range(of: "chem_comp.type")
                        if typeTmp != nil && self.typeLabel.text == "" {
                            let typeArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                            var type = typeArr.filter { $0 != ""}
                            type.remove(at: 0)
                            let joinType = type.joined(separator: " ")
                            self.typeLabel.text = joinType.replacingOccurrences(of: "\"", with: "")
                        }
                        let weightTmp = elem.range(of: "chem_comp.formula_weight")
                        if weightTmp != nil && self.weightLabel.text == "" {
                            let weightArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                            self.weightLabel.text = weightArr.last
                        }
                    }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else {
                self.popup.displayPopup(code: 0)
            }
        }
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
