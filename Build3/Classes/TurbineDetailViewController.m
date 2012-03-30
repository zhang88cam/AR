//
//  TurbineDetailViewController.m
//  TurbineGUI
//
//  Created by Qiuhao Zhang on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TurbineDetailViewController.h"
#import "TurbineMasterViewController.h"
#import "TurbineDataController.h"
#import "NativeToolkit.h"
#import <MapKit/MapKit.h>

@interface TurbineDetailViewController () <MKMapViewDelegate>
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) UIPopoverController *popoverController;
@property (retain, nonatomic) NSArray *annotations;

- (void)configureView;
@end

@implementation TurbineDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize popoverController = popoverController_;


- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [_mapView release];
    [popoverController_ release], popoverController_ = nil;
    [_annotations release];

    [super dealloc];
}


#pragma mark - Synchronize Model and View

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.annotations) [self.mapView addAnnotations:self.annotations];
}

//- (void)setMapView:(MKMapView *)mapView
//{
//    _mapView = mapView;
//    [self updateMapView];
//}

//- (void)setAnnotations:(NSArray *)annotations
//{
//    _annotations = annotations;
//    [self updateMapView];
//}

#pragma mark -
-(IBAction)doneAction:(id)sender
{
    //Back to Unity
    [[NativeToolkit sharedManager] hideViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(IBAction)showMasterPopover:(id)sender
{
    [self.popoverController presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
    
    UIBarButtonItem *masterButton = [[UIBarButtonItem alloc] initWithTitle:@"Master" style:UIBarButtonItemStyleDone target:self action:@selector(showMasterPopover:)];
    self.navigationItem.leftBarButtonItem = masterButton;
    [masterButton release];
    
    [self configureView];
    self.mapView.delegate = self;
//    NSLog(@"annotations are: %@", self.annotations);
    [self.mapView addAnnotations:self.annotations];


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
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.586817;
    zoomLocation.longitude= -87.475247;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];      
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
        TurbineMasterViewController *masterPopoverTurbineVC = [[TurbineMasterViewController alloc] initWithNibName:@"TurbineMasterViewController" bundle:nil];
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:masterPopoverTurbineVC];
        self.annotations = masterPopoverTurbineVC.dataController.masterTurbineList;
    }
    return self;
}
						
#pragma mark - Split view support

-(void)splitViewController:(MGSplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
//    if (barButtonItem) {
//        barButtonItem.title = @"Master";
//        NSMutableArray *items = [[self.toolbar items] mutableCopy];
//        [items insertObject:barButtonItem atIndex:0];
//        [self.toolbar setItems:items animated:YES];
//    }
    
    self.popoverController = pc;
}

- (void)splitViewController:(MGSplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	
//	if (barButtonItem) {
//		NSMutableArray *items = [[self.toolbar items] mutableCopy];
//		[items removeObject:barButtonItem];
//		[self.toolbar setItems:items animated:YES];
//		[items release];
//	}
    self.popoverController = nil;
}

-(void)splitViewController:(MGSplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController
{
    
}
#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        // could put a rightCalloutAccessoryView here
    }
    
    aView.annotation = annotation;
    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    
    return aView;
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
//{
//    UIImage *image = [self.delegate mapViewController:self imageForAnnotation:aView.annotation];
//    [(UIImageView *)aView.leftCalloutAccessoryView setImage:image];
//}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"callout accessory tapped for annotation %@", [view.annotation title]);
}


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
