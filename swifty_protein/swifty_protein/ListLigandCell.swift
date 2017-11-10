//
//  ListLigandCell.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/10/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class ListLigandCell: UITableViewCell {

    var name : String?{
        didSet{
            self.nameLabel.text = name
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
