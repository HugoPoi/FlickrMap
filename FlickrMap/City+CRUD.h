//
//  City+CRUD.h
//  FlickrMap
//
//  Created by Hugo Poissonnet on 30/04/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import "City.h"

@interface City (CRUD)

+ (instancetype) newCity;
+ (NSArray*) allCities;

- (void) destroy;

@end
