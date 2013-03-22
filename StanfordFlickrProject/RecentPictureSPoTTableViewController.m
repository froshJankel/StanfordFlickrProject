//
//  RecentPictureSPoTTableViewController.m
//  StanfordFlickrProject
//
//  Created by Joshua Frankel on 3/20/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import "RecentPictureSPoTTableViewController.h"

@interface RecentPictureSPoTTableViewController ()
@property (strong, nonatomic) NSArray *recentPhotoArray;
@end

@implementation RecentPictureSPoTTableViewController

#define RECENT_PHOTOS @"RECENT_PHOTOS"

- (NSArray *)recentPhotoArray
{
    if (!_recentPhotoArray) _recentPhotoArray = [[NSArray alloc] init];
    NSArray *userDefaultsRecentArray = [[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_PHOTOS];
    NSUInteger length = ([userDefaultsRecentArray count] <= 10) ?[userDefaultsRecentArray count] : 10;
    NSRange range = NSMakeRange(0, length);
    _recentPhotoArray = [userDefaultsRecentArray subarrayWithRange:range];
    
    return _recentPhotoArray;
}

- (IBAction)clearPressed:(UIBarButtonItem *)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:RECENT_PHOTOS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

- (NSString *)getFlickrIDForIndexPath:(NSIndexPath *)indexPath
{
    return self.recentPhotoArray[indexPath.row][FLICKR_PHOTO_ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentPhotoArray count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return self.recentPhotoArray[row][FLICKR_PHOTO_TITLE];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [self.recentPhotoArray[row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
