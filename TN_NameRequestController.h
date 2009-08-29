//
//  TN_NameRequestController.h
//  TabNamer
//
//  Created by Eric Anderson on 2/29/08.
//  Copyright 2008 Eric Anderson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TN_NameRequestController : NSWindowController
{
	NSString* requestName;
}

@property (retain) NSString* requestName;

+ (NSString*) requestNameForOldName:(NSString*)oldString forParent:(NSWindow*)parent;

-(IBAction) okPressed:(id)sender;
-(IBAction) cancelPressed:(id)sender;

@end
