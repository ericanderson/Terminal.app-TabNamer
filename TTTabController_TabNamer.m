//
//  TTTabController_TabNamer.m
//  TabNamer
//
//  Created by Eric Anderson on 2/27/08.
//  Copyright 2008 Eric Anderson. All rights reserved.
//

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