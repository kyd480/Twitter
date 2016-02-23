//
//  TweetCell.swift
//  Twitter
//
//  Created by Kevin Duong on 2/22/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
//            profilePicImage.setImageWithURL(tweet)
            usernameLabel.text = tweet.name
            tweetTextLabel.text = tweet.text
            profilePicImage.setImageWithURL(tweet.profilePicURL!)
            timestampLabel.text = tweet.createdAt
            retweetedLabel.text = "\(tweet.retweeted!)"
            favoritesLabel.text = "\(tweet.favorited!)"
        }
    }
    
    @IBAction func retweetButtonClicked(sender: AnyObject) {
        tweet.retweeted! += 1
        
        retweetedLabel.text = "\(tweet.retweeted!)"
    }
    
    @IBAction func favoriteButtonClicked(sender: AnyObject) {
        tweet.favorited! += 1
        
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
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
