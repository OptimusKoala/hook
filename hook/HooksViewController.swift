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
    var hooksList = [UserProfile]()
    // ------------------------------------
    var menuIsOn : Bool = false

    @IBOutlet weak var menuButton: UIBarButtonItem!
    // ------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Enable swrevalviewcontroller delegate method
        self.revealViewController().delegate = self
        
        // Insert data in my array
        let mainUser : MainUserProfile = MainUserProfile(token: FBSDKAccessToken.currentAccessToken().tokenString)
        parseJSON(getJSON("http://localhost/webServiceSelectHooks.php?mail=%22" + mainUser.getMainUserEmail() + "%22"))
        
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
            let cell : UserProfile = hooksList[cellIndex]
            
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
        let jsonHook = JSON(data: array)
        for result in jsonHook.arrayValue {
            let array2 : NSData = getJSON("http://localhost/webServiceSelectUser.php?mail=%22" + result["mail"].stringValue + "%22")
            let json = JSON(data: array2)
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
                hooksList.append(myDataJSON)
            }
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
