//
//  QNChordNode.m
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNChordNode.h"
#import "QNChordRoot.h"
#import "QNChordNote.h"
#import "ChordTypes.h"

@implementation QNChordNode
@synthesize startingFret;
@synthesize chordName;
@synthesize chordType;
@synthesize chordDiagramFilename;

// designated initializer

// description
// key : value
// chordName : {String} name des chords
// chordType : {Number} Type of Chord. See QNChordType... in ChordTypes.h
// diagramFilename : {String} relativer pfad zur diagram grafik
// startingFret : {Number} fret an dem der chord beginnt
// noteDescriptions : {Array of Dictionary} Die Noten, die zum Chord gehoeren

- (id) initWithParentRoot: (QNChordRoot *) parent andNodeDescription: (NSDictionary *) description
{
	self = [super init];
	if (self)
	{
		//weak reference
		parentRoot = parent;
		
		//autoreleased NSString
		NSString *diagramFilename = [description objectForKey:@"diagramFilename"];
		if (!diagramFilename)
		{
			NSLog(@"No diagram filename found in node description %@",SOURCE_LOCATION);
			return nil;
		}
		
		chordDiagramFilename = [[NSString alloc] initWithString: diagramFilename];
		
		//chordDiagram retaincount 1
		/*chordDiagram = [[UIImage alloc] initWithContentsOfFile: diagramFilename];
		if (!chordDiagram)
		{
			NSLog(@"no diagram biatch!");
			return nil;
		}*/
		
		
		NSString *name = [description objectForKey:@"chordName"];
		if (!name)
		{
			NSLog(@"No chord name found in node description %@",SOURCE_LOCATION);
			return nil;
		}
		
		//copy constructor
		//retaincount 1
		chordName = [[NSString alloc] initWithString: name];

		//autorelease		
		NSNumber *type = [description objectForKey:@"chordType"];
		if (!type)
		{	
			NSLog(@"No type found in node description %@",SOURCE_LOCATION);
			return nil;
		}
		
		int iType = [type intValue];
		
		//retaincount 1
		chordType = [[NSNumber alloc] initWithInt: iType];

	
		//autorelease
		NSNumber *fret = [description objectForKey:@"startingFret"];
		if (!fret)
		{	
			NSLog(@"No fret found in node description %@",SOURCE_LOCATION);
			return nil;
		}

		int iFret = [fret intValue];		

		//retaincount 1
		startingFret = [[NSNumber alloc] initWithInt: iFret];
		
		//autorelease
		NSArray *noteDescriptions = [description objectForKey:@"noteDescriptions"];
		if (!noteDescriptions)
		{	
			NSLog(@"No notes found in node description %@",SOURCE_LOCATION);
			return nil;
		}
		
		//autorelease
		NSMutableArray *tmpArray = [NSMutableArray array];
		
		for (NSDictionary *noteDescription in noteDescriptions)
		{
			QNChordNote *theNote = [[QNChordNote alloc] initWithDescription: noteDescription];
			if (!theNote)
			{
				NSLog(@"not could not be created %@",SOURCE_LOCATION);
				return nil;
			}
			
			//theNode retaincount +1 = 2
			[tmpArray addObject: theNote];
			
			//theNode retaincount -1 = 1
			//wird beim dealloc geloescht, wenn array entfernt wird
			[theNote release]; 
		}
		
		//erstellt unser instanzarray
		//die elemente in tempArray erhalten ein retain
		chordNotes = [[NSArray alloc] initWithArray: tmpArray];
		
		//releases our temp array
		//objects get a release
		//[tmpArray release]; //will be autoreleased
		
		
	}
	return self;
}

- (void) dealloc
{
	[chordDiagramFilename release];
	[chordName release];
	[startingFret release];
	[chordNotes release];
	
	[super dealloc];
}

@end
