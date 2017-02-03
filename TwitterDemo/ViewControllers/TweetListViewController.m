//
//  TweetListViewController.m
//  TwitterDemo
//
//  Created by  Santosh Sharanappa Mandi on 1/30/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TweetListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControlForTableView;


@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
    [self getTimelineTweets];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    Tweet * tweet = [twitterClient.timelineTweets objectAtIndex:indexPath.row];
    cell.tweet = tweet;
    [cell setNeedsUpdateConstraints];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reload{
    [self.refreshControlForTableView endRefreshing];
    [self.tableView reloadData];
    
}

- (void) getTimelineTweets {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    [twitterClient getTweetsWithCompletion:^(NSArray *tweets, NSError *error) {
        if(tweets != nil){
            self.tweets = tweets;
            [self performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone: NO];
        }else{
            NSLog(@"getTimelineTweets NSError: %@", error.localizedDescription);
        }
    }];
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
