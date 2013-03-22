//
//  PictureSPoTTableViewController.h
//  StanfordFlickrProject
//
//  Created by Joshua Frankel on 3/19/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import "SPoTTableViewController.h"

@interface PictureSPoTTableViewController : SPoTTableViewController

- (NSString *)getFlickrIDForIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
// abstract
- (NSString *)titleForRow:(NSUInteger)row;
// abstract
- (NSString *)subtitleForRow:(NSUInteger)row;
// abstract

@end
