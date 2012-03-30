//
//  TestViewController.m
//  RootViewController
//
//  Created by Qiuhao Zhang on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestViewController.h"
#import "TurbineDetailViewController.h"
#import "TurbineMasterViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Load test view controller");
    // Do any additional setup after loading the view from its nib.
    TurbineMasterViewController *masterViewController = [[TurbineMasterViewController alloc] initWithNibName:@"TurbineMasterViewController" bundle:nil];
    UINavigationController *masterNavController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    TurbineDetailViewController *detailViewController = [[TurbineDetailViewController alloc] initWithNibName:@"TurbineDetailViewController" bundle:nil];
    UINavigationController *detailNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    self.delegate = detailViewController;
    self.viewControllers = [NSArray arrayWithObjects:masterNavController,detailNavController, nil];
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

@end
