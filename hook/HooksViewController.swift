//
//  HooksViewController.swift
//  hook
//
//  Created by Michal on 13/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class HooksViewController: UITableViewController {
    
    // list of data for cells
    var hooksList = [cellData]()
    // my objects cells
    var myHook = cellData(myName: "Coquine", myDescription: "Michal je t'aime <3", myImage: "coquine1.jpg", myAge: "22", isConnect: true)
    var myHook2 = cellData(myName: "Coquinette", myDescription: "Michal casse moi <3", myImage: "coquine2.jpg", myAge: "19", isConnect: true)
    var myHook3 = cellData(myName: "Lussa", myDescription: "Yolo", myImage: "coquine3.jpg", myAge: "21", isConnect: false)
    // ------------------------------------

    @IBOutlet weak var menuButton: UIBarButtonItem!
    // ------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Insert data in my array
        hooksList.insert(myHook, atIndex: 0)
        hooksList.insert(myHook2, atIndex: 1)
        hooksList.insert(myHook3, atIndex: 2)
        //-----------------------------------
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return hooksList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("yourHooks", forIndexPath: indexPath) as! YourHooksViewController
        let (data) = hooksList[indexPath.row]
        let image = UIImage(named: data.image)
        // Configure the cell...
        cell.imageCell.image = image
        cell.nameCell.text = data.name
        cell.ageCell.text = String(data.age) + " ans"
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
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
