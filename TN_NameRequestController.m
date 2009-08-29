/*  
	Copyright 2009 Eric Anderson

	This file is part of Terminal.app TabNamer

    Terminal.app TabNamer is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Foobar is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
    
*/



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