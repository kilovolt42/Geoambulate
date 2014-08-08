//
//  GeodesicPolylineSplitter.h
//  Geoambulate
//
//  Created by Kyle Stevens on 8/7/14.
//  Copyright (c) 2014 kilovolt42. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface GeodesicPolylineSplitter : NSObject

+ (NSArray *)splitGeodesicPolylinesWithDistance:(CLLocationDistance)distance startCoordinate:(CLLocationCoordinate2D)start endCoordinate:(CLLocationCoordinate2D)end;

@end
