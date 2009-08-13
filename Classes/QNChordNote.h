//
//  QNChordNote.h
//  Chord Library
//
//  Created by jrk on 12.08.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 eine Note auf dem Griffbrett
 */
// description
// key : {type} value
// noteName : {string} name of the note
// noteFret : {number} on which fret is the note located
// noteString : {number} the string on which the note lies
// noteFinger: {number} the number of the finger that is used to access the note

@interface QNChordNote : NSObject 
{
	//name der Note
	NSString *noteName;
	
	//Fret auf dem die Note liegt
	NSNumber *noteFret;
	
	//Der Finger, der zum greifen benutzt wird
	NSNumber *noteFinger;
	
	//String auf dem die Note liegt
	NSNumber *noteString;
}


- (id) initWithDescription: (NSDictionary *) noteDescription;



@end
