//
//  Goal.m
//  Geoambulate
//
//  Created by Kyle Stevens on 8/7/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

#import "Goal.h"

@implementation Goal

- (instancetype)initWithName:(NSString *)name startCoordinate:(CLLocationCoordinate2D)startCoord endCoordinate:(CLLocationCoordinate2D)endCoord {
	self = [super init];
	if (self) {
		_name = name;
		_startCoord = startCoord;
		_endCoord = endCoord;
		
		CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:startCoord.latitude longitude:startCoord.longitude];
		CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:endCoord.latitude longitude:endCoord.longitude];
		_totalDistance = [startLocation distanceFromLocation:endLocation];
		
		_collectedDistance = 0.0;
		_collectedSteps = 0;
		
		_startDate = [NSDate date];
		_endDate = [_startDate copy];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];
	if (self) {
		_name = [decoder decodeObjectForKey:@"name"];
		_startDate = [decoder decodeObjectForKey:@"startDate"];
		_endDate = [decoder decodeObjectForKey:@"endDate"];
		_collectedSteps = [[decoder decodeObjectForKey:@"collectedSteps"] unsignedIntegerValue];
		
		[[decoder decodeObjectForKey:@"startCoord.latitude"] getValue:&_startCoord.latitude];
		[[decoder decodeObjectForKey:@"startCoord.longitude"] getValue:&_startCoord.longitude];
		[[decoder decodeObjectForKey:@"endCoord.latitude"] getValue:&_endCoord.latitude];
		[[decoder decodeObjectForKey:@"endCoord.longitude"] getValue:&_endCoord.longitude];
		[[decoder decodeObjectForKey:@"totalDistance"] getValue:&_totalDistance];
		[[decoder decodeObjectForKey:@"collectedDistance"] getValue:&_collectedDistance];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.startDate forKey:@"startDate"];
	[encoder encodeObject:self.endDate forKey:@"endDate"];
	[encoder encodeObject:[NSNumber numberWithUnsignedInteger:self.collectedSteps] forKey:@"collectedSteps"];
	
	[encoder encodeObject:[NSValue value:&_startCoord.latitude withObjCType:@encode(CLLocationDegrees)] forKey:@"startCoord.latitude"];
	[encoder encodeObject:[NSValue value:&_startCoord.longitude withObjCType:@encode(CLLocationDegrees)] forKey:@"startCoord.longitude"];
	[encoder encodeObject:[NSValue value:&_endCoord.latitude withObjCType:@encode(CLLocationDegrees)] forKey:@"endCoord.latitude"];
	[encoder encodeObject:[NSValue value:&_endCoord.longitude withObjCType:@encode(CLLocationDegrees)] forKey:@"endCoord.longitude"];
	[encoder encodeObject:[NSValue value:&_totalDistance withObjCType:@encode(CLLocationDistance)] forKey:@"totalDistance"];
	[encoder encodeObject:[NSValue value:&_collectedDistance withObjCType:@encode(CLLocationDistance)] forKey:@"collectedDistance"];
}

- (NSUInteger)estimateTotalSteps {
	double stepsPerDistance = 0.0;
	
	if (self.collectedDistance > 0.0) {
		stepsPerDistance = self.collectedSteps / self.collectedDistance;
	}
	
	double totalSteps = self.totalDistance * stepsPerDistance;
	return (NSUInteger)totalSteps;
}

@end
