//
//  EditProfileViewController.swift
//  hook
//
//  Created by Michal on 10/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    var data : UserProfile!
    
    // View Controller items
    @IBOutlet weak var profileImage1: UIImageView!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var profileDesc: UITextField!
    @IBOutlet weak var profileAge: UITextField!
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var profileImage3: UIImageView!
    @IBOutlet weak var profileGender: UISegmentedControl!
    @IBOutlet weak var profileType: UIPickerView!
    
    var gender : String!
    var typesH = ["Sportif","Fêtard","Geek","Gourmand","Blageur","Musicien","Artiste","Cinéphile","Lecteur","Motard","Alcoolique","Hippie","Hipster","Licorne","Machine"]
    var typesF = ["Sportive","Fêtarde","Geek","Gourmande","Blageuse","Musicienne","Artiste","Cinéphile","Lectrice","Motarde","Alcoolique","Hippie","Hipster","Licorne","Machine"]
    var type : String!
    var rowType : Int!
    // -----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Array of imagesView
        var images : [UIImageView] = [profileImage1, profileImage2, profileImage3]
        gender = data.gender
        type = data.type
        
        // Print every images
        for (var i : Int = 0; i < 3; i++)
        {
            if let url = NSURL(string: data.images[i]) {
                if let data = NSData(contentsOfURL: url){
                    images[i].image = UIImage(data: data)
                }
            }
        }
        profileName.text = data.name
        profileAge.text = data.age
        profileDesc.text = data.description
        
        // Set segmented
        parseGenderToIndex(profileGender)
        
        // Set pickerview
        parseTypes(type)
        profileType.selectRow(rowType, inComponent: 0, animated: true)
        
        self.title = data.name
        
        if ((self.view.gestureRecognizers) != nil)
        {
            DismissKeyboard()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When segmented control value change
    @IBAction func profileGenderChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            if (data.sexe == "h")
            {
                self.gender = "h"
            }
            else
            {
                self.gender = "g"
            }
        case 1:
            if (data.sexe == "h")
            {
                self.gender = "g"
            }
            else
            {
                self.gender = "h"
            }
        case 2:
            self.gender = "b"
        default:
            break;
        }
    }
    
    // User clicked on "Cancel" button
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        // Do nothing but go back to menu view controller
        navigationController?.popViewControllerAnimated(true)
    }
    
    // User clicked on "Done" button
    @IBAction func doneAction(sender: UIBarButtonItem) {
        // Get all new datas
        let name : String = String(profileName.text)
        let description : String = String(profileDesc.text)
        
        // Do SQL request to insert new data in profile
        getJSON("http://localhost/webServiceUpdateUser.php?id=2&name=%22" + name + "%22&description=%22" + description + "%22&gender=%22" + gender + "%22&type=%22" + type + "%22&image=%22%22&image2=%22%22&image3=%22%22")
        // Go back to menu view controller
        navigationController?.popViewControllerAnimated(true)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Json get data function
    func getJSON(urlToRequest: String) -> NSData
    {
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    // set index of segmented controll
    func parseGenderToIndex(sc : UISegmentedControl)
    {
        switch data.gender
        {
        case "h":
            if (data.sexe == "h")
            {
                sc.selectedSegmentIndex = 0
            }
            else
            {
                sc.selectedSegmentIndex = 1
            }
        case "g":
            if (data.sexe == "f")
            {
                sc.selectedSegmentIndex = 0
            }
            else
            {
                sc.selectedSegmentIndex = 1
            }
        case "b":
            sc.selectedSegmentIndex = 2
        default:
            break;
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return typesH.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if data.sexe == "h"
        {
            return typesH[row]
        }
        else
        {
            return typesF[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if data.sexe == "h"
        {
            type = typesH[row]
        }
        else
        {
            type = typesF[row]
        }
    }
    
    // Parse all types and pick the good
    func parseTypes(theType : String)
    {
        var i : Int = 0
        if data.sexe == "h"
        {
            for myType in typesH
            {
                if myType == theType
                {
                    rowType = i
                }
                i++
            }
        }
        else
        {
            for myType in typesH
            {
                if myType == theType
                {
                    rowType = i
                }
                i++
            }
        }
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
