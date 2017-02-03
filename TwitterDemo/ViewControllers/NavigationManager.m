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
#import "ProfileViewController.h"

@interface NavigationManager ()
@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UINavigationController *tweetListNavigationController;
@property (nonatomic, strong) UINavigationController *profileNavigationController;


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
    
    //homeline vc
    if(self.tweetListNavigationController == nil) {
        TweetListViewController *tweetListViewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
        self.tweetListNavigationController = [[UINavigationController alloc] initWithRootViewController:tweetListViewController];
        self.tweetListNavigationController.tabBarItem.title = @"Tweet List";
        UIImage *homeIconImage = [UIImage imageNamed: @"home-icon.png"];
        [self.tweetListNavigationController.tabBarItem setImage:homeIconImage];
    }
    
    //profile vc
    if(self.profileNavigationController == nil) {
        ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle: nil];
        self.profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
        UIImage *profileIconImage = [UIImage imageNamed: @"profile-icon.png"];
        [self.profileNavigationController.tabBarItem setImage:profileIconImage];
    }

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NSArray* controllers = [NSArray arrayWithObjects:self.tweetListNavigationController, self.profileNavigationController, nil];
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
