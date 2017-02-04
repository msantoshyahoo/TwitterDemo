//
//  ProfileViewController.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 2/2/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileHandle;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *currentUser = [User currentUser];
    NSURL *profileImageUrl = [NSURL URLWithString:currentUser.profileImageUrl];
    [self.profileImageView setImageWithURL:profileImageUrl];
    self.profileName.text = currentUser.name;
    self.profileHandle.text = currentUser.screenname;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
