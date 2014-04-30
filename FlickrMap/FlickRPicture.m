//
//  FlickRPicture.m
//  FlickrMap
//
//  Created by Hugo Poissonnet on 09/04/2014.
//  Copyright (c) 2014 Hugo Poissonnet. All rights reserved.
//

#import "FlickRPicture.h"
//TODO add define apiKey
#define apiKey @"ade96f6829acf5cc181e4ee6483e92a3"
@implementation FlickRPicture

- (NSURL *)url
{
    NSString * urlString = [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@.jpg",self.farm.intValue, self.server, self.pictureID, self.secret];
    return [NSURL URLWithString:urlString];
}
+ (NSArray *)pictureAroundLocation:(FlickRLocation)location
{
    //TODO add url from flickR seach, and replace in string Location (struc) and your ApiKey
    NSString * urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%f&lon=%f&radius=%i&format=json&nojsoncallback=1", apiKey, location.latitude, location.longitude, location.radius];
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary * jsonAnswer = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray * pictures = [NSMutableArray arrayWithCapacity:[jsonAnswer[@"photos"][@"photo"] count]];
    
    for(NSDictionary * currentPicture in jsonAnswer[@"photos"][@"photo"])
    {
        FlickRPicture * picture = [[FlickRPicture alloc] init];
        picture.pictureID  = currentPicture[@"id"];
        picture.server  = currentPicture[@"server"];
        picture.title  = currentPicture[@"title"];
        picture.secret  = currentPicture[@"secret"];
        picture.farm  = currentPicture[@"farm"];
    }
    
    return [NSArray arrayWithArray:pictures];
}
@end
