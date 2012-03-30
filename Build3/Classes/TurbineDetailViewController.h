//
//  TurbineDetailViewController.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"

#define METERS_PER_MILE 1609.344

@interface TurbineDetailViewController : UIViewController <UIPopoverControllerDelegate, MGSplitViewControllerDelegate>
{
    UIPopoverController *popoverController_;

}


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;



@end
