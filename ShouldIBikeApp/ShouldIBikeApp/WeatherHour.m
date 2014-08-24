//
//  WeatherHour.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherHour.h"
#import "WeatherCondition.h"

@implementation WeatherHour

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"timestamp"]];
    self.weatherCondition = [[WeatherCondition alloc] initWithType:dictionary[@"weather_condition"] timestamp:self.timestamp];
    self.temperatureInFahrenheit = dictionary[@"temperature_in_fahrenheit"];
    
    return self;
}

@end
