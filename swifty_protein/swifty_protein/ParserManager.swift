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
    var renderManager : RenderManager?
    let popup = PopUpManager()
    
    func regexMatchForLiaison (string : String, re : String) -> [(Int, Int)] {
        var liaison : (String, String) = ("0", "1")
        var liaisons : [(Int, Int)] = [((Int(liaison.0))!, (Int(liaison.1))!)]
        do {
            let regex = try NSRegularExpression(pattern: re)
            
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            let resultMatch = results.map { nsString.substring(with: $0.range)}
            if !resultMatch.isEmpty {
                let numOfMatch = resultMatch.count
                liaison.0 = resultMatch[0]
                var i : Int = 1
                while i < numOfMatch {
                    liaison.1 = resultMatch[i]
                    i += 1
                    if (liaison.1 != "") {
                        liaisons.append(((Int(liaison.0))!, (Int(liaison.1))!))
                    }
                }
            }
        } catch {
            print ("error")
            popup.displayPopup(code: 0)
            //add popUp error
        }
        return liaisons
    }
    
    func regexMatchForAtom (string : String, re : String, indexMatch: Int) -> String {
        var result : String?
        do {
            let regex = try NSRegularExpression(pattern: re)
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            let resultMatch = results.map { nsString.substring(with: $0.range)}
            if !resultMatch.isEmpty {
                result = resultMatch[indexMatch]
            }
        } catch {
            print ("error")
            result = "error"
            popup.displayPopup(code: 0)
//            add popUp error
        }
        return result ?? "error"
    }
    
    
    
    func getLigand (nameSearchLigand : String) {
        let destination : DownloadRequest.DownloadFileDestination = { _, _ in
            let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = docURL.appendingPathComponent("\(nameSearchLigand)_ideal.pdb")
            return (fileUrl, [.removePreviousFile])
        }
        
        Alamofire.download("https://files.rcsb.org/ligands/download/\(nameSearchLigand)_ideal.pdb", to: destination).responseData { response in
            if response.result.isSuccess {
                if let destURL = response.destinationURL {
                    do {
                        let infoLigand = try String(contentsOf: destURL, encoding: .utf8)
                        let infoTxt = infoLigand.components(separatedBy: .newlines)
                        for elem in infoTxt {
                            let typeObj = self.regexMatchForAtom(string: elem, re: "^((ATOM)|(CONECT))", indexMatch: 0)
                            if typeObj == "ATOM" {
                                //print ("create Atom ()")
                                let atom = Atome()
                                atom.name = self.regexMatchForAtom(string: elem, re: "[A-Z]+[\\d]*", indexMatch: 1)
                                atom.pos.x = Float(self.regexMatchForAtom(string: elem, re: "(-?\\d+\\.\\d{3})", indexMatch: 0))!
                                atom.pos.y = Float(self.regexMatchForAtom(string: elem, re: "(-?\\d+\\.\\d{3})", indexMatch: 1))!
                                atom.pos.z = Float(self.regexMatchForAtom(string: elem, re: "(-?\\d+\\.\\d{3})", indexMatch: 2))!
                                atom.type = Atome.kind(rawValue: self.regexMatchForAtom(string: elem, re: "\\w+$", indexMatch: 0)) ?? Atome.kind.Other
                                let indAtom = Int(self.regexMatchForAtom(string: elem, re: "(\\d{1,3})", indexMatch: 0))!
                                self.dataManager.addAtome(newAtome: atom, ind: indAtom)
                            } else if typeObj == "CONECT" {
                                let liaisons : [(Int, Int)]
                                liaisons = self.regexMatchForLiaison(string: elem, re: "(\\d{1,3})")
                                var i = 1
                                while i < liaisons.count {
                                    self.dataManager.addLiaison(newLiaison: liaisons[i])
                                    i = i + 1
                                }
                            }  else {
                                //print ("END")
                            }
                        }
                    }
                    catch {
                        print("error")
                        self.popup.displayPopup(code: 0)
                    }
                }
            } else {
                self.popup.displayPopup(code: 0)
                //                an error has occured
            }
            if (self.renderManager != nil){
                DispatchQueue.main.async {
                    self.dataManager.recenterAtome()
                    self.renderManager?.print_ball(true, 0)
                }
            } else {
                self.popup.displayPopup(code: 0)
//                an error has occured
            }
        }
    }

    override init() {
        dataManager = DataManager()
    }
    
}
