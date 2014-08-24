//
//  WeatherHour.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherHour.h"

@implementation WeatherHour

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.weatherCondition = dictionary[@"weatherCondition"];
    self.timestamp = dictionary[@"timestamp"];
    self.temperatureInFahrenheit = dictionary[@"temperatureInFahrenheit"];
    
    return self;
}

@end
