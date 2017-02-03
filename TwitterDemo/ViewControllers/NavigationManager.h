//
//  NavigationManager.h
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/2/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationManager : NSObject
+ (instancetype) shared;

- (UIViewController *)rootViewController;
- (void)logIn;
- (void)logOut;

@end
