//
//  TweetsDetailViewController.swift
//  Twitter
//
//  Created by Kevin Duong on 2/28/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager


class TweetsDetailViewController: UIViewController {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profilePicImageView.setImageWithURL(tweet.profilePicURL!)
        
        nameLabel.text = tweet.name
        screennameLabel.text = "@\((tweet.user?.screenname)!)"
        tweetTextLabel.text = tweet.text
        
        let createdAtString = tweet.createdAtString
        
        if let createdAtString = createdAtString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let date = formatter.dateFromString(createdAtString)
            formatter.dateFormat = "M/d/yy hh:mm a"
            let createdAt = formatter.stringFromDate(date!)
            timeStampLabel.text = "\(createdAt)"
        }
        
        retweetsCountLabel.text = "\(tweet.retweeted!)"
        favoritesCountLabel.text = "\(tweet.favorited!)"
        
        if (!tweet.favoritedBool!) {
            let image = UIImage(named: "like-action.png")
            likeButton.setImage(image, forState: .Normal)
        } else {
            let image = UIImage(named: "like-action-on-pressed.png")
            likeButton.setImage(image, forState: .Normal)
        }
        
        if (!tweet.retweetedBool!) {
            let image = UIImage(named: "retweet-action.png")
            retweetButton.setImage(image, forState: .Normal)
        } else {
            let image = UIImage(named: "retweet-action-on-pressed.png")
            retweetButton.setImage(image, forState: .Normal)
        }
    }

    @IBAction func onFavoritedClicked(sender: AnyObject){
        if (tweet.favoritedBool!) {
            tweet.unfavoriteTweet()
            
            let image = UIImage(named: "like-action.png")
            likeButton.setImage(image, forState: .Normal)
            
            tweet.favorited = tweet.favorited! - 1
        } else {
            tweet.favoriteTweet()
            
            let image = UIImage(named: "like-action-on-pressed.png")
            likeButton.setImage(image, forState: .Normal)
            
            tweet.favorited = tweet.favorited! + 1
        }
        
        favoritesCountLabel.text = "\(tweet.favorited!)"
    }
    
    @IBAction func onRetweetClicked(sender: AnyObject) {
        if (tweet.retweetedBool!) {
            tweet.unretweet()
            
            let image = UIImage(named: "retweet-action.png")
            retweetButton.setImage(image, forState: .Normal)
            
            tweet.retweeted = tweet.retweeted! - 1
        } else {
            tweet.retweet()
            
            let image = UIImage(named: "retweet-action-on-pressed.png")
            retweetButton.setImage(image, forState: .Normal)
            
            tweet.retweeted = tweet.retweeted! + 1
        }
        
        retweetsCountLabel.text = "\(tweet.retweeted!)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let replyTweetViewController = segue.destinationViewController as! ReplyTweetViewController
        
        replyTweetViewController.tweet = tweet
    }

}
