//
//  TwitterClient.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 1/31/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"tcWZXPgqC9ufwWBe298rgtiRd";
NSString * const kTwitterConsumerSecret = @"WQrAMTCYM0mn7JbbcUnyxxLfrTVgMSCCQ1lq9VAvebQQeXmNPK";

NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@property (nonatomic, strong) void (^getTweetsCompletion) (NSArray *tweets, NSError *error);
@property (nonatomic, strong) void (^retweetCompletion) (id response, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
            instance.mapOfTweets = [[NSMutableDictionary alloc] initWithCapacity:100];

        }
    });
    return instance;
}

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    [self deauthorize];
    
    //[self.requestSerializer removeAccessToken];
    [self
     fetchRequestTokenWithPath:@"oauth/request_token"
     method:@"GET"
     callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"]
     scope:nil
     success:^(BDBOAuth1Credential *requestToken) {
        
        NSLog(@"got the request token ! token = %@", requestToken);
         NSString *strAuthURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];

        NSURL *authURL = [NSURL URLWithString:strAuthURL];
        NSLog(@"auth url = %@", authURL);
        [[UIApplication sharedApplication] openURL:authURL];
    }failure:^(NSError *error) {
        NSLog(@"Failed to get the request token");
        self.loginCompletion(nil, error);
    }];

}

- (void)openURL:(NSURL *)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString: url.query]
        success:^(BDBOAuth1Credential *accessToken) {
            NSLog(@"Got the access token !");
            [self.requestSerializer saveAccessToken: accessToken];
            
            [self GET:@"1.1/account/verify_credentials.json" parameters:nil
                                        success:^(NSURLSessionDataTask *dataTask, id responseObject ) {
                                            User *user = [[User alloc] initWithDictionary: responseObject];
                                            self.loginCompletion(user, nil);
                                        }
                                        failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
                                            self.loginCompletion(nil, error);

                                        }];
        }
        failure:^(NSError *error) {
            NSLog(@"Failed to get the access token !");
            self.loginCompletion(nil, error);

        }];
    

}

- (void) getTweetsWithCompletion:( void (^)(NSArray *tweets, NSError *error))completion{
    self.getTweetsCompletion = completion;
    [self
     GET:@"1.1/statuses/home_timeline.json?count=50"
     parameters:nil
     progress:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"absoluteString: %@", task.originalRequest.URL.absoluteString);
         NSMutableArray *_tweets = [NSMutableArray array];
         NSArray *tweets = [Tweet tweetsWithArray:responseObject];
         NSLog(@"getTweetsWithCompletion: %@", responseObject);
         for(Tweet *tweet in tweets){
             Tweet *savedtweet = self.mapOfTweets[tweet.tweetId];
             if(savedtweet != nil){
                 tweet.didIRetweet = savedtweet.didIRetweet;
             }
             [_tweets addObject:tweet];
             [self.mapOfTweets setValue:tweet forKey:tweet.tweetId];
         }
         self.timelineTweets = _tweets;
         //         NSLog(@"getTweetsWithCompletion array size %ld", _tweets.count);
         self.getTweetsCompletion(self.timelineTweets, nil);
     }
     failure:^(NSURLSessionTask *task, NSError *error) {
         NSLog(@"getTweetsWithCompletion NSError: %@", error.localizedDescription);
         self.getTweetsCompletion(nil, error);
     }];
}

- (void) retweetThisId: (NSString*)tweetId retweetWithCompletion:( void (^)(id retweetResponse, NSError *error))completion{
    self.retweetCompletion = completion;
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    NSLog(@"retweetThisId: %@", url);
    [self
     POST:[NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId]
     parameters:nil
     progress:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"absoluteString: %@", task.originalRequest.URL.absoluteString);
         self.retweetCompletion(responseObject, nil);
     }
     failure:^(NSURLSessionTask *task, NSError *error) {
         NSLog(@"retweetWithCompletion NSError: %@", error.debugDescription);
         self.retweetCompletion(nil, error);
     }];
    
}



@end
