//
//  TwitterClient.swift
//  Twitter
//
//  Created by Kevin Duong on 2/15/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking


let twitterConsumerKey = "SWn2FuC49rJ9kEAYtYImbVwo7"
let twitterConsumerSecret = "BpRxt5RU5qnlHztoU3gl1DxEXag6BmBlXGxwhz0Hpe0dRfYZ32"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "SWn2FuC49rJ9kEAYtYImbVwo7", consumerSecret: "BpRxt5RU5qnlHztoU3gl1DxEXag6BmBlXGxwhz0Hpe0dRfYZ32")
    
    var loginSucess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
    
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSucess?()
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSucess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func favorite(id_str: String) {
        POST("https://api.twitter.com/1.1/favorites/create.json?id=\(id_str)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful like")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("like error")
        }
    }
    
    func unfavorite(id_str: String) {
        POST("https://api.twitter.com/1.1/favorites/destroy.json?id=\(id_str)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful unlike")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("unlike error")
        }
    }
    
    func retweet(id_str: String) {
        POST("https://api.twitter.com/1.1/statuses/retweet/\(id_str).json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful retweet")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("retweet error")
                print("https://api.twitter.com/1.1/statuses/retweet/\(id_str).jsc")
        }
    }
    
    func unretweet(id_str: String) {
        POST("https://api.twitter.com/1.1/statuses/unretweet/\(id_str).json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful unretweet")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("unretweet error")
        }

    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
}
