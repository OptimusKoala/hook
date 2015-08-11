//
//  ContactViewCell.swift
//  hook
//
//  Created by Michal on 16/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var contactImage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
