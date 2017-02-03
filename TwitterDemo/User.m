//
//  User.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/1/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];

    }
    return self;
}
@end
