//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Kevin Duong on 2/22/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        self.view1.layer.borderColor = UIColor.grayColor().CGColor
        self.view2.layer.borderColor = UIColor.grayColor().CGColor
        self.view3.layer.borderColor = UIColor.grayColor().CGColor
        
        // Do any additional setup after loading the view.
        
        let currUser = User.currentUser
        
        headerViewImage.setImageWithURL((currUser?.headerView)!)
        profileImageView.setImageWithURL((currUser?.profileUrl)!)
        nameLabel.text = currUser?.name
        screennameLabel.text = "@\((currUser?.screenname)!)"
        tweetsCountLabel.text = "\(currUser!.tweetsCount)"
        followingCountLabel.text = "\(currUser!.followingCount)"
        followersCountLabel.text = "\(currUser!.followersCount)"
        
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
//        User.currentUser?.logout()
        
        TwitterClient.sharedInstance.logout()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if sender is TweetCell {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let detailedViewController = segue.destinationViewController as! TweetsDetailViewController
            
            detailedViewController.tweet = tweet
        }
        else if sender is UIButton {
            let cell = sender as! UIButton
            let indexPath = tableView.indexPathForCell((cell.superview?.superview as! UITableViewCell))
            let tweet = tweets![indexPath!.row]
            let userHomeTimelineViewController = segue.destinationViewController as! UserHomeTimelineViewController
            
            userHomeTimelineViewController.tweet = tweet
        }
    }

}
