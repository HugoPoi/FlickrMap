//
//  City+CRUD.m
//  FlickrMap
//
//  Created by Hugo Poissonnet on 30/04/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import "City+CRUD.h"
#import "AppDelegate.h"
@implementation City (CRUD)

+ (instancetype) newCity
{
    City * city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:[self context]];
    [[self appDelegate] saveContext];
    return city;
}

-(void) destroy
{
    [[City context] deleteObject:self];
    [[City appDelegate] saveContext];
}

+ (NSArray*) allCities{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"City"];
    return [[self context] executeFetchRequest:request error:nil];
}

+ (AppDelegate*) appDelegate{
    return [[UIApplication sharedApplication] delegate];
}

+ (NSManagedObjectContext*) context
{
    return [[self appDelegate] managedObjectContext];
}
@end
