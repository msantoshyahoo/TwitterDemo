//
//  User.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/1/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "User.h"

@interface User ()
@property (nonatomic, strong) NSDictionary *userDictionary;
@end

@implementation User
static User* _currentUser;
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.userDictionary = dictionary;
    if(self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url_https"];
        self.tagline = dictionary[@"description"];

    }
    return self;
}

+ (User *) currentUser {
    if(_currentUser == nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *userData = [defaults objectForKey:@"currentUserData"];
        NSError *nse;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:&nse];
        _currentUser = [[User alloc] initWithDictionary: dictionary];
        NSLog(@"user fields = %@", dictionary);
    }
    return _currentUser;
}

+ (void) setCurrentUser:(User *) user {
    _currentUser = user;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSError *nse;
    if(user != nil) {
        NSData *userData = [NSJSONSerialization dataWithJSONObject:user.userDictionary options:NSJSONWritingPrettyPrinted error:&nse];
        [defaults setObject:userData forKey:@"currentUserData"];
    } else {
        [defaults setObject:nil forKey:@"currentUserData"];
    }
}





@end
