//
//  TagSPoTTableViewController.m
//  StanfordFlickrProject
//
//  Created by Joshua Frankel on 3/19/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import "TagSPoTTableViewController.h"
#import "PictureSPoTTableViewController.h"

@interface TagSPoTTableViewController ()
@property (strong, nonatomic) NSArray *tagFrequency; // of NSDictionary

@end

@implementation TagSPoTTableViewController


#define TAG @"TAG"
#define FREQUENCY @"FREQUENCY"

- (NSArray *)tagFrequency
{
    if (!_tagFrequency)
    {
        NSMutableArray *tagFrequency = [[NSMutableArray alloc] init]; // of NSDictionaries
        NSMutableDictionary *temporaryTagFrequency = [[NSMutableDictionary alloc] init];
        for (id photoDictionary in self.photoCollection)
        {
            if ([photoDictionary isKindOfClass:[NSDictionary class]])
            {
                if ([photoDictionary[FLICKR_TAGS] isKindOfClass:[NSString class]])
                {
                    NSArray *tagArray = [photoDictionary[FLICKR_TAGS] componentsSeparatedByString:@" "];
                    for (int i = 0; i < [tagArray count]; i++)
                    {
                        if (![tagArray[i] isEqualToString:@"cs193pspot"]
                            && ![tagArray[i] isEqualToString:@"landscape"]
                            && ![tagArray[i] isEqualToString:@"portrait"])
                        {
                            if (!temporaryTagFrequency[tagArray[i]])
                            {   [temporaryTagFrequency setValue:@1 forKey:tagArray[i]];
                            }  else    {
                                int frequency = [temporaryTagFrequency[tagArray[i]] intValue];
                                frequency++;
                                [temporaryTagFrequency setValue:@(frequency) forKey:tagArray[i]];
                            }
                        }
                    }
                }
            }
        }
        for (NSString *key in temporaryTagFrequency)
        {
            NSDictionary *temporaryTagDictionary = @{TAG: key,
        FREQUENCY: temporaryTagFrequency[key]};
            [tagFrequency addObject:temporaryTagDictionary];
        }
        _tagFrequency = tagFrequency;
    }
    return _tagFrequency;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tagFrequency count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    NSString *title = [self.tagFrequency[row][TAG] description];
    return [title capitalizedString];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [self.tagFrequency[row][FREQUENCY] description];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
         {
             UITableViewCell *cell = sender;
             NSString *tag = cell.textLabel.text;
             tag = [tag lowercaseString];
             if ([segue.destinationViewController respondsToSelector:@selector(setTagToDisplay:)])
                 {
                    [segue.destinationViewController performSelector:@selector(setTagToDisplay:) withObject:tag];
                 }
             if ([segue.destinationViewController respondsToSelector:@selector(setPhotoCollection:)])
             {
                 [segue.destinationViewController performSelector:@selector(setPhotoCollection:) withObject:self.photoCollection];
             }
        }
}
@end
