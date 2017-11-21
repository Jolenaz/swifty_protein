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
    
    var ligandName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.nameLabel.text = "name"
        self.formulaLabel.text = "formula"
        self.typeLabel.text = "type"
        self.weightLabel.text = "weight"
        getInfo(nameLigand:  self.ligandName ?? "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getInfo(nameLigand: String) {
        Alamofire.request("https://files.rcsb.org/ligands/view/\(nameLigand).cif").response { response in
//            print("Request: \(String(describing: response.request))")
//            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let textData = String(data: data, encoding: .utf8) {
                let infoTxt = textData.components(separatedBy: .newlines)
                for elem in infoTxt {
//                    let name  = self.infoByElem(str: elem, elem: "chem_comp.name")
//                    print (name)
//                    self.formulaLabel.text = self.infoByElem(str: elem, elem: "chem_comp.formula")
//                    self.typeLabel.text = self.infoByElem(str: elem, elem: "chem_comp.type")
//                    self.weightLabel.text = self.infoByElem(str: elem, elem: "chem_comp.formula_weight")
                    let nameTmp = elem.range(of: "chem_comp.name")
                    if nameTmp != nil {
                        let nameArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                        self.nameLabel.text = nameArr.last
                    }
                    let formulaTmp = elem.range(of: "chem_comp.formula")
                    if formulaTmp != nil {
                        let formArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                        self.formulaLabel.text = formArr.last
                    }
                    let typeTmp = elem.range(of: "chem_comp.type")
                    if typeTmp != nil {
                        let typeArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                        self.typeLabel.text = typeArr.last
                    }
                    let weightTmp = elem.range(of: "chem_comp.formula_weight")
                    if weightTmp != nil {
                        let weightArr = elem.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines)
                        self.weightLabel.text = weightArr.last
                    }
                }
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
