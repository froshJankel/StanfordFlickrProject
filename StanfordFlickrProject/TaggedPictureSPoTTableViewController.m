//
//  TaggedPictureSPoTTableViewController.m
//  StanfordFlickrProject
//
//  Created by Joshua Frankel on 3/20/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import "TaggedPictureSPoTTableViewController.h"

@interface TaggedPictureSPoTTableViewController ()
@property (strong, nonatomic) NSArray *pictureArrayByTag; // of NSDictionaries

@end

@implementation TaggedPictureSPoTTableViewController

#define TITLE @"TITLE"
#define DESCRIPTION @"DESCRIPTION"
#define FLICKR_ID @"ID"


@synthesize tagToDisplay = _tagToDisplay;

- (void)setTagToDisplay:(NSString *)tagToDisplay
{
    tagToDisplay = [tagToDisplay lowercaseString];
    _tagToDisplay = tagToDisplay;
    self.navigationItem.title = [tagToDisplay capitalizedString];
    [self.tableView reloadData];
}

- (NSString *)tagToDisplay
{
    if (!_tagToDisplay) _tagToDisplay = @"";
    return _tagToDisplay;
}

- (NSArray *)pictureArrayByTag
{
    if (!_pictureArrayByTag)
    {
        NSMutableArray *pictureArrayByTag = [[NSMutableArray alloc] init];
        for (id photoDictionary in self.photoCollection)
        {
            if ([photoDictionary isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *workingPhotoDictionary = (NSDictionary *)photoDictionary;
                if ([workingPhotoDictionary[FLICKR_TAGS] isKindOfClass:[NSString class]])
                {
                    NSArray *tagArray = [workingPhotoDictionary[FLICKR_TAGS] componentsSeparatedByString:@" "];
                    if ([tagArray containsObject:self.tagToDisplay])
                    {
                        NSString *title;
                        NSString *description;
                        NSString *flickrID;
                        if (workingPhotoDictionary[FLICKR_PHOTO_TITLE])
                            title = [workingPhotoDictionary[FLICKR_PHOTO_TITLE] description];
                        else
                            title = @"";
                        if ([workingPhotoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION])
                            description = [[workingPhotoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] description];
                        else
                            description = @"";
                        if (workingPhotoDictionary[FLICKR_PHOTO_ID])
                            flickrID = [workingPhotoDictionary[FLICKR_PHOTO_ID] description];
                        else flickrID = @"";
                        NSDictionary *temporaryPhotoDictionary = @{TITLE:title,
                    DESCRIPTION:description,
                    FLICKR_ID:flickrID};
                        [pictureArrayByTag addObject:temporaryPhotoDictionary];
                    }
                }
            }
        }
        _pictureArrayByTag = pictureArrayByTag;
    }
    return _pictureArrayByTag;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pictureArrayByTag count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    NSString *title = [self.pictureArrayByTag[row][TITLE] description];
    return [title capitalizedString];
}


- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [self.pictureArrayByTag[row][DESCRIPTION] description];
}

- (NSString *)getFlickrIDForIndexPath:(NSIndexPath *)indexPath
{
       return self.pictureArrayByTag[indexPath.row][FLICKR_ID];
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
