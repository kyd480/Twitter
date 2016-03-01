//
//  Tweet.swift
//  Twitter
//
//  Created by Kevin Duong on 2/16/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var name: String?
    var retweeted: Int?
    var favorited: Int?
    var profilePicURL: NSURL?
    var createdAtString: String?
    var createdAt: String?
    var idString: String?
    var favoritedBool: Bool?
    var retweetedBool: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        name = dictionary.valueForKeyPath("user.name") as? String
        retweeted = (dictionary["retweet_count"] as? Int) ?? 0
        favorited = (dictionary["favorite_count"] as? Int) ?? 0
        idString = dictionary["id_str"] as? String
        
        let profilePicURLString = dictionary.valueForKeyPath("user.profile_image_url") as? String
        if profilePicURLString != nil {
            profilePicURL = NSURL(string: profilePicURLString!)!
        } else {
            profilePicURL = nil
        }
        
        createdAtString = dictionary["created_at"] as? String

        if let createdAtString = createdAtString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let date = formatter.dateFromString(createdAtString)
            formatter.dateFormat = "h"
            createdAt = formatter.stringFromDate(date!) + "h"
        }
        
        favoritedBool = dictionary["favorited"] as? Bool
        retweetedBool = dictionary["retweeted"] as? Bool
    }
    
    func favoriteTweet() {
        TwitterClient.sharedInstance.favorite(idString!)
        favoritedBool = true
    }
    
    func unfavoriteTweet() {
        TwitterClient.sharedInstance.unfavorite(idString!)
        favoritedBool = false
    }
    
    func retweet() {
        TwitterClient.sharedInstance.retweet(idString!)
        retweetedBool = true
    }
    
    func unretweet() {
        TwitterClient.sharedInstance.unretweet(idString!)
        retweetedBool = false
    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
