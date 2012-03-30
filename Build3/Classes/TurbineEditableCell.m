//
//  TurbineEditableCell.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineEditableCell.h"

@implementation TurbineEditableCell

@synthesize titleLabel = _titleLabel;
@synthesize textField = _textField;
@synthesize  indexPath = _indexPath;
@synthesize delegate = _delegate;

- (void)dealloc
{
    [_titleLabel release];
    [_textField release];
    [_indexPath release];
    [_delegate release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 95, 25)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [_titleLabel setTextAlignment:UITextAlignmentRight];
        [self addSubview:_titleLabel];
        
        self.textField = [[UITextField alloc] initWithFrame: CGRectMake(150, 10, 200, 25)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _textField.clearsOnBeginEditing = NO;
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [_textField setBackgroundColor:[UIColor clearColor]];
        //[_textField setFont:[UIFont systemFontOfSize:12]];
        
        // FOR MWF USE DONE
        _textField.delegate = self;

		[_textField setReturnKeyType:UIReturnKeyDone];
        
        [self addSubview:_textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [super setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma - mark Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField 
{
    
    [self.delegate performSelector:@selector(textFieldDidReturnWithIndexPath:) withObject:_indexPath];
    
}

@end
