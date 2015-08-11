//
//  CellViewController.swift
//  hook
//
//  Created by Michal on 11/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class CellViewController: UITableViewCell {

    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var descCell: UILabel!
    @IBOutlet weak var imageCell: UIButton!
    @IBOutlet weak var ageCell: UILabel!
    @IBOutlet weak var connectCell: UILabel!
    
    // ---------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
