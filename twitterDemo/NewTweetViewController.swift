//
//  NewTweetViewController.swift
//  twitterDemo
//
//  Created by Tim Barnard on 3/6/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    var users: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        profileImage.setImageWithURL(NSURL(string: (User.currentUser!.profileUrl)! as String)!)
        nameLabel.text = User.currentUser?.name
        let handle = User.currentUser?.screenname!
        handleLabel.text = "@\(handle!)"
        
        // Do any additional setup after loading the view.
    }
//    var tweet: Tweet! {
//        didSet {
//            
////            nameLabel.text = tweet.user!.name
//            
////            handleLabel.text = "@\(tweet.user!.screenname!)"
////            profileImage.setImageWithURL(NSURL(string: tweet.user!.profileUrl! as String)!)
//            
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 140;
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
