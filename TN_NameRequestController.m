//
//  TN_NameRequestController.m
//  TabNamer
//
//  Created by Eric Anderson on 2/29/08.
//  Copyright 2008 Eric Anderson. All rights reserved.
//

#import "TN_NameRequestController.h"

@implementation TN_NameRequestController
	@synthesize requestName;

	+ (NSString*) requestNameForOldName:(NSString*)oldString forParent:(NSWindow*)parent {	
		TN_NameRequestController* controller = [[TN_NameRequestController alloc] initWithWindowNibName:@"TN_GetName"];
		[controller setRequestName:oldString];
		
		[NSApp beginSheet:[controller window] modalForWindow:parent modalDelegate:nil didEndSelector:nil contextInfo:nil];
		int success = [NSApp runModalForWindow:[controller window]];
		[NSApp endSheet:[controller window]];
		[[controller window] orderOut:self];
		
		NSString* ret = [controller requestName];

		[controller release];
		
		if (success) 
			return (ret == nil) ? @"" : ret;
		else
			return nil;
	}

	-(IBAction) okPressed:(id)sender {
		[NSApp stopModalWithCode:TRUE];
	}

	-(IBAction) cancelPressed:(id)sender {		
		[NSApp stopModalWithCode:FALSE];
	}

@end