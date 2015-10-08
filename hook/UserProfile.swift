//
//  cellData.swift
//  hook
//
//  Created by Michal on 11/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import Foundation

class UserProfile  {
    // parameters
    var id : Int
    var name : String
    var mail : String
    var sexe : String
    var description : String
    var gender : String
    var type : String
    var images : [String]
    var age : String
    var connect : Bool
    
    // ------------------------
    // Constructor
    
    init(myId : Int, myName : String, myMail : String, mySexe : String, myDescription : String, myGender : String, myType : String, myImages : [String], myAge : String, isConnect : Bool){
        self.id = myId
        self.name = myName
        self.mail = myMail
        self.sexe = mySexe
        self.description = myDescription
        self.gender = myGender
        self.type = myType
        self.images = myImages
        self.age = myAge
        self.connect = isConnect
    }
    // ------------------------
    
}