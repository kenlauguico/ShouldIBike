//
//  ViewController.h
//  ShouldIBikeApp
//
//  Created by Ken on 8/24/14.
//  Copyright (c) 2014 Ken Lauguico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NetworkManager.h"

@class BikeAnswer;
@interface ViewController : UIViewController

@property (strong, nonatomic) NetworkManager *manager;
@property (strong, nonatomic) BikeAnswer *answer;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) BOOL didGrabLocation;
@property (strong, nonatomic) IBOutlet UIButton *weatherConditionButton;
@property (strong, nonatomic) IBOutlet UIButton *answerButton;
@property (strong, nonatomic) IBOutlet UIView *separator;
@property (strong, nonatomic) IBOutlet UILabel *degreesLabel;
@property (strong, nonatomic) IBOutlet UILabel *conditionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherBackground;
@property (strong, nonatomic) IBOutlet UILabel *weatherDetailsLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *weatherHoursCollection;

- (IBAction)answerButtonPressed:(id)sender;

@end
