//
//  ViewController.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkManager.h"

@class BikeAnswer;
@interface ViewController : UIViewController

@property (strong, nonatomic) NetworkManager *manager;
@property (strong, nonatomic) BikeAnswer *answer;

@end
