//
//  Goal.h
//  Geoambulate
//
//  Created by Kyle Stevens on 8/7/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface Goal : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, readonly) CLLocationCoordinate2D startCoord;
@property (nonatomic, readonly) CLLocationCoordinate2D endCoord;

@property (nonatomic, readonly) CLLocationDistance totalDistance;

@property (nonatomic) CLLocationDistance collectedDistance;
@property (nonatomic) NSUInteger collectedSteps;

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;

- (instancetype)initWithName:(NSString *)name startCoordinate:(CLLocationCoordinate2D)startCoord endCoordinate:(CLLocationCoordinate2D)endCoord;

- (NSUInteger)estimateTotalSteps;

@end
