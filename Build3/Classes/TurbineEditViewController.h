//
//  TurbineEditViewController.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TurbineEditViewControllerDelegate;

@interface TurbineEditViewController : UITableViewController
{
    BOOL isAdd_;
    NSInteger row_;
    id <TurbineEditViewControllerDelegate> delegate_;
}

@property (nonatomic) BOOL isAdd;
@property (nonatomic) NSInteger row;
@property (assign, nonatomic) id <TurbineEditViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end

@protocol TurbineEditViewControllerDelegate <NSObject>
- (void)turbineEditViewControllerDidCancel:(TurbineEditViewController *)controller;
- (void)turbineEditViewControllerDidFinish:(TurbineEditViewController *)controller model:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude;
- (void)turbineEditViewControllerDidFinish:(TurbineEditViewController *)controller model:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude atIndex:(NSInteger)index;
@end
