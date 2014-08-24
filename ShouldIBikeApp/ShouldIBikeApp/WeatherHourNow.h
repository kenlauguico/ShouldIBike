//
//  WeatherHourNow.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherHour.h"

@interface WeatherHourNow : WeatherHour

@property (strong, nonatomic) NSDate *sunriseTimestamp;
@property (strong, nonatomic) NSDate *sunsetTimestamp;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSString *windDirection;
@property (strong, nonatomic) NSNumber *windSpeedInMPH;
@property (strong, nonatomic) NSString *windChill;
@property (strong, nonatomic) NSNumber *precipitation;
@property (strong, nonatomic) NSNumber *precipitationPerHour;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
