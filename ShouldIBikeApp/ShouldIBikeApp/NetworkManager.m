//
//  NetworkManager.m
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import "NetworkManager.h"
#import <NSString+SBJSON.h>

NSString *hostURL = @"http://kenlauguico.com/shouldibike";

@implementation NetworkManager

- (void)getShouldIBikeAnswerWithZip:(NSString *)zip callback:(void (^)(NSDictionary *))callback
{
    self.manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"zip": zip};
    
    [self.manager GET:hostURL
            parameters:params
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSString *json = [operation responseString];
                   callback([json JSONValue]);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSString *json = [operation responseString];
                   callback([json JSONValue]);
               }];
}

@end
