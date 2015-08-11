//
//  userFacebook.swift
//  hook
//
//  Created by Michal on 10/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import Foundation

class userFacebook {
    // parameters
    var userName : String = "error" {
        didSet {
            println()
        }
    }
    
    var userMail : String = "error" {
        didSet {
            println()
        }
    }
    
    // ------------------------
    // Constructor
    
    init()
    {
        self.getData()
    }
    // ------------------------
    // get facebook data
    func getData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, birthday"])
        // Launch asynchronous function
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                self.userName = result["first_name"] as! String
                self.userMail = result["email"] as! String
                
            }
        })

    }
    // ------------------------
    // get data functions
    func getUserName() -> String
    {
        return self.userName
    }
    // ----------
    func getUserMail() -> String
    {
        return self.userMail
    }

    // ----------
}