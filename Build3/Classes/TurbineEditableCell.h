//
//  TurbineEditableCell.h
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TurbineEditableCell : UITableViewCell <UITextFieldDelegate>
{
    UILabel *titleLabel_;
    UITextField *textField_;
    NSIndexPath *indexPath_;
    id delegate_;
    
}

@property(nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) id delegate;

@end

@protocol TurbineTextFieldDelgate 

-(void)textFieldDidReturnWithIndexPath:(NSIndexPath *)turbineIndexPath;
//-(void)textFieldDidBeginEditingWighIndexPath:(NSIndexPath *)turbineIndexPath;
//-(void)updateTextLabelAtIndexPath:(NSIndexPath *)turbineIndexPath title:(NSString *)textLabel;
@end