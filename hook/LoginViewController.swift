//
//  LoginViewController.swift
//  hook
//
//  Created by Michal on 27/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

protocol sendDataLabel{
    func sendVC(data:String)
}

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loading:UIActivityIndicatorView!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            // User is not already logged
            println("No Logged")
            loading.hidden = true
            fbButton.readPermissions = ["public_profile", "email", "user_friends"]
            fbButton.delegate = self
        }
        else
        {
            fbButton.hidden = true
            println("Already Logged")
            performSegueWithIdentifier("Login", sender: self)
        }
        // Hide navigation bar when log out
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // Facebook Delegate Methods
    func loginButton(connection: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil)
        {
            println("Error")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
            println("User logged in")
            performSegueWithIdentifier("Login", sender: self)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
