//
//  ReplyTweetViewController.swift
//  Twitter
//
//  Created by Kevin Duong on 2/29/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class ReplyTweetViewController: UIViewController {

    
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profilePicImage.setImageWithURL(tweet.profilePicURL!)
        nameLabel.text = tweet.name
        screennameLabel.text = "@\((tweet.user?.screenname)!)"
        tweetTextField.text = "@\((tweet.user?.screenname)!) "
        
        tweetTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelClicked(sender: AnyObject) {
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: {});
    }

    @IBAction func onTweetClicked(sender: AnyObject) {
        view.endEditing(true)
        let post = tweetTextField.text!
        let safeUrl = post.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let id_str = tweet.idString!
        
        TwitterClient.sharedInstance.POST("https://api.twitter.com/1.1/statuses/update.json?status=\(safeUrl)&in_reply_to_status_id=\(id_str)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful reply")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("reply error")
        }
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }*/

}
