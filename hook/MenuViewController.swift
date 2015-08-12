//
//  MenuViewController.swift
//  hook
//
//  Created by Michal on 16/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var contactTableView: UITableView!
    // index to pass data to profileView
    var cellIndex : Int!
    // list of data for cells
    var contactList = [cellData]()
    // Create fbUser object
    let userFb : userFacebook = userFacebook()
    // user profil cells
    var myData : cellData!
    // contact user cells
    var contact1 = cellData(myName: "Coquine", myDescription: "Michal je t'aime <3", myImage: "coquine1.jpg", myAge: "22", isConnect: true)
    var contact2 = cellData(myName: "Coquinette", myDescription: "Michal casse moi <3", myImage: "coquine2.jpg", myAge: "19", isConnect: true)
    var contact3 = cellData(myName: "Lussa", myDescription: "Yolo", myImage: "coquine3.jpg", myAge: "21", isConnect: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init user data
        myData = cellData(myName: userFb.getUserName(), myDescription: "Bouffeur de cul!", myImage: "michal.jpg", myAge: "22", isConnect: true)
        
        // resize contact tableview to enable scroll
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height - 230
        contactTableView.frame = CGRectMake(0, 0, 0, screenHeight)
        
        // Add the delegate and datasource for contact TableView
        userTableView.delegate = self
        userTableView.dataSource = self
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
        //add contact into contact list
        contactList.insert(contact1, atIndex: 0)
        contactList.insert(contact2, atIndex: 1)
        contactList.insert(contact3, atIndex: 2)
        
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
            return 1
        }
        else
        {
            return contactList.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (tableView==self.userTableView)
        {
            let cellUser = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuViewCell
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
            return cellUser
        }
        else
        {
            let cellContact = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactViewCell
            let (contact) = contactList[indexPath.row]
            let image = UIImage(named: contact.image)
            var layer : CALayer? = cellContact.contactImage.layer
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
        return true
    }
    
    // pass data to view controller EditProfile
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editProfile"
        {
            let data : cellData = myData
            
            let nav = segue.destinationViewController as! EditProfileViewController
            nav.data = data
        }
        if segue.identifier == "goToProfileFromMenu"
        {
            let cell : cellData = contactList[cellIndex]
            
            let nav = segue.destinationViewController as! ProfileNavigationViewController
            
            let navVC = nav.viewControllers.first as! ProfileViewController
            navVC.profile = cell
        }
    }

    @IBAction func clickButton(sender: UIButton) {
        cellIndex = sender.tag
        performSegueWithIdentifier("goToProfileFromMenu", sender: self)
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
