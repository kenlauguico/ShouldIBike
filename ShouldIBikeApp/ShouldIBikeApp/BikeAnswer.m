//
//  BikeAnswer.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "BikeAnswer.h"
#import "WeatherHour.h"
#import "WeatherHourNow.h"
#import "City.h"
#import "NextTenHours.h"

@implementation BikeAnswer

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.city = [[City alloc] initWithDictionary:dictionary[@"city"]];
    self.type = (BikeAnswerType)((NSString *)dictionary[@"answer_type"]).intValue;
    self.nextTenHours = [[NextTenHours alloc] initWithDictionary:dictionary[@"next_ten"]];
    
    return self;
}

- (NSString *)friendlyAnswer
{
    NSString *answer;
    
    switch (_type) {
        case BikeAnswerTypeNo:
            answer = [NSString stringWithFormat:@"Don't bike in %@", _city.name];
            break;
            
        case BikeAnswerTypeYes:
            answer = [NSString stringWithFormat:@"It's okay to bike in %@", _city.name];
            break;
            
        case BikeAnswerTypeMaybe:
            answer = [NSString stringWithFormat:@"It might be okay to bike in %@", _city.name];
            break;
    }
    
    return answer;
}

@end
