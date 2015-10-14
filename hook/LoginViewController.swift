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
            print("No Logged")
            loading.hidden = true
            fbButton.readPermissions = ["user_photos", "public_profile", "email", "user_friends"]
            fbButton.delegate = self
        }
        else
        {
            print("Already Logged")
            let array : NSData = getJSON("https://graph.facebook.com/me/?fields=email&access_token=" + FBSDKAccessToken.currentAccessToken().tokenString)
            let json = JSON(data: array)
            self.checkAccount(json["email"].stringValue)
            performSegueWithIdentifier("Login", sender: self)
        }
        // Hide navigation bar when log out
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // Facebook Delegate Methods
    func loginButton(connection: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil)
        {
            print("Error")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
            print("User logged in")
            performSegueWithIdentifier("Login", sender: self)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Json get data function
    func getJSON(urlToRequest: String) -> NSData
    {
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    // Function witch check if account exist
    func checkAccount(email: String)
    {
        let result : String = String(self.getJSON("http://176.31.165.78/hook/webServiceSelectUser.php?mail=%22" + email + "%22"))
        if (result != "<5b5d>")
        {
            print("Account already exist")
        }
        else
        {
            print("No account, creating one")
            createAccount()
        }
    }
    
    // Function witch create a new account in database
    func createAccount()
    {
        // Download data from facebook
        let array : NSData = getJSON("https://graph.facebook.com/me/?fields=first_name,birthday,bio,email,gender,picture.type(large)&access_token=" + FBSDKAccessToken.currentAccessToken().tokenString)
        let json = JSON(data: array)
        // -------------------------------------------------------
        // Store datas
        let name : String = json["first_name"].stringValue
        let birthday : String = json["birthday"].stringValue
        let bio : String = json["bio"].stringValue
        let sexe : String = json["gender"].stringValue
        let email : String = json["email"].stringValue
        let image : String = json["picture"]["data"]["url"].stringValue
        // -------------------------------------------------------
        // Get Age from birthday
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.dateFromString(birthday)
        let now: NSDate = NSDate()
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let ageComponents = calendar.components(.Year,
            fromDate: date!,
            toDate: now,
            options: [])
        // -------------------------------------------------------
        // Insert new user into bdd
        self.getJSON("http://176.31.165.78/hook/webServiceInsertUser.php?name=%22" + name + "%22&email=%22" + email + "%22&sexe=%22" + sexe + "%22&age=%22" + String(ageComponents.year) + "%22&description=%22" + bio + "%22&image=%22" + image + "%22")
        // -------------------------------------------------------
    }
}
