//
//  ParserManager.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/7/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//
// Pour download PDB : https://files.rcsb.org/ligands/view/011_ideal.pdb

import UIKit
import Foundation
import Alamofire

//"^((ATOM)|(CONECT))"


class ParserManager: NSObject {

    var dataManager : DataManager
    
    func regexMatch (string : String, re : String) -> String {
        
        var result : String?
        
        do {
            let regex = try NSRegularExpression(pattern: re)
            let matches = regex.matches(in: string, range: NSRange(location: 0, length: string.characters.count))
            for match in matches {
                result = (string as NSString).substring(with: match.rangeAt(1))
            }
        } catch {
            print ("error")
            result = "error"
//            add popUp error
        }
        return result!
    }
    
    
    
    func getLigand (nameSearchLigand : String) {
        let destination : DownloadRequest.DownloadFileDestination = { _, _ in
            let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = docURL.appendingPathComponent("\(nameSearchLigand)_ideal.pdb")
            return (fileUrl, [.removePreviousFile])
        }
        
        Alamofire.download("https://files.rcsb.org/ligands/download/\(nameSearchLigand)_ideal.pdb", to: destination).responseData { response in
            if let destURL = response.destinationURL {
                do {
                    let infoLigand = try String(contentsOf: destURL, encoding: .utf8)
                    let infoTxt = infoLigand.components(separatedBy: .newlines)
                    for elem in infoTxt {
                        let typeObj = self.regexMatch(string: elem, re: "^((ATOM)|(CONECT))")
                        if typeObj == "ATOM" {
                            let atom : Atome
//                        } else if typeObj == "CONECT" {
//                            
//                        } else {
//                            print ("error")
                        }
//
                    }
                }
                catch {
                    print("error")
                }
            }
        }
    }
    
    override init() {
        dataManager = DataManager()
    }
    
}
