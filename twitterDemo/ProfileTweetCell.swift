//
//  ProfileTweetCell.swift
//  twitterDemo
//
//  Created by Tim Barnard on 3/8/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit

class ProfileTweetCell: UITableViewCell {

    var isRetweeted = false
    var isFavorited = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    var tweet: Tweet! {
        didSet {
            
            nameLabel.text = tweet.user!.name
            handleLabel.text = "@\(tweet.user!.screenname!)"
            tweetLabel.text = tweet.text
            profileImage.setImageWithURL(NSURL(string: tweet.user!.profileUrl! as String)!)
            
            retweetsLabel.text = String(tweet.retweetCount!)
            favoritesLabel.text = String(tweet.favoriteCount!)
            timeLabel.text = tweet.timeSince
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func onRetweet(sender: AnyObject) {
        if !isRetweeted {
            isRetweeted = true
            sender.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            if retweetsLabel.text == "0" {
                retweetsLabel.hidden = false
            }
            retweetsLabel.text = String(tweet.retweetCount! + 1)
        } else {
            isRetweeted = false
            sender.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            if retweetsLabel.text == "1" {
                retweetsLabel.hidden = true
            }
            retweetsLabel.text = String(tweet.retweetCount!)
        }
    }
    @IBAction func onFavorite(sender: AnyObject) {
        if !isFavorited {
            isFavorited = true
            sender.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            if favoritesLabel.text == "0" {
                favoritesLabel.hidden = false
            }
            favoritesLabel.text = String(tweet.favoriteCount! + 1)
        } else {
            isFavorited = false
            sender.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            if favoritesLabel.text == "1" {
                favoritesLabel.hidden = true
            }
            favoritesLabel.text = String(tweet.favoriteCount!)
        }
    }
    
}
