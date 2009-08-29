//
//  TTTabController_TabNamer.h
//  TabNamer
//
//  Created by Eric Anderson on 2/27/08.
//  Copyright 2008 Eric Anderson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTTabController.h"
#import "TTView.h"
#import "NSObject_AWHSwizzle.h"


@interface TTView (TabNamer)
- (void)_tn_nameTab:(id)blah;
@end

@interface TTTabController (TabNamer) 

+ (void) initialize;

- (id)_tn_tabTitle;

@end

@interface TTTabController (TabNamerSwizzle)
- (id)_tn_super_tabTitle;
@end

