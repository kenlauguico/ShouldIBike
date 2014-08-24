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
    self.manager = [[NetworkManager alloc] init];
    
    NSLog(@"Getting answer for 02025");
    
    [self.manager getShouldIBikeAnswerWithZip:@"02025" callback:^(NSDictionary *dictionaryResponse) {
        NSLog(@"Response: %@", dictionaryResponse);
        BikeAnswer *answer = [[BikeAnswer alloc] initWithDictionary:dictionaryResponse];
        
        switch (answer.type) {
            case BikeAnswerTypeNo:
                NSLog(@"You shouldn't bike in %@. It's %@ing", answer.city.name, answer.nextTenHours.now.weatherCondition.name);
                break;
            
            case BikeAnswerTypeYes:
                NSLog(@"You should bike in %@.", answer.city.name);
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
