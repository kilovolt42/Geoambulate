//
//  ViewController.m
//  Geoambulate
//
//  Created by Kyle Stevens on 8/6/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

@import MapKit;
#import "ViewController.h"
#import "Goal.h"
#import "GeodesicPolylineSplitter.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *totalDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPercentageLabel;

@property (weak, nonatomic) IBOutlet UILabel *progressDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *remainingDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@property (nonatomic) Goal *currentGoal;
@property (nonatomic, readonly) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)setCurrentGoal:(Goal *)currentGoal {
	_currentGoal = currentGoal;
	[self updateUI];
}

@synthesize numberFormatter = _numberFormatter;
- (NSNumberFormatter *)numberFormatter {
	if (!_numberFormatter) {
		_numberFormatter = [[NSNumberFormatter alloc] init];
		_numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	}
	return _numberFormatter;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.mapView.delegate = self;
	
	CLLocationCoordinate2D vb = CLLocationCoordinate2DMake(36.850009, -75.976756);
	CLLocationCoordinate2D seattle = CLLocationCoordinate2DMake(47.601958, -122.330817);
	Goal *goal = [[Goal alloc] initWithName:@"Walk from VB to Seattle" startCoordinate:vb endCoordinate:seattle];
	goal.startDate = [NSDate dateWithTimeIntervalSince1970:16195 * 60 * 60 * 24];
	goal.endDate = [NSDate dateWithTimeIntervalSince1970:16520 * 60 * 60 * 24];
	goal.collectedSteps = 2950147.2;
	goal.collectedDistance = 983382.4;
	self.currentGoal = goal;
}

- (IBAction)disclosureButtonPressed:(UIButton *)sender {
}

- (void)updateUI {
	[self updateTotalLabels];
	[self updateProgressLabels];
	[self updateRemainingLabels];
	[self updateMap];
}

- (void)updateTotalLabels {
	MKDistanceFormatter *distanceFormatter = [[MKDistanceFormatter alloc] init];
	distanceFormatter.units = MKDistanceFormatterUnitsImperial;
	
	NSString *distance = [distanceFormatter stringFromDistance:self.currentGoal.totalDistance];
	self.totalDistanceLabel.text = distance;
	
	NSUInteger percent = self.currentGoal.collectedDistance / self.currentGoal.totalDistance * 100;
	self.totalPercentageLabel.text = [NSString stringWithFormat:@"%@%%", @(percent)];
}

- (void)updateProgressLabels {
	NSString *formattedStepsCount = [self.numberFormatter stringFromNumber:@(self.currentGoal.collectedSteps)];
	self.progressDistanceLabel.text = [NSString stringWithFormat:@"%@ steps", formattedStepsCount];
	
	NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.currentGoal.startDate];
	NSInteger dayCount = ((interval / 60) / 60) / 24;
	NSString *formattedDayCount = [self.numberFormatter stringFromNumber:@(dayCount)];
	self.progressTimeLabel.text = [NSString stringWithFormat:@"%@ days", formattedDayCount];
}

- (void)updateRemainingLabels {
	NSInteger stepCount = [self.currentGoal estimateTotalSteps] - self.currentGoal.collectedSteps;
	NSString *formattedStepCount = [self.numberFormatter stringFromNumber:@(stepCount)];
	self.remainingDistanceLabel.text = [NSString stringWithFormat:@"%@ steps", formattedStepCount];
	
	NSTimeInterval interval = [self.currentGoal.endDate timeIntervalSinceDate:[NSDate date]];
	NSInteger dayCount = ((interval / 60) / 60) / 24;
	NSString *formattedDayCount = [self.numberFormatter stringFromNumber:@(dayCount)];
	self.remainingTimeLabel.text = [NSString stringWithFormat:@"%@ days", formattedDayCount];
}

- (void)updateMap {
	NSArray *polylines = [GeodesicPolylineSplitter splitGeodesicPolylinesWithDistance:self.currentGoal.collectedDistance startCoordinate:self.currentGoal.startCoord endCoordinate:self.currentGoal.endCoord];
	[self.mapView addOverlays:polylines];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
	static BOOL isProgressLine = YES;
	
	if (![overlay isKindOfClass:[MKPolyline class]]) {
		return nil;
	}
	
	MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
	renderer.lineWidth = 5.0;
	renderer.alpha = 0.5;
	
	if (isProgressLine) {
		renderer.strokeColor = [UIColor greenColor];
	} else {
		renderer.strokeColor = [UIColor blueColor];
	}
	
	isProgressLine = !isProgressLine;
	
	return renderer;
}

@end
