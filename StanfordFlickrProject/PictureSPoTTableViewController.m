//
//  PictureSPoTTableViewController.m
//  StanfordFlickrProject
//
//  Created by Joshua Frankel on 3/19/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import "PictureSPoTTableViewController.h"

@interface PictureSPoTTableViewController ()
@property (strong, nonatomic) NSString *flickrIDForSegue;
@end

@implementation PictureSPoTTableViewController

#define TITLE @"TITLE"
#define DESCRIPTION @"DESCRIPTION"
#define FLICKR_ID @"ID"
#define RECENT_PHOTOS @"RECENT_PHOTOS"






- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
         {
             UITableViewCell *cell = sender;
             NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
             self.flickrIDForSegue = [self getFlickrIDForIndexPath:indexPath];
             for (id photoDictionary in self.photoCollection)
                 if ([photoDictionary isKindOfClass:[NSDictionary class]])
                 {
                     NSDictionary *workingPhotoDictionary = photoDictionary;
                     if (workingPhotoDictionary[FLICKR_PHOTO_ID])
                     {
                         NSString *workingID = [workingPhotoDictionary[FLICKR_PHOTO_ID] description];
                         if ([workingID isEqualToString:self.flickrIDForSegue])
                         {
                             // setting up Segue
                             NSURL *imageURL = [FlickrFetcher urlForPhoto:  workingPhotoDictionary format:FlickrPhotoFormatLarge];
                             if ([segue.destinationViewController respondsToSelector:@selector(setImage:)])
                             [segue.destinationViewController performSelector:@selector(setImage:) withObject:imageURL];
                             if ([segue.destinationViewController respondsToSelector:@selector(setImageTitle:)])
                                 [segue.destinationViewController performSelector:@selector(setImageTitle:) withObject:cell.textLabel.text];
                           
                             // adding picture to recent photos array in NSUserDefaults
                             
                             NSMutableArray *temporaryMutableArrayOfRecentPhotos =[[[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_PHOTOS] mutableCopy];
                             if (!temporaryMutableArrayOfRecentPhotos) temporaryMutableArrayOfRecentPhotos = [[NSMutableArray alloc] init];
                             if ([temporaryMutableArrayOfRecentPhotos containsObject:workingPhotoDictionary])
                                {
                                    [temporaryMutableArrayOfRecentPhotos removeObject:workingPhotoDictionary];
                                }
                             [temporaryMutableArrayOfRecentPhotos insertObject:workingPhotoDictionary atIndex:0];
                             [[NSUserDefaults standardUserDefaults] setObject:temporaryMutableArrayOfRecentPhotos forKey:RECENT_PHOTOS];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             break;
                         }
                     }
                 }
                 
         }
}
                    
- (NSString *)getFlickrIDForIndexPath:(NSIndexPath *)indexPath
{
    return nil; // abstract
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0; //abstract
}
- (NSString *)titleForRow:(NSUInteger)row
{
    return nil; //abstract
}

- (NSString *)subtitleForRow:(NSUInteger)row{
    return nil; //abstract
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
