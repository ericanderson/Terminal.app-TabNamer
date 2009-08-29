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


#import "TTTabController_TabNamer.h"
#import "TTApplication.h"
#import "TN_NameRequestController.h"

@implementation TTTabController (TabNamer)

	+ (void) initialize {
		[self swizzleMethod:@selector(tabTitle) withMethod:@selector(_tn_tabTitle)];
		
		NSMenu* mainMenu = [[TTApplication sharedApplication] mainMenu];
		NSArray* rootItems = [mainMenu itemArray];
		
		for (NSMenuItem* item in rootItems) {
			if ([[item title] compare:@"View"] == 0) {
				if ([[[[item submenu] itemAtIndex:0] title] compare:@"Set Tab Name"] != 0) {
					[[[item submenu] itemAtIndex:0] setKeyEquivalent:@""];
					
					NSMenuItem* menuItem = [[NSMenuItem alloc] initWithTitle:@"Set Tab Name" action:@selector(_tn_nameTab:) keyEquivalent:@"T"];
					
					[menuItem setKeyEquivalentModifierMask:NSCommandKeyMask];
					
					[[item submenu] insertItem:menuItem  atIndex:0];
					[[item submenu] insertItem:[NSMenuItem separatorItem] atIndex:1];
					
					
				}
				break;
			}
		}
		
	}

	- (id) _tn_tabTitle {
			
		if ([self.customTitle compare:@""] != 0) {
			return self.customTitle;
		}

		return [self _tn_tabTitle]; // Call parent
	}

@end

@implementation TTView (TabNamer)

	- (void) _tn_nameTab:(id)sender {
		NSString* newName = [TN_NameRequestController requestNameForOldName:[[self controller] customTitle] forParent:[self window]];
		
		if (newName != nil) {
			[[self controller] setCustomTitle:newName];
			
			[[[self controller] shell] willChangeValueForKey:@"frontmostProcess"];
			[[[self controller] shell] didChangeValueForKey:@"frontmostProcess"];
		}
	}

@end