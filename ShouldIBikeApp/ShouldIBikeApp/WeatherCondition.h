//
//  WeatherCondition.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherCondition : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSDate *timestamp;
@property (nonatomic) BOOL isDaytime;

- (id)initWithType:(NSString *)type timestamp:(NSDate *)timestamp;
- (NSString *)name;
- (UIImage *)iconImage;
- (UIImage *)backgroundImage;

@end
