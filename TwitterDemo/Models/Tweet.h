//
//  Tweet.h
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/1/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (strong, nonatomic) NSString *relativeTime;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *tweetId;
@property (strong, nonatomic) NSURL *profileImageURL;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, assign) BOOL didIRetweet;
@property (strong, nonatomic) NSString *retweetedByName;
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;
+ (NSArray*) tweetsWithArray:(NSArray *) array;

@end
