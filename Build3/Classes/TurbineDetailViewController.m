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
#import "Turbine.h"
#import "NativeToolkit.h"
#import <MapKit/MapKit.h>

@interface TurbineDetailViewController () <MKMapViewDelegate>
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) UIPopoverController *popoverController;
@property (retain, nonatomic) NSArray *annotations;

- (void)configureView;
@end

@implementation TurbineDetailViewController


@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize popoverController = popoverController_;


- (void)dealloc
{

    [_mapView release];
    [popoverController_ release], popoverController_ = nil;
    [_annotations release];

    [super dealloc];
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

- (void)configureView
{
    // Update the user interface for the detail item.
    
    
}
#pragma mark - Button
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
    
//    [self configureView];

}

- (void)viewDidUnload
{
    [self setMapView:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.586817;
    zoomLocation.longitude= -87.475247;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 5.0 * METERS_PER_MILE, 5.0 * METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    [_mapView setRegion:adjustedRegion animated:YES];   
    
    [self updateMapView];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

						
#pragma mark - SplitView Support

-(void)splitViewController:(MGSplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{

    
    self.popoverController = pc;
}

- (void)splitViewController:(MGSplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{

    self.popoverController = nil;
}

-(void)splitViewController:(MGSplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController
{
    
}

#pragma mark - MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[Turbine class]]) // for Golden Gate Bridge
    {
        // try to dequeue an existing pin view first
        static NSString* TurbineAnnotationIdentifier = @"turbineAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:TurbineAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:TurbineAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            

            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
    /*
    
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
//        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        // could put a rightCalloutAccessoryView here
    }
    
//    aView.annotation = annotation;
    aView.enabled = YES;
//    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    
    return aView;
     */
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
//{
//    UIImage *image = [self.delegate mapViewController:self imageForAnnotation:aView.annotation];
//    [(UIImageView *)aView.leftCalloutAccessoryView setImage:image];
//}

/*
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"callout accessory tapped for annotation %@", [view.annotation title]);
}
*/

#pragma mark - Rotation Support


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//	[self configureView];
}

@end
