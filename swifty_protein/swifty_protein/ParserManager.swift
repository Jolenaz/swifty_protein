//
//  ParserManager.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/7/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//
// Pour download PDB : https://files.rcsb.org/ligands/download/011_ideal.pdb

import UIKit

class ParserManager: NSObject {

    var dataManager : DataManager
    
    override init() {
        dataManager = DataManager()
    }
    
}
