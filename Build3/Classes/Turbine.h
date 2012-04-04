//
//  Turbine.h
//  Unity-iPhone
//
//  Created by Qiuhao Zhang on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define turbineModelKey     @"TurbineModel"
#define turbineHeightKey    @"TurbineHeight"

#define turbineLatitudeKey     @"TurbineLatitude"
#define turbineLongitudeKey    @"TurbineLongitude"
#define turbineAltitudeKey     @"TurbineAltitude"


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Turbine : NSObject <NSCoding, MKAnnotation> {
    
    NSString *turbineModel_;
    NSString *turbineHeight_;
    
    NSString *turbineLatitude_;
    NSString *turbineLongitude_;
    NSString *turbineAltitude_;

}

@property (nonatomic, retain) NSString *turbineModel;
@property (nonatomic, retain) NSString *turbineHeight;

@property (nonatomic, retain) NSString *turbineLatitude;
@property (nonatomic, retain) NSString *turbineLongitude;
@property (nonatomic, retain) NSString *turbineAltitude;




-(id)initWithName:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude;

@end
