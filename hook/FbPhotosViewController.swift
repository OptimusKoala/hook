//
//  FbPhotosCollectionViewController.swift
//  hook
//
//  Created by Michal on 09/10/2015.
//  Copyright © 2015 Michal. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FacebookCell"

// array of links
var dataProfile : UserProfile!
var photosUrl = [String]()
var pickUpPhoto : String!
var numImageViewFB : Int!

class FbPhotosViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parse fb photos
        parseJSON(getJSON("https://graph.facebook.com/me?fields=albums.fields(name,photos.fields(source))&access_token=" + FBSDKAccessToken.currentAccessToken().tokenString))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Background for collection view
        self.collectionView?.backgroundColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 31
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FacebookViewCell
        if let url = NSURL(string: photosUrl[indexPath.row]) {
            if let data = NSData(contentsOfURL: url){
                let fbImage = UIImage(data: data)
                cell.fbPhoto.setImage(fbImage, forState: UIControlState.Normal)
                cell.fbPhoto.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                cell.fbPhoto.tag = indexPath.row
            }
        }
        return cell
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
        for result in json {
            for results in result.1 {
                for albums in results.1 {
                    for data in albums.1 {
                        for photos in data.1 {
                            for link in photos.1.arrayValue {
                                    photosUrl.append(link["source"].stringValue)
                            }
                        }
                    }
                }
            }
        }
    }

    // Trigger
    @IBAction func pickImage(sender: UIButton) {
        dataProfile.images[numImageViewFB] = photosUrl[sender.tag]
        performSegueWithIdentifier("fbPhotosBack", sender: self)
    }

    // pass url of image picked up
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fbPhotosBack"
        {
            let nav = segue.destinationViewController as! EditProfileViewController
            nav.data = dataProfile
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
