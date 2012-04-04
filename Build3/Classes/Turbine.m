//
//  Turbine.m
//  Unity-iPhone
//
//  Created by Qiuhao Zhang on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Turbine.h"

@implementation Turbine

@synthesize turbineModel = turbineModel_;
@synthesize turbineHeight = turbineHeight_;
@synthesize turbineLatitude = turbineLatitude_;
@synthesize turbineLongitude = turbineLongitude_;
@synthesize turbineAltitude = turbineAltitude_;


#pragma mark -
-(void) dealloc {
	[turbineModel_ release], turbineModel_ = nil;
	[turbineHeight_ release], turbineHeight_ = nil;
    
    [turbineLatitude_ release], turbineLatitude_ = nil;
	[turbineLongitude_ release], turbineLongitude_ = nil;
	[turbineAltitude_ release], turbineAltitude_ = nil;
    
    
	
	[super dealloc];
}

-(id)initWithName:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude
{
    if ((self = [super init])) {
        turbineModel_ = [model copy];
        turbineHeight_ = [height copy];
        turbineLatitude_ = [latitude copy];
        turbineLongitude_ = [longitude copy];
        turbineAltitude_ = [altitude copy];
    }
    return self;
}

#pragma mark - NSCoding

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



@end
