//
//  TweetTableViewCell.h
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 1/30/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightConstraint;
@property (weak, nonatomic) Tweet *tweet;

@end
