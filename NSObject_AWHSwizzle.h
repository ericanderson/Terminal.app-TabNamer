//
//  NSObject_AWHSwizzle.h
//  TabNamer
//
//  Created by Eric Anderson on 2/29/08.
//  Copyright 2008 Eric Anderson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSObject (AWHSwizzle)
+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel;
+ (void)swizzleClassMethod:(SEL)orig_sel withClassMethod:(SEL)alt_sel;
@end