//
//  City.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *zip;
@property (strong, nonatomic) CLLocation *location;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
