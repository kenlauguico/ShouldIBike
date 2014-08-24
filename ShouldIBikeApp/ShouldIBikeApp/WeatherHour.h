//
//  WeatherHour.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherCondition;
@interface WeatherHour : NSObject

@property (strong, nonatomic) WeatherCondition *weatherCondition;
@property (strong, nonatomic) NSDate *timestamp;
@property (strong, nonatomic) NSNumber *temperatureInFahrenheit;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
