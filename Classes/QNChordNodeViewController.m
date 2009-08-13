//
//  QNChordNodeViewController.m
//  Chord Library
//
//  Created by jrk on 13.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNChordNodeViewController.h"


@implementation QNChordNodeViewController
@synthesize nodeToView;

- (id) initWithNibName:(NSString *)nibNameOrNil andNodeToView: (QNChordNode*) node
{
    if (self = [super initWithNibName:nibNameOrNil bundle: nil]) 
	{
		nodeToView = node;
		//[self setTitle:@"fick dich opfer"];
		
    }
    return self;
	
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *fn = [NSString stringWithFormat:@"Diagrams/%@",[nodeToView chordDiagramFilename]];
	//[[NSBundle mainBundle] pathForResource:[node chordDiagramFilename] ofType:nil inDirectory:@"Diagrams"];
	NSLog(@"%@",fn);
	
	UIImage *img = [UIImage imageNamed: fn];
	NSLog(@"%@",img);
	//[img retain];
	
	[diagramView setImage: img];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	NSLog(@"bai from QNChordNodeViewController");
	[super dealloc];
}


@end
