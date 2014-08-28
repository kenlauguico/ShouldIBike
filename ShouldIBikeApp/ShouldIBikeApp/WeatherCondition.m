//
//  WeatherCondition.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherCondition.h"

NSString *const WeatherConditionTypeClear = @"Clear";
NSString *const WeatherConditionTypeRain = @"Rain";
NSString *const WeatherConditionTypeChanceOfRain = @"Chance of Rain";
NSString *const WeatherConditionTypeRainShowers = @"Rain Showers";
NSString *const WeatherConditionTypeDrizzle = @"Drizzle";
NSString *const WeatherConditionTypeLightDrizzle = @"Light Drizzle";
NSString *const WeatherConditionTypeHeavyDrizzle = @"Heavy Drizzle";
NSString *const WeatherConditionTypeLightRain = @"Light Rain";
NSString *const WeatherConditionTypeHeavyRain = @"Heavy Rain";
NSString *const WeatherConditionTyepPartlyCloudy = @"Partly Cloudy";

@implementation WeatherCondition


- (id)initWithType:(NSString *)type timestamp:(NSDate *)timestamp
{
    self.type = type;
    self.timestamp = timestamp;
    
    [self setIsDaytime];
    
    return self;
}


- (NSString *)name
{
    return self.type;
}


- (NSString *)getIconFileName
{
    if ([self.type isEqualToString:WeatherConditionTypeRain] ||
        [self.type isEqualToString:WeatherConditionTypeLightRain] ||
        [self.type isEqualToString:WeatherConditionTypeLightDrizzle] ||
        [self.type isEqualToString:WeatherConditionTypeDrizzle] ||
        [self.type isEqualToString:WeatherConditionTypeHeavyDrizzle] ||
        [self.type isEqualToString:WeatherConditionTypeChanceOfRain] ||
        [self.type isEqualToString:WeatherConditionTypeHeavyRain]) {
        return WeatherConditionTypeRain;
    }
    
    if ([self.type isEqualToString:WeatherConditionTypeClear]) {
        if ([self isDaytime]) {
            return @"Sun";
        } else {
            return @"Moon";
        }
    }
    
    return self.type;
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
    return [UIImage imageNamed:[NSString stringWithFormat:@"IconCondition%@.png", [self getIconFileName]]];
}

@end
