//
//  TurbineMasterViewController.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TurbineDataController;

@interface TurbineMasterViewController : UITableViewController
{
    TurbineDataController *dataController_;
}

@property (strong, nonatomic) TurbineDataController *dataController;

@end
