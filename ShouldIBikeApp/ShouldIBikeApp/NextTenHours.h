//
//  NextTenHours.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherHourNow;
@interface NextTenHours : NSArray

@property (strong, nonatomic) WeatherHourNow *now;

- (id)initWithWeatherHourNow:(WeatherHourNow *)weatherHourNow NextTenHours:(NSArray *)nextTenHours;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
