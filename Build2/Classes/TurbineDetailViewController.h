//
//  TurbineDetailViewController.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "MGSplitViewController.h"

@interface TurbineDetailViewController : UIViewController //<UIPopoverControllerDelegate, MGSplitViewControllerDelegate>
/*{
    //IBOutlet MGSplitViewController *splitController_;
    UIPopoverController *popoverController_;
    UIToolbar *toolbar_;
    IBOutlet UIBarButtonItem *toggleItem;
}

 */
@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
/*

@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;

-(IBAction)toggleMasterView:(id)sender;
 */

@end
