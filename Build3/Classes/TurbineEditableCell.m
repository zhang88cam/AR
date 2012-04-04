//
//  TurbineEditableCell.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineEditableCell.h"

@implementation TurbineEditableCell

@synthesize titleLabel = titleLabel_;
@synthesize textField = textField_;
@synthesize  indexPath = indexPath_;
@synthesize delegate = delegate_;

#pragma mark -

- (void)dealloc
{
    [titleLabel_ release], titleLabel_ = nil;
    [textField_ release], textField_ = nil;
    [indexPath_ release], indexPath_ = nil;
    [delegate_ release], delegate_ = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 95, 25)];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [self.titleLabel setTextAlignment:UITextAlignmentRight];
        [self addSubview:self.titleLabel];
        
        self.textField = [[UITextField alloc] initWithFrame: CGRectMake(150, 10, 200, 25)];
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.textField.clearsOnBeginEditing = NO;
        [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.textField setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [self.textField setBackgroundColor:[UIColor clearColor]];
        //[_textField setFont:[UIFont systemFontOfSize:12]];
        
        // FOR MWF USE DONE
        self.textField.delegate = self;

		[self.textField setReturnKeyType:UIReturnKeyDone];
        
        [self addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [super setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField 
{
    
    [self.delegate performSelector:@selector(textFieldDidReturnWithIndexPath:) withObject:self.indexPath];
    
}

@end
