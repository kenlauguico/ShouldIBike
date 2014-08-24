//
//  WeatherHourNow.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherHourNow.h"

@implementation WeatherHourNow

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.weatherCondition = dictionary[@"weatherCondition"];
    self.timestamp = dictionary[@"timestamp"];
    self.sunriseTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"sunriseTimestamp"]];
    self.sunsetTimestamp = [NSDate dateWithTimeIntervalSince1970:(NSInteger)dictionary[@"sunsetTimestamp"]];
    self.temperatureInFahrenheit = dictionary[@"temperatureInFahrenheit"];
    self.humidity = dictionary[@"humidity"];
    self.windDirection = dictionary[@"windDirection"];
    self.windSpeedInMPH = dictionary[@"windSpeedInMPH"];
    self.windChill = dictionary[@"windChill"];
    self.precipitation = dictionary[@"precipitation"];
    self.precipitationPerHour = dictionary[@"precipitationPerHour"];
    
    return self;
}

@end
