//
//  QNAllChordsViewController.m
//  Chord Library
//
//  Created by jrk on 13.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNAllChordsViewController.h"
#import "QNChordRootViewController.h"
#import "QNChordRoot.h"

@implementation QNAllChordsViewController

/*- (void)viewDidLoad 
{
	NSLog(@"lol##############");
    [super viewDidLoad];
	
	// Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
	
	
	
/*	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Handle the error...
	}*/
//}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

//loads the chordRootList and returns number of loaded files
- (int) loadChordRoots
{
	//release old array
	[allChordRoots autorelease];
	
	//autorelease
	NSMutableArray *allChords = [NSMutableArray array];
	for (NSString *file in [[NSFileManager defaultManager] enumeratorAtPath: [NSString stringWithFormat:@"%@/%@",
																			  [[NSBundle mainBundle] resourcePath],
																			  @"Chords"]])
	{
		//[allChords addObject: file];
		NSString *filename = [[NSBundle mainBundle] pathForResource: file ofType:nil inDirectory:@"Chords"];
		//NSLog(@"loading chord root: %@",filename);
		
		QNChordRoot *cr = [[QNChordRoot alloc] initWithDescriptionFromFile: filename];
		if (!cr)
		{
			NSLog(@"error loading chord root %@ %@!",file,SOURCE_LOCATION);
			exit(23);
			
			return -1;
		}
		[allChords addObject: cr];
		[cr release];
	}

	//retaincount 1
	//elements = copy
	allChordRoots = [[NSArray alloc] initWithArray: allChords];
	
	//NSLog(@"all chords: %@",allChords);
	
	return [allChords count];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	//[self setTitle:@"All Chords"];
	
//	NSString *fn = [[NSBundle mainBundle] pathForResource:@"A.plist" ofType:nil inDirectory:@"Chords"];
//	NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile: fn];
	//NSLog(@"%@ %@",fn,d);
	
	//set ups the allChordRoots array
	//and fills it
	[self loadChordRoots];
}


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
	[allChordRoots release];
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
	
	return [allChordRoots count];
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
    
	QNChordRoot *root = [allChordRoots objectAtIndex:[indexPath row]];
	
	// Configure the cell.
	[[cell textLabel] setText: [root chordName]];
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
	QNChordRoot *theRoot = [allChordRoots objectAtIndex: [indexPath row]];
	
	
	QNChordRootViewController *crvc = [[QNChordRootViewController alloc] initWithNibName: @"QNChordRootViewController" 
																			andChordRoot: theRoot];
	
	[[self navigationController] pushViewController: crvc animated: YES];
	
	[crvc release];
	
	
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
