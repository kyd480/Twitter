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
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            
        }
        
        return Static.instance
    }
}
