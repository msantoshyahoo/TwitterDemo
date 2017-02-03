//
//  NavigationManager.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/2/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "NavigationManager.h"
#import "TwitterClient.h"
#import "TweetListViewController.h"
#import "LoginViewController.h"

@interface NavigationManager ()
@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UINavigationController *tweetListNavigationController;

@end

@implementation NavigationManager

+ (instancetype) shared {
    static NavigationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        TwitterClient *twitterClient = [TwitterClient sharedInstance];
        self.isLoggedIn = twitterClient.isAuthorized;
        UIViewController *root = self.isLoggedIn ? [self loggedInVC] : [self loggedOutVC];
        self.navigationController = [[UINavigationController alloc] init];
        self.navigationController.viewControllers = @[root];
    }
    return self;
}

- (UIViewController *)loggedInVC {
    TweetListViewController *tweetListViewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    if(self.tweetListNavigationController == nil) {
        self.tweetListNavigationController = [[UINavigationController alloc] initWithRootViewController:tweetListViewController];
        self.tweetListNavigationController.tabBarItem.title = @"Tweet List";
    }
    NSArray* controllers = [NSArray arrayWithObjects:self.tweetListNavigationController, nil];
    tabBarController.viewControllers = controllers;
    return tabBarController;
}

- (UIViewController *)loggedOutVC {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return loginViewController;
}

- (UIViewController *)rootViewController {
    return self.navigationController;
}

- (void)logIn {
    self.isLoggedIn = YES;
    NSArray *vcs = @[[self loggedInVC]];
    [self.navigationController setViewControllers:vcs];
}

- (void)logOut {
    self.isLoggedIn = NO;
    NSArray *vcs = @[[self loggedOutVC]];
    [self.navigationController setViewControllers:vcs];
}

@end
