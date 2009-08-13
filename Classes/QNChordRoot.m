//
//  QNChordRoot.m
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNChordRoot.h"
#import "QNChordNode.h"

@implementation QNChordRoot
@synthesize chordName;
@synthesize chordNodes;

//designated initializer
- (id) initWithDescriptionFromFile: (NSString *) filename
{
	self = [super init];
	if (self)
	{
		if (![self loadFromFile: filename])
			return nil;
	}
	return self;
}

//dealloc
- (void) dealloc
{
	[chordName release];
	[chordNodes release];
	
	[super dealloc];
}

//laedt die Description des Chords aus einer .plist
//und erstellt die untergeordneten Nodes
- (BOOL) loadFromFile: (NSString *) filename
{
	//autorelease
	NSDictionary *rootDescription = [NSDictionary dictionaryWithContentsOfFile: filename];
	if (!rootDescription)
	{	
		return NO;
	}
	
	//cName = autoreleased string
	NSString *cName = [rootDescription objectForKey:@"rootName"];
	//NSLog(@"cname: %@",cName);
	
	if (!chordName)
	{
		//copy string initializer
		//chordName retaincount 1
		chordName = [[NSString alloc] initWithString: cName];
	}
	if (!chordNodes)
	{
		//nodeDescriptions = autoreleased array
		//array of dictionarys containing description for each child node
		NSArray *nodeDescriptions = [rootDescription objectForKey:@"chordNodes"];
		if (!nodeDescriptions)
		{	
			NSLog(@"no nodeDescription in QNChordRoot.m Linke 62");
			return NO;
		}
			

		//NSLog(@"we hafe descriptions!");
		
		//temp array - autorelease
		NSMutableArray *tempArray = [NSMutableArray array];
		
		for (NSDictionary *nodeDescription in nodeDescriptions)
		{
		//	NSLog(@"loading desc: %@",nodeDescription);
			//retaincount = 1
			QNChordNode *theNode = [[QNChordNode alloc] initWithParentRoot: self andNodeDescription: nodeDescription];
			if (!theNode)
			{
				NSLog(@"no node! %@",nodeDescription);
				return NO;
			}
			
			//theNode retaincount +1 = 2
			[tempArray addObject: theNode];
			
			//theNode retaincount -1 = 1
			//wird beim dealloc geloescht, wenn array entfernt wird
			[theNode release]; 
		}
		
		//erstellt unser instanzarray
		//die elemente in tempArray erhalten ein retain
		chordNodes = [[NSArray alloc] initWithArray: tempArray];
		
		//releases our temp array
		//object get a release
		//[tempArray release]; //will be autoreleased
	}
	
	return YES;
}

@end
