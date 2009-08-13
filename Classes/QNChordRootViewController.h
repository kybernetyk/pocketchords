//
//  QNChordRootViewController.h
//  Chord Library
//
//  Created by jrk on 13.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNChordRoot.h"

@interface QNChordRootViewController : UIViewController 
{
	QNChordRoot *rootToView;
	NSArray *chordNodesInRoot;
}

@property (readonly) QNChordRoot *rootToView;

- (id) initWithNibName:(NSString *)nibNameOrNil andChordRoot: (QNChordRoot *) root;

@end
