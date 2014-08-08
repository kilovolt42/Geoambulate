//
//  GeodesicPolylineSplitter.m
//  Geoambulate
//
//  Created by Kyle Stevens on 8/7/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

#import "GeodesicPolylineSplitter.h"
@import MapKit;

@implementation GeodesicPolylineSplitter

+ (NSArray *)splitGeodesicPolylinesWithDistance:(CLLocationDistance)distance startCoordinate:(CLLocationCoordinate2D)start endCoordinate:(CLLocationCoordinate2D)end {
	CLLocationCoordinate2D primaryCoordinates[2] = { start, end };
	MKGeodesicPolyline *primaryLine = [MKGeodesicPolyline polylineWithCoordinates:primaryCoordinates count:2];
	
	CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:start.latitude longitude:start.longitude];
	CLLocation *midLocation;
	
	CLLocationDistance measuredDistance = 0.0;
	MKMapPoint point;
	CLLocationCoordinate2D coordinate;
	
	for (int i = 0; i < primaryLine.pointCount; i++) {
		point = primaryLine.points[i];
		coordinate = MKCoordinateForMapPoint(point);
		midLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
		measuredDistance = [midLocation distanceFromLocation:startLocation];
		
		if (measuredDistance >= distance) {
			break;
		}
	}
	
	CLLocationCoordinate2D progressCoordinates[2] = { start, coordinate };
	CLLocationCoordinate2D remainderCoordinates[2] = { coordinate, end };
	
	MKGeodesicPolyline *progressLine = [MKGeodesicPolyline polylineWithCoordinates:progressCoordinates count:2];
	MKGeodesicPolyline *remainderLine = [MKGeodesicPolyline polylineWithCoordinates:remainderCoordinates count:2];
	
	return @[progressLine, remainderLine];
}

@end
