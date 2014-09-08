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
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:((NSString *)dictionary[@"timestamp"]).longLongValue];
    self.weatherCondition = [[WeatherCondition alloc] initWithType:dictionary[@"weather_condition"] timestamp:self.timestamp];
    self.temperatureInFahrenheit = [NSNumber numberWithFloat:[dictionary[@"temp_in_fahrenheit"] floatValue]];
    
    return self;
}


- (NSString *)temperatureStringInFahrenheit
{
    return [NSString stringWithFormat:@"%@° F", _temperatureInFahrenheit];
}


- (NSString *)getHourString
{
    NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
    [hourFormat setDateFormat:@"h a"];
    
    return [hourFormat stringFromDate:_timestamp];
}

@end
