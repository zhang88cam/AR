//
//  TurbineDataController.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineDataController.h"

#import "Turbine.h"

@interface TurbineDataController ()
-(void)initializeDefaultDataList;
@end

@implementation TurbineDataController

@synthesize masterTurbineList = _masterTurbineList;

-(void)dealloc
{
    [_masterTurbineList release];
    [super dealloc];
}

-(void)setMasterTurbineList:(NSMutableArray *)newList 
{
    if (_masterTurbineList != newList) {
        _masterTurbineList = [newList mutableCopy];
    }
    
}

-(void)initializeDefaultDataList
{
    NSMutableArray *turbineList = [[NSMutableArray alloc] init];
    self.masterTurbineList = turbineList;
    // read from prefab and add into it
    
    // random generate a turbine list
    for (int i = 0; i < 30; i ++) {
        Turbine *aTurbine = [[Turbine alloc] init];
        int y =  (arc4random() % 200) + 8523;
        float latitude = y / 100.0;
        int x = -(arc4random() % 200) - 4234;
        float longitude = x / 100.0;
        aTurbine.turbineModel = @"1";
        aTurbine.turbineHeight = @"200";
        aTurbine.turbineLatitude = [NSString stringWithFormat:@"%f", latitude];
        aTurbine.turbineLongitude = [NSString stringWithFormat:@"%f", longitude];
        aTurbine.turbineAltitude = @"0";
        [self addTurbine:aTurbine];
        [aTurbine release];
        
    }
    [turbineList release];
}

-(id)init
{
    if (self = [super init]) {
        [self initializeDefaultDataList];
         return self;
    }
    return nil;
}


-(NSInteger)countOfMasterTurbineList
{
    return [self.masterTurbineList count];
    
}

-(Turbine *)objectInMasterTurbineListAtIndex:(NSUInteger)index
{
    return [self.masterTurbineList objectAtIndex:index];
    
}

-(void)addTurbine:(Turbine *)newTurbine
{
    [self.masterTurbineList addObject:newTurbine];
    
}

-(void)removeTurbine:(Turbine *)oldTurbine
{
    [self.masterTurbineList removeObject:oldTurbine];
}

-(void)addTurbine:(Turbine *)newTurbine atIndex:(NSInteger)index
{
    [self.masterTurbineList insertObject:newTurbine atIndex:index];
}



@end
