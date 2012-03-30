//
//  TurbineDataController.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Turbine;

@interface TurbineDataController : NSObject 

@property (nonatomic, copy) NSMutableArray *masterTurbineList;

-(NSInteger)countOfMasterTurbineList;
-(Turbine *)objectInMasterTurbineListAtIndex:(NSUInteger)index;
-(void)addTurbine:(Turbine *)newTurbine;
-(void)removeTurbine:(Turbine *)oldTurbine;
-(void)addTurbine:(Turbine *)newTurbine atIndex:(NSInteger)index;

@end
