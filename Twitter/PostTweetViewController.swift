//
//  PostTweetViewController.swift
//  Twitter
//
//  Created by Kevin Duong on 2/29/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = User.currentUser
    
        profilePicImageView.setImageWithURL((user?.profileUrl)!)
        nameLabel.text = user?.name
        screennameLabel.text = "@\((user?.screenname)!)"
        
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

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onTweetClicked(sender: AnyObject) {
        view.endEditing(true)
        let post = tweetTextField.text!
        let safeUrl = post.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        TwitterClient.sharedInstance.POST("https://api.twitter.com/1.1/statuses/update.json?status=\(safeUrl)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful post")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("post error")
        }
        self.dismissViewControllerAnimated(true, completion: {});
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
