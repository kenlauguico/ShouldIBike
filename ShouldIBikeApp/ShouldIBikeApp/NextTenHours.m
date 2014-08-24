//
//  NextTenHours.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "NextTenHours.h"
#import "WeatherHour.h"
#import "WeatherHourNow.h"

@implementation NextTenHours

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < dictionary.count; i++) {
        switch (i) {
            case 0: {
                WeatherHourNow *weatherHourNow = [[WeatherHourNow alloc]
                                                  initWithDictionary:[dictionary objectForKey:@(i)]];
                [mutableArray addObject:weatherHourNow];
            } break;
                
            default: {
                WeatherHour *weatherHour = [[WeatherHour alloc] initWithDictionary:[dictionary objectForKey:@(i)]];
                [mutableArray addObject:weatherHour];
            } break;
        }
    }
    
    return self;
}

- (id)initWithWeatherHourNow:(WeatherHourNow *)weatherHourNow NextTenHours:(NSArray *)nextTenHours
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    [mutableArray addObject:weatherHourNow];
    
    for (NSDictionary *weatherHourDictionary in nextTenHours) {
        WeatherHour *weatherHour = [[WeatherHour alloc] initWithDictionary:weatherHourDictionary];
        [mutableArray addObject:weatherHour];
    }
    
    [self arrayByAddingObjectsFromArray:mutableArray];
    
    return self;
}

@end
