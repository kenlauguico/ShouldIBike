//
//  WeatherHourNow.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherHourNow.h"
#import "WeatherCondition.h"

@implementation WeatherHourNow

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:((NSString *)dictionary[@"timestamp"]).longLongValue];
    self.weatherCondition = [[WeatherCondition alloc] initWithType:dictionary[@"weather_condition"] timestamp:self.timestamp];
    self.sunriseTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"sunrise_timestamp"]];
    self.sunsetTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"sunset_timestamp"]];
    self.temperatureInFahrenheit = [NSNumber numberWithFloat:[dictionary[@"temp_in_fahrenheit"] floatValue]];
    self.humidity = [NSNumber numberWithFloat:[dictionary[@"humidity"] floatValue]];
    self.windDirection = dictionary[@"wind_direction"];
    self.windSpeedInMPH = [NSNumber numberWithFloat:[dictionary[@"wind_speed_in_mph"] floatValue]];
    self.windChill = dictionary[@"wind_chill"];
    self.precipitation = [NSNumber numberWithFloat:[dictionary[@"precipitation"] floatValue]];
    self.precipitationPerHour = [NSNumber numberWithFloat:[dictionary[@"precipitation_per_hour"] floatValue]];
    
    return self;
}

@end
