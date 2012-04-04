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
        int x =  -(arc4random() % 20) - 8735;
        int y = (arc4random() % 20) + 4150;
        float latitude = y / 100.0;
        float longitude = x / 100.0;
        NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
        NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
        Turbine *aTurbine = [[Turbine alloc] initWithName:@"1" height:@"200" latitude:latitudeString longitude:longitudeString altitude:@"0"];

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
