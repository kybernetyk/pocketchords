//
//  QNChordNodeViewController.h
//  Chord Library
//
//  Created by jrk on 13.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNChordNode.h"

@interface QNChordNodeViewController : UIViewController 
{
	QNChordNode *nodeToView;
	
	IBOutlet UIImageView *diagramView;
}

@property (readonly) QNChordNode *nodeToView;
- (id) initWithNibName:(NSString *)nibNameOrNil andNodeToView: (QNChordNode*) node;

@end
