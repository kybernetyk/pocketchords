//
//  Chord_LibraryAppDelegate.m
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright flux forge 2009. All rights reserved.
//

#import "Chord_LibraryAppDelegate.h"


@implementation Chord_LibraryAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize allChordsNavigationController;



- (void)applicationDidFinishLaunching:(UIApplication *)application 
{

	[window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

