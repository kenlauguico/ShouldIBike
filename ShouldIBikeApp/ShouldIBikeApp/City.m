//
//  City.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "City.h"

@implementation City

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.name = dictionary[@"name"];
    self.zip = dictionary[@"zip"];
    self.location = [[CLLocation alloc]
                     initWithLatitude:((NSString *)dictionary[@"lat"]).doubleValue
                     longitude:((NSString *)dictionary[@"lng"]).doubleValue];
    
    return self;
}

@end
