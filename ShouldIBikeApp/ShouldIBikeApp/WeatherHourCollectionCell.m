//
//  WeatherHourCollectionCell.m
//  ShouldIBikeApp
//
//  Created by Ken on 9/7/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "WeatherHourCollectionCell.h"
#import "WeatherHour.h"
#import "WeatherCondition.h"
#import <UIButton+tintImage.h>

@implementation WeatherHourCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)createSubviewsWithWeatherHour:(WeatherHour *)weatherHour
{
    _weatherIcon = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 37, 37)];
    [_weatherIcon setImage:weatherHour.weatherCondition.iconImage forState:(UIControlStateNormal)];
    [_weatherIcon setImageTintColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:_weatherIcon];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 37, 42, 13)];
    _timeLabel.text = weatherHour.getHourString;
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont boldSystemFontOfSize:10];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
}

@end
