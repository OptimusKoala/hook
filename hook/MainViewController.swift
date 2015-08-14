//
//  MainViewController.swift
//  hook
//
//  Created by Michal on 11/07/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, SWRevealViewControllerDelegate {
    // Index for profile
    var cellIndex : Int!
    
    // list of data for cells
    var dataList = [cellData]()
    // my objects cells
    var myData = cellData(myName: "Coquine", myDescription: "Michal je t'aime <3", myImage: "coquine1.jpg", myAge: "22", isConnect: true)
    var myData2 = cellData(myName: "Coquinette", myDescription: "Michal casse moi <3", myImage: "coquine2.jpg", myAge: "19", isConnect: true)
    var myData3 = cellData(myName: "Lussa", myDescription: "Yolo", myImage: "coquine3.jpg", myAge: "21", isConnect: false)
    var myData4 = cellData(myName: "Lussa 2", myDescription: "Yolo 2", myImage: "coquine4.jpg", myAge: "23", isConnect: true)
    var myData5 = cellData(myName: "Coucou", myDescription: "Jsuis une tepu", myImage: "coquine5.jpg", myAge: "20", isConnect: true)
    var myData6 = cellData(myName: "Hey", myDescription: "la bite", myImage: "coquine6.jpg", myAge: "19", isConnect: false)
    var myData7 = cellData(myName: "Liche", myDescription: "Salut pd", myImage: "coquine2.jpg", myAge: "23", isConnect: false)
    
    // hook images
    let fullHeart = UIImage(named: "full_heart_icon")
    let emptyHeart = UIImage(named: "empty_heart_icon")
    // ------------------------------------
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var menuIsOn : Bool = false
    
    // -------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Enable swrevalviewcontroller delegate method
        self.revealViewController().delegate = self
        
        // Insert data in my array
        dataList.insert(myData, atIndex: 0)
        dataList.insert(myData2, atIndex: 1)
        dataList.insert(myData3, atIndex: 2)
        dataList.insert(myData4, atIndex: 3)
        dataList.insert(myData5, atIndex: 4)
        dataList.insert(myData6, atIndex: 5)
        dataList.insert(myData7, atIndex: 6)
        
        //-----------------------------------
        // Print and init menu button 
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
        return dataList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! CellViewController
        let (data) = dataList[indexPath.row]
        let image = UIImage(named: data.image)
        // Configure the cell...
        cell.imageCell.setBackgroundImage(image, forState: UIControlState.Normal)
        cell.nameCell.text = data.name
        cell.descCell.text = data.description
        cell.ageCell.text = String(data.age) + " ans"
        if (data.connect == true)
        {
            cell.connectCell.backgroundColor = UIColor.greenColor()
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.imageCell.tag = indexPath.row
        return cell
    }
    
    @IBAction func hookButton(sender: UIButton) {
        sender.setImage(fullHeart, forState:UIControlState.Normal)
    }
    
    
    @IBAction func imageClick(sender: UIButton) {
        // This code disable click action if menu is on
        if (menuIsOn == false)
        {
            cellIndex = sender.tag
            performSegueWithIdentifier("goToProfile", sender: self)
        }
        else
        {
            // Do a tag gesture to reload mainview
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToProfile"
        {
            let cell : cellData = dataList[cellIndex]
            
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
