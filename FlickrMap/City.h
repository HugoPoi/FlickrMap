//
//  City.h
//  FlickrMap
//
//  Created by Hugo Poissonnet on 30/04/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

@end
