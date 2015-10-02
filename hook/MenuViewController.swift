//
//  MenuViewController.swift
//  hook
//
//  Created by Michal on 16/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController, SWRevealViewControllerDelegate {

    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var contactTableView: UITableView!
    
    // ------------------------------------------------
    // Bool for extend cell
    var expand : Bool = false
    // check if user click or not
    var clicked : Bool = false
    // index to pass data to profileView
    var cellIndex : Int!
    var cellMessageIndex : Int!
    // list of data for cells
    var contactList = [UserProfile]()
    // user profil cells
    var myData : UserProfile!
    // ------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init user data
        let mainUser : MainUserProfile = MainUserProfile(token: FBSDKAccessToken.currentAccessToken().tokenString)
        myData = mainUser.getMainUser()
        
        // resize contact tableview to enable scroll
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height - 130
        contactTableView.frame = CGRectMake(0, 0, 0, screenHeight)
        
        // Add the delegate and datasource for contact TableView
        userTableView.delegate = self
        userTableView.dataSource = self
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
        //add contact into contact list
        // Insert data in my array
        parseJSON(getJSON("http://localhost/webServiceSelectConversations.php?id=" + String(mainUser.getMainUserId())))
        
        // Add bg color to view, used to hide white status bar
        view.backgroundColor = uicolorFromHex(0x279df1)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if (tableView==self.userTableView)
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableView==self.userTableView)
        {
            return ""
        }
        else
        {
            return "Contacts"
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (tableView==self.userTableView)
        {
            return 2
        }
        else
        {
            return contactList.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (tableView==self.userTableView)
        {
            if (indexPath.row == 0) {
                let cellUser = tableView.dequeueReusableCellWithIdentifier("menuCellUser", forIndexPath: indexPath) as! MenuViewCell
                // Configure the cell...
                cellUser.userImage.layer.masksToBounds = false
                cellUser.userImage.layer.borderWidth = 3.0
                cellUser.userImage.layer.borderColor = UIColor.whiteColor().CGColor
                cellUser.userImage.layer.cornerRadius = cellUser.userImage.frame.height/2.6
                cellUser.userImage.clipsToBounds = true
                cellUser.userImage.image = UIImage(named: "michal.jpg")
                cellUser.userName.text = myData.name
                cellUser.userDesc.text = myData.description
                cellUser.userAge.text = myData.age + " ans"
                cellUser.userType.text = myData.type
                cellUser.backgroundColor = UIColor(patternImage: UIImage(named: "fond2.png")!)
                cellUser.userName.hidden = true
                cellUser.userAge.hidden = true
                cellUser.userDesc.hidden = true
                cellUser.userType.hidden = true
                cellUser.nbHook.hidden = true
                cellUser.hookImage.hidden = true
                cellUser.nbHookLabel.hidden = true
                cellUser.editLabel.hidden = true
                return cellUser
            }
            else {
                let cellMenu = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) 
                cellMenu.backgroundColor = UIColor(patternImage: UIImage(named: "fond_cell.png")!)
                return cellMenu
            }
        }
        else
        {
            let cellContact = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactViewCell
            let (contact) = contactList[indexPath.row]
            let image = UIImage(named: contact.images[0])
            let layer : CALayer? = cellContact.contactImage.layer
            layer!.cornerRadius = 22
            layer!.borderWidth = 1.3
            layer!.masksToBounds = true
            cellContact.contactName.text = contact.name
            cellContact.contactImage.setBackgroundImage(image, forState: UIControlState.Normal)
            if (contact.connect == true)
            {
                cellContact.connectedLabel.backgroundColor = UIColor.greenColor()
            }
            cellContact.contactImage.tag = indexPath.row
            return cellContact
        }
        
        // ---------------------------
    }
    
    //Function to hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    // pass data to view controller EditProfile
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editProfile"
        {
            let data : UserProfile = myData
            let nav = segue.destinationViewController as! EditProfileViewController
            nav.data = data
        }
        if segue.identifier == "goToProfileFromMenu"
        {
            let cell : UserProfile = contactList[cellIndex]
            let nav = segue.destinationViewController as! ProfileNavigationViewController
            let navVC = nav.viewControllers.first as! ProfileViewController
            navVC.profile = cell
        }
        if segue.identifier == "MainViewSegue"
        {
            let nav = segue.destinationViewController as! UINavigationController
            let navVC = nav.viewControllers.first as! MainViewController
            navVC.previousVC = "Menu"
        }
        if segue.identifier == "msg3"
        {
            let cell : UserProfile = contactList[cellMessageIndex]
            let nav = segue.destinationViewController as! UINavigationController
            let navVC = nav.viewControllers.first as! LGChatController
            navVC.user = cell
        }
    }

    @IBAction func clickButton(sender: UIButton) {
        cellIndex = sender.tag
        performSegueWithIdentifier("goToProfileFromMenu", sender: self)
    }
    
    @IBAction func clickProfileImage(sender: UITapGestureRecognizer) {
        if (self.expand == true)
        {
            performSegueWithIdentifier("editProfile", sender: self)
        }
    }
    
    // function to update menu cell height
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // disable the click for the cell with menu items
        if (tableView==self.userTableView) && (indexPath.row == 0)
        {
            self.clicked = true
            if (self.expand == false)
            {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! MenuViewCell
                cell.userName.hidden = false
                cell.userAge.hidden = false
                cell.userDesc.hidden = false
                cell.userType.hidden = false
                cell.nbHook.hidden = false
                cell.hookImage.hidden = false
                cell.nbHookLabel.hidden = false
                cell.editLabel.hidden = false
                cell.userImage.userInteractionEnabled = true
                cell.downUpImage.image = UIImage(named: "up.png")
                // ---------------------
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            else
            {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! MenuViewCell
                cell.userName.hidden = true
                cell.userAge.hidden = true
                cell.userDesc.hidden = true
                cell.userType.hidden = true
                cell.nbHook.hidden = true
                cell.hookImage.hidden = true
                cell.nbHookLabel.hidden = true
                cell.editLabel.hidden = true
                cell.userImage.userInteractionEnabled = false
                cell.downUpImage.image = UIImage(named: "down.png")
                
                // ---------------------
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        if (tableView==self.contactTableView)
        {
            cellMessageIndex = indexPath.row
            performSegueWithIdentifier("msg3", sender: self)
        }
    }
    
    // Function to resize menu cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if (tableView==self.userTableView)
            {
                if (indexPath.row == 0)
                {
                    if (self.expand == false && self.clicked == true)
                    {
                        self.expand = true
                        self.clicked = false
                        return 225
                    }
                    else
                    {
                        self.expand = false
                        return 110
                    }
                }
                return 70
            }
        return 50
    }
    
    // Function used to add color with hexa code
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
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
            let myDataJSON = UserProfile(myId: jsonId, myName: jsonName, myMail: jsonMail, mySexe: jsonSexe, myDescription: jsonDescription, myGender : jsonGender, myType: jsonType, myImages: jsonMyImages, myAge: jsonAge, isConnect: jsonConnect)
            contactList.append(myDataJSON)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
