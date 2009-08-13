//
//  Chord_LibraryAppDelegate.h
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright flux forge 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chord_LibraryAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	UINavigationController *allChordsNavigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *allChordsNavigationController;

@end
