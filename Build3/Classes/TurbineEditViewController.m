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
{
    NSArray *labels_;
    NSArray *placeholders_;
    NSMutableDictionary *textDictionary_;
}

@property (nonatomic, retain) NSArray *labels;
@property (nonatomic, retain) NSArray *placeholders;
@property (nonatomic, retain) NSMutableDictionary *textDictionary;
@end


@implementation TurbineEditViewController
// public prooerties
@synthesize isAdd = isAdd_;
@synthesize row = row_;
@synthesize delegate = delegate_;

// Private properties
@synthesize labels = labels_;
@synthesize placeholders = placeholders_;
@synthesize textDictionary = textDictionary_;


#pragma mark -
- (void)dealloc
{
    [labels_ release], labels_ = nil;
    [placeholders_ release], placeholders_ = nil;
    [textDictionary_ release], textDictionary_ = nil;
    [delegate_ release], delegate_ = nil;
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

#pragma mark - Button

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

#pragma mark - Life Cycle

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
                         @"41.2324",
                         @"-87.2324",
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
    self.delegate = nil;
    self.labels = nil;
    self.placeholders = nil;
    self.textDictionary = nil;

}

#pragma mark - Rotation Support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table View Data Source

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

#pragma mark - Turbine Text Field Delegate
-(void)textFieldDidReturnWithIndexPath:(NSIndexPath *)turbineIndexPath
{
      UITextField *textField = [(TurbineEditableCell *)[self.tableView cellForRowAtIndexPath:turbineIndexPath] textField];
    NSLog(@"------%@", textField.text);
    if (!textDictionary_) {
        self.textDictionary = [[NSMutableDictionary alloc] init];
    }
    NSNumber *rowNum = [[NSNumber alloc] initWithInt:turbineIndexPath.row];
    [self.textDictionary setObject:textField.text forKey:rowNum];
    [rowNum release];
}



@end
