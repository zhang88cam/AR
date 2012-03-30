//
//  TurbineDetailViewController.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineDetailViewController.h"
#import "TurbineDataController.h"

@interface TurbineDetailViewController () <MKMapViewDelegate>
/*@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) TurbineDataController *dataController;
@property (retain, nonatomic) NSArray *annotations;

@property (retain, nonatomic) UIPopoverController *popoverController;
- (void)configureView;
 */
@end

@implementation TurbineDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;

/*
@synthesize masterPopoverController = _masterPopoverController;
@synthesize mapView = _mapView;
@synthesize dataController = _dataController;
@synthesize annotations = _annotations;

@synthesize popoverController = popoverController_;
@synthesize toolbar = toolbar_;
*/
- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    /*
    [_masterPopoverController release];
    [_mapView release];
    [_dataController release];
    [_annotations release];
    
    [popoverController_ release], popoverController_ = nil;
    [toolbar_ release], toolbar_ = nil;
    [toggleItem release];
    */
    [super dealloc];
}

//-(IBAction)toggleMasterView:(id)sender
//{
//    
//}
/*
#pragma mark - Synchronize Model and View

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.annotations) [self.mapView addAnnotations:self.annotations];
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self updateMapView];
}

- (void)setAnnotations:(NSArray *)annotations
{
    _annotations = annotations;
    [self updateMapView];
}

-(void)setDataController:(TurbineDataController *)dataController
{
//    _dataController = self.
    
}
*/
#pragma mark -
-(IBAction)doneAction:(id)sender
{
    //Back to Unity
//    [[NativeToolkit sharedManager] hideViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
/*

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}
*/
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
//    toggleItem.title = ([splitController_ isShowingMaster]) ? @"Hide Master" : @"Show Master";
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"done" 
																   style:UIBarButtonItemStyleDone 
																  target:self 
																  action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
    
    [self configureView];
//    self.mapView.delegate = self;

}

- (void)viewDidUnload
{
//    [self setMapView:nil];
//    [toggleItem release];
//    toggleItem = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Map", @"Map");
    }
    return self;
}
//							
//#pragma mark - Split view support
//
//-(void)splitViewController:(MGSplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
//{
//    if (barButtonItem) {
//        barButtonItem.title = @"Master";
//        NSMutableArray *items = [[self.toolbar items] mutableCopy];
//        [items insertObject:barButtonItem atIndex:0];
//        [self.toolbar setItems:items animated:YES];
//    }
//    
//    self.popoverController = nil;
//}
//
//-(void)splitViewController:(MGSplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController
//{
//    
//}

#pragma mark - Rotation support


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self configureView];
}

@end
