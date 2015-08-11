//
//  YourHooksViewController.swift
//  hook
//
//  Created by Michal on 13/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class YourHooksViewController: UITableViewCell {

    // -------------------------------
    @IBOutlet weak var imageCell: UIButton!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var ageCell: UILabel!
    // -------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
