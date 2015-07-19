//
//  MenuViewController.swift
//  hook
//
//  Created by Michal on 16/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    @IBOutlet var userTableView: UITableView!
    @IBOutlet weak var contactTableView: UITableView!

    // list of contacts
    // list of data for cells
    var contactList = [String]()
    // my objects cells
    var myData = cellData(myName: "Michal", myDescription: "Bouffeur de cul!", myImage: "michal.jpg", myAge: "22", isConnect: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the delegate and datasource for contact TableView
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
        //add contact into contact list
        contactList.insert("Coquine 1", atIndex: 0)
        contactList.insert("Coquine 2", atIndex: 1)
        contactList.insert("Coquine 3", atIndex: 2)
        contactList.insert("Coquine 4", atIndex: 3)
        contactList.insert("Coquine 5", atIndex: 4)
        contactList.insert("Coquine 6", atIndex: 5)
        
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
            cellContact.contactName.text = contact
            return cellContact
        }
        
        // ---------------------------
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
