/*
 *  TTTabController.h
 *  TabNamer
 *
 *  Created by Eric Anderson on 2/29/08.
 *  Copyright 2008 Eric Anderson. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>

@interface TTTabController : NSObject
- (id)tabTitle;
- (id)customTitle;
- (void)setCustomTitle:(id)aTitle;
- (id) contentView;
- (id) shell;
@end