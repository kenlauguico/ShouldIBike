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
#import <UITintedButton/UIButton+tintImage.h>

@interface ViewController () <CLLocationManagerDelegate>

@end

@implementation ViewController


#pragma mark - ViewController Delegate Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [[NetworkManager alloc] init];
    
    [self setForegroundColor:[UIColor whiteColor]];
    
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


#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations firstObject];
    [self requestAnswerWithLocation:currentLocation];
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
        
        [_locationManager stopUpdatingLocation];
    }];
}


- (void)updateViewWithAnswer
{
    [UIView transitionWithView:self.view
                      duration:0.8
                       options:(UIViewAnimationOptionTransitionCrossDissolve)
                    animations:^{
                        NSString *friendlyAnswer;
                        
                        switch (_answer.type) {
                            case BikeAnswerTypeNo:
                                friendlyAnswer = [NSString stringWithFormat:@"You shouldn't bike in %@.", _answer.city.name];
                                break;
                                
                            case BikeAnswerTypeYes:
                                friendlyAnswer = [NSString stringWithFormat:@"It's okay to bike in %@.", _answer.city.name];
                                break;
                                
                            case BikeAnswerTypeMaybe:
                                friendlyAnswer = [NSString stringWithFormat:@"It might be okay to bike in %@.", _answer.city.name];
                                break;
                        }
                        
                        _answerLabel.text = friendlyAnswer;
                        [_weatherConditionButton setImage:_answer.nextTenHours.now.weatherCondition.image forState:(UIControlStateNormal)];
                        [_weatherConditionButton setImageTintColor:_answerLabel.textColor forState:(UIControlStateNormal)];
                    } completion:nil];
}


- (void)setForegroundColor:(UIColor *)color
{
    [_weatherConditionButton setImageTintColor:color forState:(UIControlStateNormal)];
    _answerLabel.textColor = color;
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
