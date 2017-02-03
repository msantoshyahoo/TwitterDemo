//
//  TwitterClient.h
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 1/31/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1SessionManager
+ (TwitterClient *)sharedInstance;
- (void) currentAccount;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;
- (void) getTweetsWithCompletion:( void (^)(NSArray *tweets, NSError *error))completion;
- (void) retweetThisId: (NSString*)tweetId retweetWithCompletion:( void (^)(id retweetResponse, NSError *error))completion;
@property (strong, nonatomic) NSArray<Tweet *> *timelineTweets;
@property (strong, nonatomic) NSMutableDictionary<NSString *, Tweet *> *mapOfTweets;

@end
