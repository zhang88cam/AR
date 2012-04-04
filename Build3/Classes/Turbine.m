//
//  Turbine.m
//  Unity-iPhone
//
//  Created by Qiuhao Zhang on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Turbine.h"

@implementation Turbine

@synthesize turbineModel = _turbineModel;
@synthesize turbineHeight = _turbineHeight;
@synthesize turbineLatitude = _turbineLatitude;
@synthesize turbineLongitude = _turbineLongitude;
@synthesize turbineAltitude = _turbineAltitude;



-(id)initWithName:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude
{
    if ((self = [super init])) {
        _turbineModel = [model copy];
        _turbineHeight = [height copy];
        _turbineLatitude = [latitude copy];
        _turbineLongitude = [longitude copy];
        _turbineAltitude = [altitude copy];
    }
    return self;
}

#pragma mark -
#pragma mark NSCoding

-(void) encodeWithCoder:(NSCoder *)aCoder {
	
	[aCoder encodeObject:self.turbineModel forKey: turbineModelKey];
	[aCoder encodeObject:self.turbineHeight forKey: turbineHeightKey];
    
    [aCoder encodeObject:self.turbineLatitude forKey:turbineLatitudeKey];
    [aCoder encodeObject:self.turbineLongitude forKey:turbineLongitudeKey];
    [aCoder encodeObject:self.turbineAltitude forKey:turbineAltitudeKey];
	
}


- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if (self = [super init]) {
		self.turbineModel = [aDecoder decodeObjectForKey:turbineModelKey];
		self.turbineHeight = [aDecoder decodeObjectForKey:turbineHeightKey];
        
        self.turbineLatitude = [aDecoder decodeObjectForKey:turbineLatitudeKey];
		self.turbineLongitude = [aDecoder decodeObjectForKey:turbineLongitudeKey];
		self.turbineAltitude = [aDecoder decodeObjectForKey:turbineAltitudeKey];

	}
	
	return self;
	
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return self.turbineModel ;
}

- (NSString *)subtitle
{
    NSString *locations = [self.turbineLatitude stringByAppendingString:self.turbineLongitude];
    return locations;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.turbineLatitude doubleValue];
    coordinate.longitude = [self.turbineLongitude doubleValue];
    return coordinate;
}



-(void) dealloc {
	[_turbineModel release];
	[_turbineHeight release];
    
    [_turbineLatitude release];
	[_turbineLongitude release];
	[_turbineAltitude release];


	
	[super dealloc];
}

@end
