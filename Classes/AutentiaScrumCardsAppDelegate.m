//
//  AutentiaScrumCardsAppDelegate.m
//  AutentiaScrumCards
//
//  Created by rcanales on 06/02/10.
//  Copyright Autentia 2010. All rights reserved.
//

#import "AutentiaScrumCardsAppDelegate.h"
#import "MainViewController.h"

@implementation AutentiaScrumCardsAppDelegate


@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
    self.window.rootViewController = self.mainViewController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
