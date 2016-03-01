//
//  TweetCell.swift
//  Twitter
//
//  Created by Kevin Duong on 2/22/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell{

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profilePicButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
//            profilePicImage.setImageWithURL(tweet)
            usernameLabel.text = tweet.name
            tweetTextLabel.text = tweet.text
            
            let image = UIImage(data: NSData(contentsOfURL: tweet.profilePicURL!)!)
            profilePicButton.setImage(image, forState: .Normal)
//            profilePicButton.setImageForState(UIControlState.Normal withURL: tweet.profilePicURL!)
            timestampLabel.text = tweet.createdAt
            retweetedLabel.text = "\(tweet.retweeted!)"
            favoritesLabel.text = "\(tweet.favorited!)"
        }
    }
    
    @IBAction func retweetButtonClicked(sender: AnyObject) {
        if (tweet.retweetedBool!) {
            tweet.unretweet()
            
            let image = UIImage(named: "retweet-action.png")
            retweetButton.setImage(image, forState: .Normal)
            
            tweet.retweeted = tweet.retweeted! - 1;
        } else {
            tweet.retweet()
            
            let image = UIImage(named: "retweet-action-on-pressed.png")
            retweetButton.setImage(image, forState: .Normal)
            
            tweet.retweeted = tweet.retweeted! + 1;
        }
        
        retweetedLabel.text = "\(tweet.retweeted!)"
    }
    
    
    @IBAction func favoriteButtonClicked(sender: AnyObject) {
        if (tweet.favoritedBool!) {
            tweet.unfavoriteTweet()
            
            let image = UIImage(named: "like-action.png")
            likeButton.setImage(image, forState: .Normal)
            
            tweet.favorited = tweet.favorited! - 1;
        } else {
            tweet.favoriteTweet()
            
            let image = UIImage(named: "like-action-on-pressed.png")
            likeButton.setImage(image, forState: .Normal)
            
            tweet.favorited = tweet.favorited! + 1;
        }
        
        favoritesLabel.text = "\(tweet.favorited!)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
