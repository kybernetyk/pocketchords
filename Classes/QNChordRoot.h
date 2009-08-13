//
//  QNChordRoot.h
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
	QNChordRoot - Ueberkategorie eines Chords.
	zB. E7 Chord Root mit N moeglichkeiten den Chord zu spielen. (das sind die nodes)
 
 */
@interface QNChordRoot : NSObject 
{
	//Name des Chords. zB. E7
	NSString *chordName;
	
	//Liste mit den Moeglichkeiten Chords zu spielen
	NSArray *chordNodes; 
}

@property (readonly) NSString *chordName;
@property (readonly) NSArray *chordNodes;

//designated initializer
- (id) initWithDescriptionFromFile: (NSString *) filename;

//laedt die Description des Chords aus einer .plist
//und erstellt die untergeordneten Nodes
- (BOOL) loadFromFile: (NSString *) filename;

@end
