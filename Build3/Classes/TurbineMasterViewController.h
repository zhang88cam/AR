//
//  TurbineMasterViewController.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TurbineDetailViewController;

@class TurbineDataController;

@interface TurbineMasterViewController : UITableViewController

@property (strong, nonatomic) TurbineDetailViewController *detailViewController;

@property (strong, nonatomic) TurbineDataController *dataController;

@end
