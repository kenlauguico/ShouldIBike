//
//  WeatherCondition.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherCondition.h"

NSString *const ShouldIBikeImageServer = @"http://kenlauguico.com/shouldibike/images/";

NSString *const WeatherConditionTypeClear = @"Clear";

NSString *const WeatherConditionTypeSnow = @"Snow";
NSString *const WeatherConditionTypeHail = @"Hail";

NSString *const WeatherConditionTypeRain = @"Rain";
NSString *const WeatherConditionTypeChanceOfRain = @"Chance of Rain";
NSString *const WeatherConditionTypeRainShowers = @"Rain Showers";
NSString *const WeatherConditionTypeDrizzle = @"Drizzle";
NSString *const WeatherConditionTypeLightDrizzle = @"Light Drizzle";
NSString *const WeatherConditionTypeHeavyDrizzle = @"Heavy Drizzle";
NSString *const WeatherConditionTypeLightRain = @"Light Rain";
NSString *const WeatherConditionTypeHeavyRain = @"Heavy Rain";

NSString *const WeatherConditionTypeFog = @"Fog";
NSString *const WeatherConditionTypeLightFog = @"Light Fog";
NSString *const WeatherConditionTypeHeavyFog = @"Heavy Fog";
NSString *const WeatherConditionTypePatchesOfFog = @"Patches of Fog";
NSString *const WeatherConditionTypeHaze = @"Haze";
NSString *const WeatherConditionTypeOvercast = @"Overcast";

NSString *const WeatherConditionTypeCloudy = @"Cloudy";
NSString *const WeatherConditionTypePartlyCloudy = @"Partly Cloudy";
NSString *const WeatherConditionTypeMostlyCloudy = @"Mostly Cloudy";
NSString *const WeatherConditionTypeScatteredClouds = @"Scattered Clouds";

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


- (NSString *)getFileName
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
    
    if ([self.type isEqualToString:WeatherConditionTypePartlyCloudy] ||
        [self.type isEqualToString:WeatherConditionTypeMostlyCloudy] ||
        [self.type isEqualToString:WeatherConditionTypeScatteredClouds]) {
        return [self isDaytime] ? WeatherConditionTypeCloudy : [@"Night" stringByAppendingString:WeatherConditionTypeCloudy];
    }
    
    if ([self.type isEqualToString:WeatherConditionTypeLightFog] ||
        [self.type isEqualToString:WeatherConditionTypeHeavyFog] ||
        [self.type isEqualToString:WeatherConditionTypePatchesOfFog] ||
        [self.type isEqualToString:WeatherConditionTypeHaze] ||
        [self.type isEqualToString:WeatherConditionTypeOvercast]) {
        return [self isDaytime] ? WeatherConditionTypeFog : [@"Night" stringByAppendingString:WeatherConditionTypeFog];
    }
    
    if ([self.type isEqualToString:WeatherConditionTypeHail]) {
        return WeatherConditionTypeSnow;
    }
    
    if (![self isDaytime]) {
        if ([self.type isEqualToString:WeatherConditionTypeClear]) {
            return [@"Night" stringByAppendingString:self.type];
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


- (UIImage *)iconImage
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"IconCondition%@.png", [self getFileName]]];
}


- (UIImage *)backgroundImage
{
    NSString *fullFileName = [NSString stringWithFormat:@"BackgroundCondition%@.png", [self getFileName]];
    NSString *backgroundImageURLString = [ShouldIBikeImageServer stringByAppendingString:fullFileName];
    NSURL *backgroundImageURL = [NSURL URLWithString:backgroundImageURLString];
    NSData *data = [NSData dataWithContentsOfURL:backgroundImageURL];
    
    return [UIImage imageWithData:data];
}

@end
