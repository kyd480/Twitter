//
//  UserHomeTimelineViewController.swift
//  Twitter
//
//  Created by Kevin Duong on 2/29/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class UserHomeTimelineViewController: UIViewController {

    @IBOutlet weak var headerViewImage: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view1.layer.borderColor = UIColor.grayColor().CGColor
        self.view2.layer.borderColor = UIColor.grayColor().CGColor
        self.view3.layer.borderColor = UIColor.grayColor().CGColor
        
        let currUser = tweet.user
        headerViewImage.setImageWithURL((currUser?.headerView)!)
        profileImageView.setImageWithURL((currUser?.profileUrl)!)
        nameLabel.text = currUser?.name
        screennameLabel.text = "@\((currUser?.screenname)!)"
        tweetsCountLabel.text = "\(currUser!.tweetsCount)"
        followingCountLabel.text = "\(currUser!.followingCount)"
        followersCountLabel.text = "\(currUser!.followersCount)"
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
        // Pass the selected object to the new view controller.
    }
    */

}
