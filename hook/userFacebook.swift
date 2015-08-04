//
//  userFacebook.swift
//  hook
//
//  Created by Michal on 04/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import Foundation

class userFacebook {
    // --------------------
    // Properties
    let username : String
    
    // --------------------
    // Methods
    
    // Constructor
    init(username: String)
    {
        self.username = username
    }
    
    // Accessors
    func getUsername() -> String
    {
        return self.username
    }
    
    // --------------------
    
}