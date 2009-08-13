//
//  QNChordNote.m
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNChordNote.h"


@implementation QNChordNote

//designated initializer
// key : {type} value
// noteName : {string} name of the note
// noteFret : {number} on which fret is the note located
// noteString : {number} the string on which the note lies
// noteFinger: {number} the number of the finger that is used to access the note
- (id) initWithDescription: (NSDictionary *) noteDescription
{
	self = [super init];
	if (self)
	{
		//autorelease
		NSString *name = [noteDescription objectForKey:@"noteName"];
		if (!name)
			return nil;

		//copy - retaincount 1
		noteName = [[NSString alloc] initWithString: name];
		
		NSNumber *fret = [noteDescription objectForKey:@"noteFret"];
		if (!fret)
			return nil;
		int iFret = [fret intValue];
		
		//assign - retaincount 1
		noteFret = [[NSNumber alloc] initWithInt: iFret];
		
	
		NSNumber *string = [noteDescription objectForKey:@"noteString"];
		if (!string)
			return nil;
		int iString = [string intValue];
		
		//assign - retaincount 1
		noteString = [[NSNumber alloc] initWithInt: iString];
		
		NSNumber *finger = [noteDescription objectForKey:@"noteFinger"];
		if (!finger)
			return nil;
		int iFinger = [finger intValue];
		
		//assign - retaincount 1
		noteFinger = [[NSNumber alloc] initWithInt: iFinger];
		
	}
	return self;
}

- (void) dealloc
{
	[noteName release];
	[noteFret release];
	[noteString release];
	[noteFinger release];
	
	[super dealloc];
}

@end
