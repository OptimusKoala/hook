//
//  ConfigViewController.swift
//  hook
//
//  Created by Michal on 11/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var nameFB: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    
    // Create fbUser object
    let userFb : userFacebook = userFacebook()
    // --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameFB.text = userFb.getUserFullName()
        // Do any additional setup after loading the view.
        
        // delegate function for button
        fbButton.delegate = self
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    // Facebook Delegate Methods
    func loginButton(connection: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil)
        {
            println("Error")
        }
    }

    // Facebook Delegate Methods
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        performSegueWithIdentifier("fbLogOut", sender: self)
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
