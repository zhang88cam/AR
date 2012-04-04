//
//  TurbineMasterViewController.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineMasterViewController.h"

#import "TurbineDetailViewController.h"

#import "TurbineDataController.h"

#import "Turbine.h"

#import "TurbineEditViewController.h"

@interface TurbineMasterViewController () <TurbineEditViewControllerDelegate>

@end

@implementation TurbineMasterViewController

@synthesize detailViewController = _detailViewController;

@synthesize dataController = _dataController;


- (void)dealloc
{
    [_detailViewController release];
    [_dataController release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Turbines", @"Turbines");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        TurbineDataController *adataTurbineController = [[TurbineDataController alloc] init];
        self.dataController = adataTurbineController;
        [adataTurbineController release];
    }
    return self;
}
							

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - button

-(IBAction)add:(id)sender
{
 
    TurbineEditViewController *editController = [[TurbineEditViewController alloc] initWithNibName:@"TurbineEditViewController" bundle:nil];
    editController.delegate = self;
    editController.isAdd = YES;
    UINavigationController *editNavController = [[UINavigationController alloc] initWithRootViewController:editController];
    editNavController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:editNavController animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                  target:self 
                                  action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
#pragma mark - Table View Data Source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfMasterTurbineList];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    Turbine *turbineAtIndex = [self.dataController objectInMasterTurbineListAtIndex:indexPath.row];
    cell.detailTextLabel.text = [turbineAtIndex.turbineLatitude stringByAppendingString:turbineAtIndex.turbineLongitude];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [self.tableView reloadData];
//        [self.dataController removeTurbine:[self.dataController objectInMasterTurbineListAtIndex:indexPath.row]];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (!self.detailViewController) {
        self.detailViewController = [[[TurbineDetailViewController alloc] initWithNibName:@"TurbineDetailViewController" bundle:nil] autorelease];
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
     */
    
    TurbineEditViewController *editController = [[TurbineEditViewController alloc] initWithNibName:@"TurbineEditViewController" bundle:nil];
    UINavigationController *editNavController = [[UINavigationController alloc] initWithRootViewController:editController];
    editController.delegate = self;
    editController.isAdd = NO;
    editController.row = indexPath.row;
    editNavController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    Turbine *editingTurbine = [self.dataController objectInMasterTurbineListAtIndex:indexPath.row];
    [self.dataController removeTurbine:editingTurbine];
    [self presentModalViewController:editNavController animated:YES];

}

#pragma mark - Edit Turbine Delegate
- (void)turbineEditViewControllerDidCancel:(TurbineEditViewController *)controller
{
    [self.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)turbineEditViewControllerDidFinish:(TurbineEditViewController *)controller model:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude
{

    Turbine *newTurbine = [[Turbine alloc] init];
    newTurbine.turbineModel = model;
    newTurbine.turbineHeight = height;
    newTurbine.turbineLatitude = latitude;
    newTurbine.turbineLongitude = longitude;
    newTurbine.turbineAltitude = altitude;
    
    [self.dataController addTurbine:newTurbine];
    [newTurbine release];
    
    [self.tableView reloadData];

    [self dismissModalViewControllerAnimated:YES];
}

- (void)turbineEditViewControllerDidFinish:(TurbineEditViewController *)controller model:(NSString *)model height:(NSString *)height latitude:(NSString *)latitude longitude:(NSString *)longitude altitude:(NSString *)altitude atIndex:(NSInteger)index
{
    Turbine *newTurbine = [[Turbine alloc] init];
    newTurbine.turbineModel = model;
    newTurbine.turbineHeight = height;
    newTurbine.turbineLatitude = latitude;
    newTurbine.turbineLongitude = longitude;
    newTurbine.turbineAltitude = altitude;
    
    [self.dataController addTurbine:newTurbine atIndex:index];
    [newTurbine release];
    
    [self.tableView reloadData];
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
