//
//  ContentViewController.swift
//  hook
//
//  Created by Michal on 02/09/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    
    var index: Int = 0
    var myImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageProfile.image = self.myImage
        
        // Do any additional setup after loading the view.
    }
    
}
