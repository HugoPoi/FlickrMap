//
//  PictureViewController.m
//  FlickrMap
//
//  Created by Hugo Poissonnet on 19/03/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import "PictureViewController.h"
#import "ReaderView.h"

@interface PictureViewController () <ReaderViewDelegate>

@property (weak, nonatomic) IBOutlet ReaderView *readerView;
@property (strong, nonatomic) NSArray* pictures;

@end

@implementation PictureViewController

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
    
    FlickRLocation location;
    location.latitude = 48.845726;
    location.longitude = 2.385017;
    location.radius = 1;
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.backgroundColor = [UIColor blackColor];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        self.pictures = [FlickRPicture pictureAroundLocation:location];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.readerView.delegate = self;
            [self.readerView displayPageAtIndex:0];
            [indicator stopAnimating];
        });
    });
    
    
    //self.readerView.delegate = self;
}
- (UIView *)pageAtIndex:(int)index{
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = self.readerView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.title = @"Chargement ...";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        
        FlickRPicture * picture = self.pictures[index];
        //NSLog(picture.url);
        NSData * imageData = [NSData dataWithContentsOfURL:picture.url];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            UIImage * image = [UIImage imageWithData:imageData];
            imageView.image = image;
            self.title = picture.title;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
    });
    
    return imageView;
}
- (int) numberOfPages{
    return self.pictures.count;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.readerView displayPageAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
