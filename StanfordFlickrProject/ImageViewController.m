//
//  ImageViewController.m
//  SPoT
//
//  Created by Joshua Frankel on 3/18/13.
//  Copyright (c) 2013 Joshua Frankel. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) BOOL hasZoomed;

@end

@implementation ImageViewController

- (void)setImageTitle:(NSString *)imageTitle
{
    _imageTitle = imageTitle;
    self.navigationItem.title = imageTitle;
}

-(void)setImage:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (void)resetImage
{
    if (self.scrollView) {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            self.scrollView.zoomScale = 1.0;
            self.scrollView.contentSize = image.size;
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            if (!self.hasZoomed) [self setFramePositionForImage:image];
        }
    }
}

- (void)setFramePositionForImage:(UIImage *)image
{
    if (self.scrollView)
    {
        [self.scrollView zoomToRect:CGRectMake(0, 0, image.size.width, image.size.height) animated:NO];
    }
    
}

- (void)viewDidLayoutSubviews
{
    if (!self.hasZoomed)
    {
        [self resetImage];
    }
        
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view   
{
    self.hasZoomed = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
