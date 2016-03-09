//
//  TweetsDetailViewController.swift
//  twitterDemo
//
//  Created by Tim Barnard on 3/6/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var users: User!
//    var tweets: [Tweet]!

    var tweet: Tweet?
    var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tweetLabel.text = tweet!.text
//        nameLabel.text = "\((tweet!.user?.name)!)"
//        handleLabel.text = "@\(tweet!.user!.screenname!)"
//        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//        let dateString = dateFormatter.stringFromDate((tweet?.createdAt!)!)
//        timeLabel.text = "\(dateString)"
//        if (tweet?.user?.profileUrl != nil){
//            let imageUrl = tweet!.user!.profileUrl!
//            profileImage.setImageWithURL(NSURL(string: imageUrl)!)
//        } else{
//            print("No Picture")
//        }
//        DetailNumberTweetsLabel.text = String(tweet!.retweetCount!)
//        DetailNumberFavoritesLabel.text = String(tweet!.likeCount)
//        DetailUserNameLabel.preferredMaxLayoutWidth = DetailUserNameLabel.frame.size.width
//        DetailsProfileImage.layer.cornerRadius = 4
//        DetailsProfileImage.clipsToBounds = true
//        self.DetailRetweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Selected)
//        self.DetailLikesButton.setImage(UIImage(named: "Like"), forState: UIControlState.Selected)
        tweetLabel.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onHomeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
