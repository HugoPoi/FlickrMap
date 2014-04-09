//
//  ReaderView.h
//  FlickrMap
//
//  Created by Hugo Poissonnet on 19/03/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReaderViewDelegate <NSObject>

- (int) numberOfPages;
- (UIView*) pageAtIndex:(int)index;

@end

@interface ReaderView : UIView

@property (nonatomic,weak) id<ReaderViewDelegate> delegate;

- (void) displayPageAtIndex:(int)index;

@end