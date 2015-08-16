//
//  MenuViewCell.swift
//  hook
//
//  Created by Michal on 16/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var userDesc: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var nbHookLabel: UILabel!
    @IBOutlet weak var nbHook: UILabel!
    @IBOutlet weak var hookImage: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
