//
//  ProfileViewController.swift
//  hook
//
//  Created by Michal on 10/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // passed data from main view controller
    var profile : cellData!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileAge: UILabel!
    @IBOutlet weak var profileDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: profile.image)
        profileImage.image = image
        profileName.text = profile.name
        profileAge.text = profile.age + " ans"
        profileDesc.text = profile.description
        // Do any additional setup after loading the view.
        
        self.title = profile.name
        
        let numberOfPreviousVC : Int! = self.navigationController?.viewControllers?.count
        if (numberOfPreviousVC == 1)
        {
            let image = UIImage(named: "menu.png")
            let navBar : UINavigationBar
            let menubutton : UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "")
            
            if self.revealViewController() != nil {
                menubutton.target = self.revealViewController()
                menubutton.action = "revealToggle:"
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
            
            self.navigationItem.setLeftBarButtonItem(menubutton, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
