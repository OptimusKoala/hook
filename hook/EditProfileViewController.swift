//
//  EditProfileViewController.swift
//  hook
//
//  Created by Michal on 10/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    var data : cellData!
    
    // View Controller items
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var profileDesc: UITextField!
    @IBOutlet weak var profileAge: UITextField!

    // -----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: data.image)
        profileImage.image = image
        profileName.text = data.name
        profileAge.text = data.age
        profileDesc.text = data.description
        
        self.title = data.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // User clicked on "Cancel" button
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        // Do nothing
        performSegueWithIdentifier("EditProfile", sender: self)
    }
    
    // User clicked on "Done" button
    @IBAction func doneAction(sender: UIBarButtonItem) {
        // Do SQL request to insert new data in profile
        performSegueWithIdentifier("EditProfile", sender: self)
    }
    
    
    //Function to hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
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
