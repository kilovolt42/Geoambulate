//
//  GoalTests.m
//  Geoambulate
//
//  Created by Kyle Stevens on 8/7/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

@import XCTest;
#import "Goal.h"

@interface GoalTests : XCTestCase

@property (nonatomic) CLLocationCoordinate2D vb;
@property (nonatomic) CLLocationCoordinate2D seattle;

@property (nonatomic) Goal *goal;

@end

@implementation GoalTests

- (void)setUp {
    [super setUp];
	
	_vb = CLLocationCoordinate2DMake(36.850009, -75.976756);
	_seattle = CLLocationCoordinate2DMake(47.601958, -122.330817);
	
	_goal = [[Goal alloc] initWithName:@"Walk to Seattle" startCoordinate:_vb endCoordinate:_seattle];
}

- (void)tearDown {
	_goal = nil;
    [super tearDown];
}

- (void)testGoalInitialization {
    XCTAssert(_goal, @"goal should exist");
	XCTAssert([_goal.name isEqualToString:@"Walk to Seattle"], @"goal should have correct name");
	XCTAssert(_goal.startCoord.latitude == _vb.latitude && _goal.startCoord.longitude == _vb.longitude, @"start coord should be vb");
	XCTAssert(_goal.endCoord.latitude == _seattle.latitude && _goal.endCoord.longitude == _seattle.longitude, @"start coord should be seatle");
}

- (void)testGoalArchiving {
	NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:_goal];
	XCTAssert(archivedData, @"there should be some archived data");
	
	Goal *unarchivedGoal = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
	XCTAssert(unarchivedGoal, @"there should be an unarchived goal object");
}

- (void)testStepEstimation {
	_goal.collectedSteps = 88;
	_goal.collectedDistance = 24.8;
	
	NSUInteger estimatedSteps = (88 / 24.8) * _goal.totalDistance;
	
	XCTAssertEqual([_goal estimateTotalSteps], estimatedSteps, @"estimated total steps should be equal");
}

@end
