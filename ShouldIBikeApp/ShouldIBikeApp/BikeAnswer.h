//
//  BikeAnswer.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    BikeAnswerTypeNo = 0,
    BikeAnswerTypeYes,
    BikeAnswerTypeMaybe,
};
typedef int BikeAnswerType;


@class City, NextTenHours;
@interface BikeAnswer : NSObject

@property (strong, nonatomic) City *city;
@property (nonatomic) BikeAnswerType type;
@property (strong, nonatomic) NextTenHours *nextTenHours;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)friendlyAnswer;

@end
