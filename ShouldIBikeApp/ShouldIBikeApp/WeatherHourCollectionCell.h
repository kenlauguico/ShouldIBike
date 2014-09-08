//
//  WeatherHourCollectionCell.h
//  ShouldIBikeApp
//
//  Created by Ken on 9/7/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherHour;
@interface WeatherHourCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIButton *weatherIcon;
@property (strong, nonatomic) UILabel *timeLabel;

- (void)createSubviewsWithWeatherHour:(WeatherHour *)weatherHour;

@end
