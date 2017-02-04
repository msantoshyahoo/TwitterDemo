//
//  User.h
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/1/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;
+ (User *) currentUser;
+ (void) setCurrentUser:(User *) user;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
