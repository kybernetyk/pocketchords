//
//  QNChordNode.h
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QNChordRoot;

@interface QNChordNode : NSObject 
{
	//zugeordneter chord Root
	QNChordRoot *parentRoot;

	//die zum Chord dazugehoerige Griffgrafik
	NSString *chordDiagramFilename;
	
	//Name des Chords. Normalerweise Name des Parent ChordRoots
	NSString *chordName;
	
	//Fret auf dem der Chord beginnt
	NSNumber *startingFret;
	
	//Liste mit den einzelnen Noten
	NSArray *chordNotes;
	
	//is it a special type? open? powerchord?
	NSNumber *chordType;
}

@property (readonly) NSString *chordName;
@property (readonly) NSString *chordDiagramFilename;
@property (readonly) NSNumber *startingFret;
@property (readonly) NSNumber *chordType;

//designated initializer
- (id) initWithParentRoot: (QNChordRoot *) parent andNodeDescription: (NSDictionary *) description;

@end
