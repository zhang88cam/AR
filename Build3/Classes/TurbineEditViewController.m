//
//  TurbineEditViewController.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineEditViewController.h"

#import "TurbineEditableCell.h"

@interface TurbineEditViewController () <TurbineTextFieldDelgate>
@property (nonatomic, retain) NSArray *labels;
@property (nonatomic, retain) NSArray *placeholders;
@property (nonatomic, retain) NSMutableDictionary *textDictionary;
@end

@implementation TurbineEditViewController
@synthesize labels = _labels;
@synthesize placeholders = _placeholers;
@synthesize textDictionary = _textDictionary;
@synthesize isAdd = _isAdd;
@synthesize row = _row;

@synthesize delegate = _delegate;

- (void)dealloc
{
    [_labels release];
    [_placeholers release];
    [_textDictionary release];
    [_delegate release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)cancel:(id)sender
{
    [[self delegate] turbineEditViewControllerDidCancel:self];
}
-(IBAction)done:(id)sender
{
    if (self.isAdd) {
        [[self delegate] turbineEditViewControllerDidFinish:self model:[self.textDictionary objectForKey:[NSNumber numberWithInt:0]] height:[self.textDictionary objectForKey:[NSNumber numberWithInt:1]] latitude:[self.textDictionary objectForKey:[NSNumber numberWithInt:2]] longitude:[self.textDictionary objectForKey:[NSNumber numberWithInt:3]] altitude:[self.textDictionary objectForKey:[NSNumber numberWithInt:4]]];
    }
    else {
                [[self delegate] turbineEditViewControllerDidFinish:self model:[self.textDictionary objectForKey:[NSNumber numberWithInt:0]] height:[self.textDictionary objectForKey:[NSNumber numberWithInt:1]] latitude:[self.textDictionary objectForKey:[NSNumber numberWithInt:2]] longitude:[self.textDictionary objectForKey:[NSNumber numberWithInt:3]] altitude:[self.textDictionary objectForKey:[NSNumber numberWithInt:4]] atIndex:self.row];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"setting";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.labels = [NSArray arrayWithObjects:@"Model",
                   @"Height",
                   @"Latitude",
                   @"Longitude",
                   @"Altitude",
                   nil];
    
    self.placeholders = [NSArray arrayWithObjects:@"GE1.5",
                         @"200",
                         @"85.232",
                         @"-4343",
                         @"0",
                         nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"done" 
                                                                   style:UIBarButtonItemStyleDone 
                                                                  target:self 
                                                                  action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"cancel" 
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self 
                                                                  action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.labels count];
}

-(void)configueCell:(TurbineEditableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.titleLabel.text = [self.labels objectAtIndex:indexPath.row];
    cell.textField.placeholder = [self.placeholders objectAtIndex:indexPath.row]; 
    cell.indexPath = indexPath;
    cell.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
    TurbineEditableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TurbineEditableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
        
    // Configure the cell...
    [self configueCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Turbine text field delegate
-(void)textFieldDidReturnWithIndexPath:(NSIndexPath *)turbineIndexPath
{
      UITextField *textField = [(TurbineEditableCell *)[self.tableView cellForRowAtIndexPath:turbineIndexPath] textField];
    NSLog(@"------%@", textField.text);
    if (!_textDictionary) {
        self.textDictionary = [[NSMutableDictionary alloc] init];
    }
    NSNumber *rowNum = [[NSNumber alloc] initWithInt:turbineIndexPath.row];
    [self.textDictionary setObject:textField.text forKey:rowNum];
    [rowNum release];
}



@end
