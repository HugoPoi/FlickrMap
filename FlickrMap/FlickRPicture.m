//
//  FlickRPicture.m
//  FlickrMap
//
//  Created by Hugo Poissonnet on 09/04/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import "FlickRPicture.h"
#define
@implementation FlickRPicture

- (NSURL *)url
{
    NSString * urlString = [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@.jpg",self.farm.intValue, self.server, self.pictureID, self.secret];
    return [NSURL URLWithString:urlString];
}
+ (NSArray *)pictureAroundLocation:(FlickRLocation)location
{
    NSString * urlString = [NSString stringWithFormat:@""];
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary * jsonAnswer = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray * pictures = [NSMutableArray arrayWithCapacity:[jsonAnswer[@"photos"][@"photo"] count]];
    
    for(NSDictionary * currentPicture in jsonAnswer[@"photos"][@"photo"])
    {
        FlickRPicture * picture = [[FlickRPicture alloc] init];
        picture.pictureID  = currentPicture[@"id"];
        picture.server  = currentPicture[@"server"];
        picture.title  = currentPicture[@"titile"];
        picture.secret  = currentPicture[@"secret"];
        picture.farm  = currentPicture[@"farm"];
    }
    
    return [NSArray arrayWithArray:pictures];
}
@end
