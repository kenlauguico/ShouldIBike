//
//  ViewController.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "ViewController.h"
#import "BikeAnswer.h"
#import "WeatherHour.h"
#import "WeatherHourNow.h"
#import "WeatherCondition.h"
#import "City.h"
#import "NextTenHours.h"
#import "WeatherHourCollectionCell.h"
#import <UITintedButton/UIButton+tintImage.h>
#import <FXBlurView/FXBlurView.h>

@interface ViewController () <CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ViewController


#pragma mark - ViewController Delegate Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [[NetworkManager alloc] init];
    
    [_weatherHoursCollection registerClass:[WeatherHourCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    _weatherHoursCollection.delegate = self;
    
    [self setForegroundColor:[UIColor whiteColor]];
    [self removeTabBarShadow];
    [self setBlurryTabBar];
    [self resetLabels];
    
    _didGrabLocation = NO;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [_locationManager startUpdatingLocation];
    
    if ([self isiOS8]) {
        [_locationManager requestWhenInUseAuthorization];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - UICollectionViewDelegate & DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _answer.nextTenHours.nextHours ? 5 : 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WeatherHour *weatherHour = [_answer.nextTenHours.nextHours objectAtIndex:indexPath.item+1];
    [(WeatherHourCollectionCell *)cell createSubviewsWithWeatherHour:weatherHour];
    
    return cell;
}


#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations firstObject];
    
    if (!_didGrabLocation) {
        [self requestAnswerWithLocation:currentLocation];
        _didGrabLocation = YES;
    }
}


#pragma mark - IBActionMethods

- (IBAction)answerButtonPressed:(id)sender
{
    [_weatherDetailsLabel setHidden:!_weatherDetailsLabel.hidden];
}


#pragma mark - Private Methods

- (void)requestAnswerWithZip:(NSString *)zip
{
    [_manager getShouldIBikeAnswerWithZip:zip callback:^(NSDictionary *dictionaryResponse) {
        NSLog(@"Response: %@", dictionaryResponse);
        _answer = [[BikeAnswer alloc] initWithDictionary:dictionaryResponse];
        
        [self updateViewWithAnswer];
    }];
}


- (void)requestAnswerWithLocation:(CLLocation *)location
{
    [_manager getShouldIBikeAnswerWithLocation:location callback:^(NSDictionary *dictionaryResponse) {
        NSLog(@"Response: %@", dictionaryResponse);
        _answer = [[BikeAnswer alloc] initWithDictionary:dictionaryResponse];
        
        [self updateViewWithAnswer];
    }];
}


- (void)updateViewWithAnswer
{
    [UIView transitionWithView:self.view
                      duration:0.9
                       options:(UIViewAnimationOptionTransitionCrossDissolve)
                    animations:^{
                        
                        [self updateWeatherInformation];
                        [self updateWeatherImages];
                        [self.weatherHoursCollection reloadData];
                        
                    } completion:nil];
}


- (void)setForegroundColor:(UIColor *)color
{
    [_weatherConditionButton setImageTintColor:color forState:(UIControlStateNormal)];
    _answerButton.titleLabel.textColor = color;
    _answerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)removeTabBarShadow
{
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}


- (void)setBlurryTabBar
{

}


- (void)updateWeatherInformation
{
    WeatherHourNow *currentWeatherHour = _answer.nextTenHours.now;
    NSString *friendlyAnswer;
    
    switch (_answer.type) {
        case BikeAnswerTypeNo:
            friendlyAnswer = [NSString stringWithFormat:@"It's not okay bike in %@ +", _answer.city.name];
            break;
            
        case BikeAnswerTypeYes:
            friendlyAnswer = [NSString stringWithFormat:@"It's okay to bike in %@ +", _answer.city.name];
            break;
            
        case BikeAnswerTypeMaybe:
            friendlyAnswer = [NSString stringWithFormat:@"It might be okay to bike in %@ +", _answer.city.name];
            break;
    }
    
    [self setShouldIBikeAnswerLabel:friendlyAnswer];
    [self setDegreeLabel:[currentWeatherHour temperatureStringInFahrenheit]];
    [self setWeatherConditionLabel:currentWeatherHour.weatherCondition.name];
    [self setweatherDetailLabelWithWeather:currentWeatherHour];
}


- (void)setDegreeLabel:(NSString *)degrees
{
    _degreesLabel.text = degrees;
}


- (void)setWeatherConditionLabel:(NSString *)weatherCondition
{
    _conditionLabel.text = weatherCondition;
}


- (void)setShouldIBikeAnswerLabel:(NSString *)answer
{
    [_answerButton setTitle:answer forState:(UIControlStateNormal)];
}


- (void)setWeatherDetailLabel:(NSString *)details
{
    _weatherDetailsLabel.text = details;
}


- (void)setweatherDetailLabelWithWeather:(WeatherHourNow *)weatherNow
{
    NSString *weatherDetails = [NSString stringWithFormat:  @"Humidity: %@%%\n"
                                                            @"Wind Direction: %@\n"
                                                            @"Wind Speed: %@ MPH\n"
                                                            @"Wind Chill: %@\n"
                                                            @"Precipitation: %@ in",
                                weatherNow.humidity, weatherNow.windDirection, weatherNow.windSpeedInMPH, weatherNow.windChill, weatherNow.precipitation];
    
    [self setWeatherDetailLabel:weatherDetails];
}


- (void)updateWeatherImages
{
    WeatherHourNow *currentWeatherHour = _answer.nextTenHours.now;
    [_weatherConditionButton setImage:currentWeatherHour.weatherCondition.iconImage forState:(UIControlStateNormal)];
    [_weatherConditionButton setImageTintColor:_answerButton.titleLabel.textColor forState:(UIControlStateNormal)];
    [_weatherBackground setImage:currentWeatherHour.weatherCondition.backgroundImage];
}


- (void)resetLabels
{
    [self setDegreeLabel:@""];
    [self setWeatherConditionLabel:@""];
    [self setWeatherDetailLabel:@""];
}


- (BOOL)isiOS8
{
    if ([UIDevice.currentDevice.systemVersion isEqualToString:@"8.0"]) {
        return true;
    } else {
        return false;
    }
}

@end
