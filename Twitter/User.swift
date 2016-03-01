//
//  User.swift
//  Twitter
//
//  Created by Kevin Duong on 2/16/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
//    var name: String?
//    var screenName: String?
//    var profileImageUrl: String?
//    var tagline: String?
//    var dictionary: NSDictionary

    var name: String?
    var screenname: String?
    var profileUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary?
    var headerView: NSURL?
    var followersCount: Int
    var followingCount: Int
    var tweetsCount: Int
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
        let headerViewString = dictionary["profile_background_image_url_https"] as? String
        if let headerViewString = headerViewString {
            headerView = NSURL(string: headerViewString)
        }
        
        followersCount = dictionary["followers_count"] as! Int
        
        followingCount = dictionary["friends_count"]as! Int
        
        tweetsCount = dictionary["statuses_count"]as! Int
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User? {
        
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                
                let userData = defaults.objectForKey("currentUserData") as? NSData
            
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
        
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
