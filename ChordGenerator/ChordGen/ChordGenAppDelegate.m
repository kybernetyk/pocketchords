//
//  ChordGenAppDelegate.m
//  ChordGen
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "ChordGenAppDelegate.h"


@implementation ChordGenAppDelegate


// noteName : {string} name of the note
// noteFret : {number} on which fret is the note located
// noteString : {number} the string on which the note lies
// noteFinger: {number} the number of the finger that is used to access the note
- (NSDictionary *) createNoteWithName: (NSString *) name FretNumber: (int) fret StringNumber: (int) string andFingerNumber: (int) finger
{
	NSMutableDictionary *ret = [NSMutableDictionary dictionary];
	[ret setValue: name forKey: @"noteName"];
	[ret setValue: [NSNumber numberWithInt: fret] forKey:@"noteFret"];
	[ret setValue: [NSNumber numberWithInt: string] forKey:@"noteString"];
	[ret setValue: [NSNumber numberWithInt: finger] forKey:@"noteFinger"];
	
	return ret;
}

// chordName : {String} name des chords
// chordType : {Number} Type of Chord. See QNChordType... in ChordTypes.h
// diagramFilename : {String} relativer pfad zur diagram grafik
// startingFret : {Number} fret an dem der chord beginnt
// noteDescriptions : {Array of Dictionary} Die Noten, die zum Chord gehoeren

- (NSDictionary *) createChordNodeDescriptionWithName: (NSString *) name andStartingFret: (int) fret andNotes: (NSArray *) notes andDiagramPath: (NSString *) path andType: (int) type
{
	NSMutableDictionary *ret = [NSMutableDictionary dictionary];
	[ret setValue:name forKey:@"chordName"];
	[ret setValue:[NSNumber numberWithInt: fret] forKey:@"startingFret"];
	[ret setObject: notes forKey:@"noteDescriptions"];
	[ret setValue: path forKey:@"diagramFilename"];
	[ret setValue: [NSNumber numberWithInt: type] forKey: @"chordType"];
	return ret;
}


- (NSDictionary *) createChordRootDescriptionWithName: (NSString *) name andNodes: (NSArray *) nodes
{
	NSMutableDictionary *ret = [NSMutableDictionary dictionary];
	
	[ret setObject: name forKey:@"rootName"];
	[ret setObject: nodes forKey:@"chordNodes"];
	
	return ret;

}
//0 - name
//1 - startFret
//2 - diagram pic

//3 - note name
//4 - note fret
//5 - string
//6 - finger
// ...
- (NSDictionary *) createChordNodeFromParseline: (NSString *) parse
{
	NSArray *p = [parse componentsSeparatedByString:@","];

	NSString *name = [p objectAtIndex: 0];
	int startFret = [[p objectAtIndex: 1] intValue];
	NSString *diagram = [p objectAtIndex: 2];
	int type = [[p objectAtIndex: 3] intValue];

	int maxcount = [p count];
	
	NSMutableArray *notes = [NSMutableArray array];
	
	for (int i = 4; i < maxcount; i+= 4)
	{
		
		NSLog(@"name: %@",[p objectAtIndex: i]);
		NSLog(@"fret: %@",[p objectAtIndex: i+1]);
		NSLog(@"str:  %@",[p objectAtIndex: i+2]);
		NSLog(@"fing: %@",[p objectAtIndex: i+3]);	
		
		NSDictionary *note = [self createNoteWithName: [p objectAtIndex: i]
									FretNumber: [[p objectAtIndex: i+1] intValue]
									StringNumber: [[p objectAtIndex: i+2] intValue]
									  andFingerNumber: [[p objectAtIndex: i+3] intValue]];
		
		[notes addObject: note];
	}
	
	NSDictionary *ret = [self createChordNodeDescriptionWithName:name andStartingFret:startFret andNotes:notes andDiagramPath:diagram andType: type];
	
	//metadata
	
	//notes
//	NSArray *src = [NSArray arrayWithArray: [p objectsAtIndexes:<#(NSIndexSet *)indexes#>
	
	return ret;
}

- (NSDictionary *) createChordRootWithName: (NSString *) name fromParselines: (NSArray *) parseLines
{
	NSMutableArray *chords = [NSMutableArray array];
	for (NSString *parseline in parseLines)
	{
		NSDictionary *chord = [self createChordNodeFromParseline: parseline];
		[chords addObject: chord];
	}

	NSDictionary *ret = [self createChordRootDescriptionWithName:name andNodes: chords];
	return ret;
}

//0 - name
//1 - startFret
//2 - diagram pic


//3 - note name
//4 - note fret
//5 - string
//6 - finger
- (void)createE7
{
	NSMutableArray *parselines = [NSMutableArray array];

	NSString *parse;

	parse = @"E7,0,e7_0_1.jpg,1,E,0,1,0,B,2,2,2,D,0,3,0,G#,1,4,1,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];

	parse = @"E7,0,e7_0_2.jpg,1,E,0,1,0,B,2,2,2,E,2,3,3,G#,1,4,1,D,3,5,4";
	[parselines addObject: parse];

	parse = @"E7,4,e7_4_1.jpg,0,E,0,1,0,A,0,2,0,D,0,3,0,G,0,4,0,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];

	parse = @"E7,4,e7_4_2.jpg,0,B,7,1,2,E,7,2,3,G#,6,3,1,D,7,4,4";
	[parselines addObject: parse];

	parse = @"E7,7,e7_7_1.jpg,0,E,0,1,0,A,0,2,0,D,0,3,0,G,0,4,0,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];

	parse = @"E7,9,e7_9_1.jpg,0,E,0,1,0,A,0,2,0,D,0,3,0,G,0,4,0,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];
	
	NSDictionary *root = [self createChordRootWithName:@"E7" fromParselines: parselines];
	[root writeToFile:@"/E7.plist" atomically: NO];
}

- (void)createA
{
	NSMutableArray *parselines = [NSMutableArray array];
	
	NSString *parse;
	
	parse = @"A,0,a_0_1.jpg,1,E,0,1,0,B,2,2,2,D,0,3,0,G#,1,4,1,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];
	
	parse = @"A,1,a_1_1.jpg,0,E,0,1,0,B,2,2,2,E,2,3,3,G#,1,4,1,D,3,5,4";
	[parselines addObject: parse];
	
	parse = @"A,5,a_5_1.jpg,0,E,0,1,0,A,0,2,0,D,0,3,0,G,0,4,0,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];
	
	parse = @"A,5,a_5_2.jpg,0,B,7,1,2,E,7,2,3,G#,6,3,1,D,7,4,4";
	[parselines addObject: parse];
	
	parse = @"A,7,a_7_1.jpg,0,E,0,1,0,A,0,2,0,D,0,3,0,G,0,4,0,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];
	
	parse = @"A,9,a_9_1.jpg,0,E,0,1,0,A,0,2,0,D,0,3,0,G,0,4,0,B,0,5,0,E,0,6,0";
	[parselines addObject: parse];
	
	NSDictionary *root = [self createChordRootWithName:@"Amaj" fromParselines: parselines];
	[root writeToFile:@"/A.plist" atomically: NO];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self createA];
	[self createE7];
	return;
}

@end
