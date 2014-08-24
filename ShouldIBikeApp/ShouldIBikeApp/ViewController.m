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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [[NetworkManager alloc] init];
    
    NSLog(@"Getting answer for 02025");
    
    [_manager getShouldIBikeAnswerWithZip:@"02025" callback:^(NSDictionary *dictionaryResponse) {
        NSLog(@"Response: %@", dictionaryResponse);
        _answer = [[BikeAnswer alloc] initWithDictionary:dictionaryResponse];
        
        switch (_answer.type) {
            case BikeAnswerTypeNo:
                NSLog(@"You shouldn't bike in %@. It's %@ing", _answer.city.name, _answer.nextTenHours.now.weatherCondition.name);
                break;
            
            case BikeAnswerTypeYes:
                NSLog(@"You should bike in %@.", _answer.city.name);
                break;
                
            case BikeAnswerTypeMaybe:
                NSLog(@"Maybe.");
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
