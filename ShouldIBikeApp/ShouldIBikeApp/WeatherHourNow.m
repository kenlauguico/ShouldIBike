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
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"timestamp"]];
    self.weatherCondition = [[WeatherCondition alloc] initWithType:dictionary[@"weather_condition"] timestamp:self.timestamp];
    self.sunriseTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"sunrise_timestamp"]];
    self.sunsetTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"sunset_timestamp"]];
    self.temperatureInFahrenheit = dictionary[@"temperature_in_fahrenheit"];
    self.humidity = dictionary[@"humidity"];
    self.windDirection = dictionary[@"wind_direction"];
    self.windSpeedInMPH = dictionary[@"wind_speed_in_mph"];
    self.windChill = dictionary[@"wind_chill"];
    self.precipitation = dictionary[@"precipitation"];
    self.precipitationPerHour = dictionary[@"precipitation_per_hour"];
    
    return self;
}

@end
