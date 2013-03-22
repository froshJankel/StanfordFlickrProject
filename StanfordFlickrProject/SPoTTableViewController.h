//
//  SPoTTableViewController.h
//  SPoT
//
//  Created by Joshua Frankel on 3/18/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"


@interface SPoTTableViewController : UITableViewController
@property (strong, nonatomic) NSArray *photoCollection;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
// abstract
- (NSString *)titleForRow:(NSUInteger)row;
// abstract
- (NSString *)subtitleForRow:(NSUInteger)row;
// abstract
@end
