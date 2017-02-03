//
//  TweetTableViewCell.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 1/30/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@interface TweetTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIView *retweetView;
@property (strong, nonatomic) NSString *tweetId;


@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.text = @"My Twitter Name";
    self.handleLabel.text = @"@santoshms";
    self.timestampLabel.text = @"4h";
    self.contentLabel.text = @"A very long repeated message. A very long repeated message. A very long repeated message. A very long repeated message. A very long repeated message. A very long repeated message. ";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if(self.tweet.content == nil) return;
    UIImage *image = [UIImage imageNamed: @"retweet-icon.png"];
    [self.retweetButton setImage:image forState:UIControlStateNormal];
    self.tweetId = self.tweet.tweetId;
    self.retweetView.hidden = YES;
    if(self.tweet.retweeted){
        self.retweetView.hidden = NO;
        self.retweetLabel.text = self.tweet.retweetedByName;
    }
    self.nameLabel.text = self.tweet.name;
    self.handleLabel.text = self.tweet.handle;
    self.contentLabel.text =  [NSString stringWithFormat:@"%@",self.tweet.content];
    self.timestampLabel.text =  [NSString stringWithFormat:@"%@", self.tweet.relativeTime];
    [self.profileImageView setImageWithURL: self.tweet.profileImageURL];
    if(self.tweet.didIRetweet){
        UIImage *image = [UIImage imageNamed: @"retweet-icon-green.png"];
        [self.retweetButton setImage:image forState:UIControlStateNormal];
    }
    //    if(self.tweet != nil) NSLog(@"\nsetSelected name:%@, handle:%@, content:%@\n\n", self.nameLabel.text, self.handleLabel.text, self.contentLabel.text);
}

- (IBAction)onRetweet:(id)sender {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    Tweet *tweet = twitterClient.mapOfTweets[self.tweetId];
    //    if(tweet.didIRetweet) return;
    [twitterClient retweetThisId:self.tweetId retweetWithCompletion:^(id response, NSError *error) {
        if(response != nil){
            UIImage *image = [UIImage imageNamed: @"retweet-icon-green@3x.png"];
            [self.retweetButton setImage:image forState:UIControlStateNormal];
            tweet.didIRetweet = YES;
        }else{
            UIImage *image = [UIImage imageNamed: @"retweet-icon-green@3x.png"];
            [self.retweetButton setImage:image forState:UIControlStateNormal];
            tweet.didIRetweet = YES;
            NSLog(@"getTimelineTweets NSError: %@", error.localizedDescription);
        }
    }];

}

@end
