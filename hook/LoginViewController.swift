//
//  LoginViewController.swift
//  hook
//
//  Created by Michal on 27/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    var userFB : String = "error" {
        didSet {
            self.stringUpdated()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            // User is not already logged
            println("No Logged")
            fbButton.readPermissions = ["public_profile", "email", "user_friends"]
            fbButton.delegate = self
        }
        else
        {
            fbButton.readPermissions = ["public_profile", "email", "user_friends"]
            fbButton.delegate = self
            println("Already Logged")
            self.returnUserData()
        }

        
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
            self.returnUserData()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        // Launch asynchronous function
        var userName : String = "error"
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                self.userFB = result["email"] as! String
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stringUpdated() {
        
        println("email is : \(userFB)")
        performSegueWithIdentifier("Login", sender: self)
    }
    
}
