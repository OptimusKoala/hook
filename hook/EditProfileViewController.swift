//
//  EditProfileViewController.swift
//  hook
//
//  Created by Michal on 10/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate, SWRevealViewControllerDelegate {
    
    // View Controller items
    @IBOutlet weak var profileImage1: UIImageView!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var profileDesc: UITextField!
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var profileImage3: UIImageView!
    @IBOutlet weak var profileGender: UISegmentedControl!
    @IBOutlet weak var profileType: UIPickerView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // Datas
    var data : UserProfile!
    var gender : String!
    var typesH = ["BCBG","Sportif","Fêtard","Geek","Gourmand","Blageur","Musicien","Artiste","Cinéphile","Lecteur","Motard","Alcoolique","Hippie","Hipster","Licorne","Machine"]
    var typesF = ["BCBG","Sportive","Fêtarde","Geek","Gourmande","Blageuse","Musicienne","Artiste","Cinéphile","Lectrice","Motarde","Alcoolique","Hippie","Hipster","Licorne","Machine"]
    var type : String!
    var rowType : Int!
    var imagePickedUp : String!
    var numImageView : Int!
    
    // -----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Enable swrevalviewcontroller delegate method
        self.revealViewController().delegate = self
        
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
        profileDesc.text = data.description
        
        // Set segmented view controller
        parseGenderToIndex(profileGender)
        
        // Set pickerview
        parseTypes(type)
        profileType.selectRow(rowType, inComponent: 0, animated: true)
        
        // Delate textfields
        profileName.delegate = self
        profileDesc.delegate = self
        
        // View title
        self.title = data.name
        
        // hide navigation bar when back from fb photos
        self.navigationController?.navigationBarHidden = true
        
        //-----------------------------------
        // Print and init menu button
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide navigation bar when back from fb photos
        self.navigationController?.navigationBarHidden = true
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
    
    // User clicked on "Valider" button
    @IBAction func editAction(sender: UIBarButtonItem) {
        // Do SQL request to insert new data in profile
        let url : String = "http://176.31.165.78/hook/webServiceUpdateUser.php?id=" + String(data.id) + "&name=%22" + data.name.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSCharacterSet)! + "%22&description=%22" + data.description.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSCharacterSet)! + "%22&gender=%22" + gender + "%22&type=%22" + type.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSCharacterSet)! + "%22&image=%22" + data.images[0].stringByReplacingOccurrencesOfString("&", withString: "%26") + "%22&image2=%22" + data.images[1].stringByReplacingOccurrencesOfString("&", withString: "%26") + "%22&image3=%22" + data.images[2].stringByReplacingOccurrencesOfString("&", withString: "%26") + "%22"
        getJSON(url)
        // Go back to menu view controller
        self.revealViewController().revealToggleAnimated(true)
    }
    
    // Textfield delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField
        {
        case profileName:
            data.name = textField.text!
        case profileDesc:
            data.description = textField.text!
        default:
            break;
        }
        return true
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
    
    // Select image for user image 1
    @IBAction func clickImage1(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("fbPhotos", sender: self)
        numImageViewFB = 0
    }
    
    // Select image for user image 2
    @IBAction func clickImage2(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("fbPhotos", sender: self)
        numImageViewFB = 1
    }
    
    // Select image for user image 3
    @IBAction func clickImage3(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("fbPhotos", sender: self)
        numImageViewFB = 2
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fbPhotos"
        {
            dataProfile = data
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
