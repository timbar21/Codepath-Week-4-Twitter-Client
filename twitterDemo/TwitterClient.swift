//
//  TwitterClient.swift
//  twitterDemo
//
//  Created by Tim Barnard on 2/28/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "1Bn4y7wLtaZLucbuVU1GtIJyF", consumerSecret: "wA9LlXySrpdKnAZ5do8I5PiDmpuZ54nORYSyctibmTzkK9UCQZ")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ())
    {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }
    
    func logout()
    {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.UserDidLogoutNotification, object: nil)
        
    }
    
    func handleOpenUrl(url: NSURL)
    {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount( { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                
                }, failure: { (error: NSError) ->() in
                    self.loginFailure?(error)
                })
            self.loginSuccess?()
            
            
            }) { (error: NSError!) -> Void in
                print("error \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ())
    {        
            GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ())
    {
//        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
//            let dictionaries = response as! [NSDictionary]
//            
//            let tweets = Tweet.tweetsWithArray(dictionaries)
//            
//            for tweet in tweets
//            {
//                print("\(tweet.text!)")
//            }
//            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
//                
//        })
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! NSDictionary
            let user = User(dictionary: dictionaries)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
                failure(error)
        })
        
}
}
