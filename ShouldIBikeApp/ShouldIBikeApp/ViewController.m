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
#import <pop/POP.h>

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
    [self resetView];
    
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
    [_weatherDetailsLabel setHidden:NO];
    [_weatherDetailsLabel setTag:!@(_weatherDetailsLabel.tag).boolValue];
    
    if (@(_weatherDetailsLabel.tag).boolValue) {
        [self showWeatherDetails];
    } else {
        [self hideWeatherDetails];
    }
}

- (void)showWeatherDetails
{
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fade.fromValue = @(0);
    fade.toValue = @(1);
    [_weatherDetailsLabel pop_addAnimation:fade forKey:@"fade"];
    
    POPSpringAnimation *slide = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    slide.fromValue = @(self.view.center.y);
    slide.toValue   = @(self.view.center.y+50);
    [_weatherDetailsLabel.layer pop_addAnimation:slide forKey:@"slideDown"];
}

- (void)hideWeatherDetails
{
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fade.fromValue = @(1);
    fade.toValue = @(0);
    [_weatherDetailsLabel pop_addAnimation:fade forKey:@"fade"];
    
    POPSpringAnimation *slide = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    slide.fromValue = @(self.view.center.y+50);
    slide.toValue   = @(self.view.center.y);
    [_weatherDetailsLabel.layer pop_addAnimation:slide forKey:@"slideDown"];
}


#pragma mark - Private Methods

- (void)requestAnswerWithZip:(NSString *)zip
{
    [_manager getShouldIBikeAnswerWithZip:zip callback:^(NSDictionary *dictionaryResponse) {
        NSLog(@"Response: %@", dictionaryResponse);
        _answer = [[BikeAnswer alloc] initWithDictionary:dictionaryResponse];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self updateViewWithAnswer];
            });
        });
    }];
}


- (void)requestAnswerWithLocation:(CLLocation *)location
{
    [_manager getShouldIBikeAnswerWithLocation:location callback:^(NSDictionary *dictionaryResponse) {
        NSLog(@"Response: %@", dictionaryResponse);
        _answer = [[BikeAnswer alloc] initWithDictionary:dictionaryResponse];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self updateViewWithAnswer];
            });
        });
    }];
}


- (void)updateViewWithAnswer
{
    [self updateWeatherInformation];
    [self updateWeatherImages];
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
    _separator.hidden = NO;
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
    
    [self.weatherHoursCollection reloadData];
    [self animateWeatherImages];
}


- (void)animateWeatherImages
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(129, 58, 63, 63)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(80, 58, 63, 63)];
    [_weatherConditionButton pop_addAnimation:anim forKey:@"moveLeft"];
    
    POPSpringAnimation *slideIn = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    slideIn.fromValue = [NSValue valueWithCGRect:CGRectMake(0, self.view.frame.size.height, 320, 91)];
    slideIn.toValue = [NSValue valueWithCGRect:CGRectMake(0, self.view.frame.size.height - 91, 320, 91)];
    [_weatherHoursCollection pop_addAnimation:slideIn forKey:@"slideIn"];
    
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fade.fromValue = @(0);
    fade.toValue = @(1);
    
    [_weatherConditionButton pop_addAnimation:fade forKey:@"fade"];
    [_degreesLabel pop_addAnimation:fade forKey:@"fade"];
    [_conditionLabel pop_addAnimation:fade forKey:@"fade"];
    [_weatherBackground pop_addAnimation:fade forKey:@"fade"];
}


- (void)resetView
{
    [self setDegreeLabel:@""];
    [self setWeatherConditionLabel:@""];
    [self setWeatherDetailLabel:@""];
    _separator.hidden = YES;
    
    _weatherBackground.frame = self.view.frame;
    _weatherHoursCollection.frame = CGRectMake(0, self.view.frame.size.height, 320, 91);
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
