//
//  HooksViewController.swift
//  hook
//
//  Created by Michal on 13/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class HooksViewController: UITableViewController, SWRevealViewControllerDelegate {
    
    // index to pass data to profileView
    var cellIndex : Int!
    // list of data for cells
    var hooksList = [cellData]()
    // my objects cells
    var myHook = cellData(myName: "Coquine", myDescription: "Michal je t'aime <3", myType: "Sportif", myImages: ["coquine1.jpg"], myAge: "22", isConnect: true)
    var myHook2 = cellData(myName: "Coquinette", myDescription: "Michal casse moi <3", myType: "Sportif", myImages: ["coquine2.jpg"], myAge: "19", isConnect: true)
    var myHook3 = cellData(myName: "Lussa", myDescription: "Yolo", myType: "Sportif", myImages: ["coquine3.jpg"], myAge: "21", isConnect: false)
    // ------------------------------------
    var menuIsOn : Bool = false

    @IBOutlet weak var menuButton: UIBarButtonItem!
    // ------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Enable swrevalviewcontroller delegate method
        self.revealViewController().delegate = self
        
        // Insert data in my array
        hooksList.insert(myHook, atIndex: 0)
        hooksList.insert(myHook2, atIndex: 1)
        hooksList.insert(myHook3, atIndex: 2)
        //-----------------------------------
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
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
        let image = UIImage(named: data.images[0])
        // Configure the cell...
        cell.imageCell.setBackgroundImage(image, forState: UIControlState.Normal)
        cell.nameCell.text = data.name
        cell.ageCell.text = String(data.age) + " ans"
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.imageCell.tag = indexPath.row
        return cell
    }
    
    // Event when click on image
    @IBAction func clickImage(sender: UIButton) {
        cellIndex = sender.tag
        performSegueWithIdentifier("goToProfileFromHook", sender: self)
    }
    
    // Pass data to next view controller through
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToProfileFromHook"
        {
            let cell : cellData = hooksList[cellIndex]
            
            let nav = segue.destinationViewController as! ProfileViewController
            nav.profile = cell
        }
    }

    // -------------------------------------------
    // Delegate method of SWRevealViewController
    // Used to disable scroll and useractivity in views
    func revealController(revealController: SWRevealViewController!,  willMoveToPosition position: FrontViewPosition){
        if(position == FrontViewPosition.Left) {
            self.tableView.scrollEnabled = true
            menuIsOn = false
        } else {
            self.tableView.scrollEnabled = false
            menuIsOn = true
        }
    }
    // ---
    func revealController(revealController: SWRevealViewController!,  didMoveToPosition position: FrontViewPosition){
        if(position == FrontViewPosition.Left) {
            self.tableView.scrollEnabled = true
            menuIsOn = false
        } else {
            self.tableView.scrollEnabled = false
            menuIsOn = true
        }
    }
    // -------------------------------------------

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
