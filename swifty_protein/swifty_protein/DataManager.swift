//
//  DataManager.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/7/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    static var atomes : [Int : Atome] = [:]
    static var liaisons : [(Int,Int)] = []
    
    
    func addAtome(newAtome : Atome, ind : Int){
        if ((DataManager.atomes[ind]) != nil){
            //print("Error: This atome already exist")
            return
        }
        DataManager.atomes.updateValue(newAtome, forKey: ind)
    }
    
    func addLiaison (newLiaison : (Int, Int)){
        if (newLiaison.0 == newLiaison.1){
            //print ("Error : An atome can not be connected to itself")
            return
        }
        if (DataManager.atomes[newLiaison.0] == nil || DataManager.atomes[newLiaison.1] == nil)
        {
            //print("Error : One of those atomes doesnt exist")
            return
        }
        if (DataManager.liaisons.index(of : newLiaison) != nil || DataManager.liaisons.index(of : (newLiaison.1, newLiaison.0)) != nil){
            //print("Error : This liaison already exist")
            return
        }
        DataManager.liaisons.append(newLiaison)
    }
}


extension Array where Element == (Int,Int){
    func index(of : (Int, Int)) -> Int?{
        var res : Int = 0
        for li in self{
            if (li.0 == of.0 && li.1 == of.1){
                return res
            }
            res += 1
        }
        return nil
    }
}
