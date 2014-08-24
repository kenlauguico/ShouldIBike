//
//  WeatherCondition.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherCondition.h"

NSString *const WeatherConditionTypeRain = @"rain";
NSString *const WeatherConditionTypeRainShowers = @"rain showers";
NSString *const WeatherConditionTypeFog = @"fog";
NSString *const WeatherConditionTypeThunderstorms = @"thunderstorms";
NSString *const WeatherConditionTypeNull = @"null";

@implementation WeatherCondition


- (id)initWithType:(NSString *)type timestamp:(NSDate *)timestamp
{
    self.type = type;
    self.timestamp = timestamp;
    
    return self;
}


- (NSString *)name
{
    if ([self.type isEqualToString:WeatherConditionTypeRain] ||
        [self.type isEqualToString:WeatherConditionTypeRainShowers]) {
        return @"Rain";
    }
    
    if ([self.type isEqualToString:WeatherConditionTypeFog]) {
        return @"Fog";
    }
    
    if ([self.type isEqualToString:WeatherConditionTypeThunderstorms]) {
        return @"Thunderstorms";
    }
    
    return (self.isDaytime) ? @"Sun" : @"Moon";
}

- (BOOL)setIsDaytime
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self.timestamp];
    NSInteger hour = [components hour];
    
    self.isDaytime = (hour >= 5 && hour <= 18);
    
    return self.isDaytime;
}


- (UIImage *)image
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"IconCondition%@.png", [self name]]];
}

@end
