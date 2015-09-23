//
//  MainUserProfile.swift
//  hook
//
//  Created by Michal on 17/09/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import Foundation

class MainUserProfile {
    // Parameters
    var mainUser : UserProfile!

    // constructor
    init(token: String)
    {
        let array : NSData = getJSON("https://graph.facebook.com/me/?fields=email&access_token=" + token)
        let json = JSON(data: array)
        self.parseJSON(self.getJSON("http://localhost/webServiceSelectUser.php?mail=%22" + json["email"].stringValue + "%22"))
    }
    
    // functions
    func getMainUser() -> UserProfile
    {
        return mainUser
    }
    
    func setMainUser(data: UserProfile)
    {
        self.mainUser = data
    }
    
    func getMainUserEmail() -> String
    {
        return self.mainUser.mail
    }
    
    func getMainUserId() -> Int
    {
        return self.mainUser.id
    }
    
    // Json get data function
    func getJSON(urlToRequest: String) -> NSData
    {
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    // JSON parse data function
    func parseJSON(dataURL: NSData)
    {
        // Function that parse the json array to variables
        let array : NSData = dataURL
        let json = JSON(data: array)
        print(json["name"].stringValue)
        var myDataJSON : UserProfile!
        for result in json.arrayValue {
            let jsonId = result["id"].intValue
            let jsonName = result["name"].stringValue
            let jsonMail = result["mail"].stringValue
            let jsonSexe = result["sexe"].stringValue
            let jsonDescription = result["description"].stringValue
            let jsonGender = result["gender"].stringValue
            let jsonType = result["type"].stringValue
            let jsonAge = result["age"].stringValue
            let jsonImage = result["image"].stringValue
            let jsonImage2 = result["image2"].stringValue
            let jsonImage3 = result["image3"].stringValue
            var jsonConnect : Bool!
            if (result["connect"].stringValue == "true"){
                jsonConnect = true
            }
            else{
                jsonConnect = false
            }
            
            var jsonMyImages : [String]!
            if ((jsonImage != "") && (jsonImage2 != ""))
            {
                if (jsonImage3 != "")
                {
                    jsonMyImages = [jsonImage,jsonImage2,jsonImage3]
                }
                jsonMyImages = [jsonImage,jsonImage2]
            }
            else
            {
                jsonMyImages = [jsonImage]
            }
            myDataJSON = UserProfile(myId: jsonId, myName: jsonName, myMail: jsonMail, mySexe: jsonSexe, myDescription: jsonDescription, myGender : jsonGender, myType: jsonType, myImages: jsonMyImages, myAge: jsonAge, isConnect: jsonConnect)
            setMainUser(myDataJSON)
        }
    }
}
