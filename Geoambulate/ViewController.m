//
//  ViewController.m
//  Geoambulate
//
//  Created by Kyle Stevens on 8/6/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

@import MapKit;
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *totalDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPercentageLabel;

@property (weak, nonatomic) IBOutlet UILabel *progressDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *remainingDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)disclosureButtonPressed:(UIButton *)sender {
}

@end
