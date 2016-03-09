//
//  User.swift
//  twitterDemo
//
//  Created by Tim Barnard on 2/27/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//
import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: NSString?
    var tagline: String?
    var dictionary: NSDictionary
    var profileBannerURL: String?
    var followed: Int?
    var following: Int?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        profileUrl = dictionary["profile_image_url_https"] as? String
        profileBannerURL = dictionary["profile_banner_url_https"] as? String

        tagline = dictionary["description"] as? String
        
        followed = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
    }
    
    static let UserDidLogoutNotification = "UserDidLogout"

    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let userData = defaults.objectForKey("currentUser") as? NSData
        
        if let userData = userData {
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
        _currentUser = User(dictionary: dictionary )
        }
        }
        
        return _currentUser
        }
        
        set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                do{
                let data = try NSJSONSerialization.dataWithJSONObject(user.dictionary, options: NSJSONWritingOptions())
                
                defaults.setObject(data, forKey: "currentUser")
                }
                catch {
                    print("error parsing json")
                    
                }
            } else {
                defaults.setObject(nil, forKey: "currentUser")
            }
            
            defaults.synchronize()
        }
        
    }
    
}
