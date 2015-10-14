//
//  ConfigViewController.swift
//  hook
//
//  Created by Michal on 11/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, FBSDKLoginButtonDelegate, SWRevealViewControllerDelegate {

    @IBOutlet weak var nameFB: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    // --------------------
    var menuIsOn : Bool = false
    
    // Create fbUser object
    let mainUser : MainUserProfile = MainUserProfile(token: FBSDKAccessToken.currentAccessToken().tokenString)
    // --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Enable swrevalviewcontroller delegate method
        self.revealViewController().delegate = self
        
        nameFB.text = mainUser.getMainUser().name
        // Do any additional setup after loading the view.
        
        // delegate function for button
        fbButton.delegate = self
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
    }
    
    // Facebook Delegate Methods
    func loginButton(connection: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil)
        {
            print("Error")
        }
    }

    // Facebook Delegate Methods
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        performSegueWithIdentifier("fbLogOut", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -------------------------------------------
    // Delegate method of SWRevealViewController
    // Used to disable scroll and useractivity in views
    func revealController(revealController: SWRevealViewController!,  willMoveToPosition position: FrontViewPosition){
        if(position == FrontViewPosition.Left) {
            menuIsOn = false
        } else {
            menuIsOn = true
            fbButton.userInteractionEnabled = false
        }
    }
    // ---
    func revealController(revealController: SWRevealViewController!,  didMoveToPosition position: FrontViewPosition){
        if(position == FrontViewPosition.Left) {
            menuIsOn = false
        } else {
            menuIsOn = true
            fbButton.userInteractionEnabled = false
        }
    }
    // -------------------------------------------
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
