//
//  QNChordRootViewController.m
//  Chord Library
//
//  Created by jrk on 13.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNChordRootViewController.h"
#import "QNChordNodeViewController.h"
#import "QNChordNode.h"
#import "ChordTypes.h"

@implementation QNChordRootViewController
@synthesize rootToView;

- (id) initWithNibName:(NSString *)nibNameOrNil andChordRoot: (QNChordRoot *) root
{
	NSLog(@"hai!");
	if (!root)
	{
		NSLog(@"root may be not nil in QNChordRootViewController init!");
		exit(24);
		return nil;
	}
	
    if (self = [super initWithNibName:nibNameOrNil bundle:nil]) 
	{
        rootToView = root;
		chordNodesInRoot = [rootToView chordNodes]; 
		
		[self setTitle: [NSString stringWithFormat:@"%@ Chords",[rootToView chordName]]];
		//NSLog(@"%@",root);
    }
    return self;
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
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
	NSLog(@"bai from QNChordRootViewController");
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	//	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	//  return [sectionInfo numberOfObjects];
	
	return [chordNodesInRoot count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	QNChordNode *node = [chordNodesInRoot objectAtIndex:[indexPath row]];
	
	// Configure the cell.
	NSString *caption = @"";
	
	if ([[node chordType] intValue] == QNChordTypeOpen)
		caption = [NSString stringWithFormat:@"%@ - open",[node chordName]];
	if ([[node chordType] intValue] == QNChordTypePower)
		caption = [NSString stringWithFormat:@"%@ - power",[node chordName]];
	if ([[node chordType] intValue] == QNChordTypeCommon)
	{	
		NSString *fretstring = @"th";
		
		if ([[node startingFret] intValue] == 1)
			fretstring = @"st";
		if ([[node startingFret] intValue] == 2)
			fretstring = @"nd";
		if ([[node startingFret] intValue] == 3)
			fretstring = @"rd";
		
		caption = [NSString stringWithFormat:@"%@ - %@%@ Fret",[node chordName],[node startingFret],fretstring];
	}
	
	[[cell textLabel] setText: caption];
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
	//NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
	
	//cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
    // NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    // Pass the selected object to the new view controller.
    /// ...
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
	QNChordNode *theNode = [chordNodesInRoot objectAtIndex: [indexPath row]];
	QNChordNodeViewController *cnvc = [[QNChordNodeViewController alloc] initWithNibName:@"QNChordNodeViewController" andNodeToView: theNode];

	[cnvc setTitle:	[[[tableView cellForRowAtIndexPath: indexPath] textLabel] text]];
	[[self navigationController] pushViewController: cnvc animated: YES];
	
	[cnvc release];
	
	/*QNChordRoot *theRoot = [allChordRoots objectAtIndex: [indexPath row]];
	
	
	QNChordRootViewController *crvc = [[QNChordRootViewController alloc] initWithNibName:@"QNChordRootViewController" andChordRoot: theRoot];
	[[self navigationController] pushViewController: crvc animated: YES];
	
	[crvc release];*/
	
	
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*  if (editingStyle == UITableViewCellEditingStyleDelete) {
	 // Delete the managed object for the given index path
	 NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	 [context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
	 
	 // Save the context.
	 NSError *error;
	 if (![context save:&error]) {
	 // Handle the error...
	 }
	 
	 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	 }   */
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}





@end
