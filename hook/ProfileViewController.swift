//
//  ProfileViewController.swift
//  hook
//
//  Created by Michal on 10/08/2015.
//  Copyright (c) 2015 Michal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // passed data from main view controller
    var profile : UserProfile!
    
    // create arrays for carousel
    var pageViewController: UIPageViewController!
    
    var pageControl: UIPageControl!
    
    var arrayInformationMessages : [String]!
    
    var arrayViewControllers: [UIViewController] = []
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileAge: UILabel!
    @IBOutlet weak var profileDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Profile data
        arrayInformationMessages = profile.images
        profileName.text = profile.name
        profileAge.text = profile.age + " ans"
        profileDesc.text = profile.description
        
        // Do any additional setup after loading the view.
        self.title = profile.name
        
        let numberOfPreviousVC : Int! = self.navigationController?.viewControllers.count
        if (numberOfPreviousVC == 1)
        {
            let image = UIImage(named: "menu.png")
            let menubutton : UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "")
            
            if self.revealViewController() != nil {
                menubutton.target = self.revealViewController()
                menubutton.action = "revealToggle:"
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
            
            self.navigationItem.setLeftBarButtonItem(menubutton, animated: true)
        }
        
        if (arrayInformationMessages.count < 2)
        {
            let image = UIImage(named: arrayInformationMessages[0])
            profileImage.image = image
        }
        else
        {
            // Array containing UIViewControllers which are in fact under the hood
            // downcasted ContentViewControllers.
            self.initArrayViewControllers()
            // UIPageViewController initialization and configuration.
            let toolbarHeight : CGFloat = 170.0
            self.initPageViewController(toolbarHeight)
            // Retrieving UIPageControl
            self.initPageControl()
            self.pageControl.currentPageIndicatorTintColor = uicolorFromHex(0x279df1)
            self.pageControl.pageIndicatorTintColor = uicolorFromHex(0x96c9ed)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the seslected object to the new view controller.
    }
    */
    
    // Required UIPageViewControllerDataSource method
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! ContentViewController).index
        
        if index == self.arrayViewControllers.count - 1 {
            return self.arrayViewControllers[0]
        }
        
        return self.arrayViewControllers[++index]
    }
    
    // Required UIPageViewControllerDataSource method
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! ContentViewController).index
        
        if index == 0 {
            return self.arrayViewControllers[self.arrayViewControllers.count - 1]
        }
        
        return self.arrayViewControllers[--index]
    }
    
    // Optional UIPageViewControllerDataSource method
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.arrayInformationMessages.count
    }
    
    // Optional UIPageViewControllerDataSource method
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    /*
    Optional UIPageViewControllerDelegate method
    
    Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether
    the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
    */
    func pageViewController(pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool)
    {
        // Turn is either finished or aborted
        if (completed && finished) {
            let currentDisplayedViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
            self.pageControl.currentPage = currentDisplayedViewController.index
        }
    }
    
    private func initArrayViewControllers() {
        for (var i = 0; i < self.arrayInformationMessages.count; i++) {
            let contentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ContentViewControllerID") as! ContentViewController
            contentViewController.index = i
            let myImage = UIImage(named: self.arrayInformationMessages[i])
            contentViewController.myImage = myImage
            self.arrayViewControllers.append(contentViewController)
        }
    }
    
    private func initPageViewController(let toolbarHeight: CGFloat) {
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        if let pageViewController = self.pageViewController {
            let initViewController = self.arrayViewControllers[0] as! ContentViewController
            let vcArray = [initViewController]
            let frame = self.view.frame
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.view.frame = CGRectMake(0, 0, frame.width, frame.height - toolbarHeight)
            pageViewController.setViewControllers(vcArray, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            self.addChildViewController(pageViewController)
            self.view.addSubview(pageViewController.view)
            pageViewController.view.clipsToBounds = true
            pageViewController.didMoveToParentViewController(self)
        }
    }
    
    private func initPageControl() {
        let subviews: Array = self.pageViewController.view.subviews
        var pageControl: UIPageControl! = nil
        
        for (var i = 0; i < subviews.count; i++) {
            if (subviews[i] is UIPageControl) {
                pageControl = subviews[i] as! UIPageControl
                break
            }
        }
        self.pageControl = pageControl
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "msg2"
        {
            let nav = segue.destinationViewController as! LGChatController
            nav.user = profile
        }
    }

    
    // Function used to add color with hexa code
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
