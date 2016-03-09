//
//  ProfileViewController.swift
//  twitterDemo
//
//  Created by Tim Barnard on 3/6/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var users: User!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets
            {
                print(tweet.text)
            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
        })
        
//        nameLabel.text = tweet.user!.name
//        handleLabel.text = "@\(tweet.user!.screenname!)"
//        tweetLabel.text = tweet.text
//        profileImage.setImageWithURL(NSURL(string: tweet.user!.profileUrl! as String)!)
//        
//        retweetsLabel.text = String(tweet.retweetCount!)
//        favoritesLabel.text = String(tweet.favoriteCount!)
//        timeLabel.text = tweet.timeSince
        
        
        
        
        
        
//        profileImage.setImageWithURL(NSURL(string: (tweets.user!.)! as String)!)

        
        profileImage.setImageWithURL(NSURL(string: (User.currentUser!.profileUrl)! as String)!)
//        profileImage.setImageWithURL(NSURL(string: (User!.profileUrl)! as String)!)

        nameLabel.text = "\((User.currentUser!.name)!)"
        handleLabel.text = "@\(User.currentUser!.screenname!)"
//        followersCount.text = "\(User.currentUser!.followedBy!)"
//        followingCount.text = "\(User.currentUser!.following!)"
//        taglineLabel.text = User.currentUser!.tagline!
        if (User.currentUser!.profileBannerURL != nil){
            let imageUrl = User.currentUser!.profileBannerURL!
            bannerImage.setImageWithURL(NSURL(string: imageUrl)!)
        } else{
            print("No Picture")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! ProfileTweetCell
        //issue with TwitterCell
        
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
        // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
