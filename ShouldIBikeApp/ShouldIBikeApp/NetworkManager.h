//
//  NetworkManager.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class CLLocation;
@interface NetworkManager : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

- (void)getShouldIBikeAnswerWithZip:(NSString *)zip callback:(void (^)(NSDictionary *))callback;
- (void)getShouldIBikeAnswerWithLocation:(CLLocation *)location callback:(void (^)(NSDictionary *))callback;

@end
