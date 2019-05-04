//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Eric Liang on 4/28/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var TweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweet: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setFavorited(_ isFavorited:Bool)
    {
        favorited = isFavorited
        if(favorited)
        {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else
        {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any)
    {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure:{ (error) in
            print("Error retweeting")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool)
    {
        if(isRetweeted)
        {
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet.isEnabled = false
        }
        else
        {
            retweet.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet.isEnabled = true
        }
    }
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited)
        {
            TwitterAPICaller.client?.favTweet(tweetId: tweetId
                , success: {
                    self.setFavorited(true)
            }, failure: { (error) in
                print("Favorite failed: \(error)")
            })
        }
        else
        {
            TwitterAPICaller.client?.unfavTweet(tweetId: tweetId, success: {
                self.setFavorited(false)
            }, failure: { (error) in
                print("unfavorite failed: \(error)")
            })
        }
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
