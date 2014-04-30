//
//  ReaderView.m
//  FlickrMap
//
//  Created by Hugo Poissonnet on 19/03/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import "ReaderView.h"

@interface ReaderView ()
@property (nonatomic,strong) UISwipeGestureRecognizer * previousPageRecognizer;
@property (nonatomic,strong) UISwipeGestureRecognizer * nextPageRecognizer;
@property (nonatomic,assign) int currentIndex;
@end

@implementation ReaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.previousPageRecognizer || !self.nextPageRecognizer){
        self.previousPageRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousPage)];
        self.previousPageRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:self.previousPageRecognizer];
        
        self.nextPageRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextPage)];
        self.nextPageRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:self.nextPageRecognizer];
        self.userInteractionEnabled = YES;
    }
}


- (void) previousPage{
    [self displayPageAtIndex:self.currentIndex-1];
}

- (void) nextPage{
    [self displayPageAtIndex:self.currentIndex+1];
}

-(void)displayPageAtIndex:(int)index
{
    NSLog(@"Display page ReaderView");
    if(index >= 0 && index < [self.delegate numberOfPages]){
        if(self.subviews.count){
            [self.subviews.lastObject removeFromSuperview];
        }
        [self addSubview:[self.delegate pageAtIndex:index]];
        self.currentIndex = index;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
