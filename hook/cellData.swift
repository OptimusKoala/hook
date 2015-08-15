//
//  cellData.swift
//  hook
//
//  Created by Michal on 11/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import Foundation

class cellData  {
    // parameters
    let name : String
    let description : String
    let type : String
    let image : String
    let age : String
    let connect : Bool
    
    // ------------------------
    // Constructor
    
    init(myName : String, myDescription : String, myType : String, myImage : String, myAge : String, isConnect : Bool){
        self.name = myName
        self.description = myDescription
        self.type = myType
        self.image = myImage
        self.age = myAge
        self.connect = isConnect
    }
    // ------------------------
    
}