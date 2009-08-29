//
//  NSObject_AWHSwizzle.m
//  TabNamer
//
//  Created by Eric Anderson on 2/29/08.
//  Copyright 2008 Eric Anderson. All rights reserved.
//

#import "NSObject_AWHSwizzle.h"
#import </usr/include/objc/objc-class.h>

BOOL PerformSwizzle(Class klass, SEL origSel, SEL altSel, BOOL forInstance) {
    // First, make sure the class isn't nil
	if (klass != nil) {
		Method origMethod = NULL, altMethod = NULL;
		
		// Next, look for the methods
		Class iterKlass = (forInstance ? klass : klass->isa);
		unsigned int methodCount = 0;
		Method *mlist = class_copyMethodList(iterKlass, &methodCount);
		if (mlist != NULL) {
			int i;
			for (i = 0; i < methodCount; ++i) {
				
				if (method_getName(mlist[i]) == origSel) {
					origMethod = mlist[i];
					break;
				}
				if (method_getName(mlist[i]) == altSel) {
					altMethod = mlist[i];
					break;
				}
			}
		}
		
		if (origMethod == NULL || altMethod == NULL) {
			// one or both methods are not in the immediate class
			// try searching the entire hierarchy
			// remember, iterKlass is the class we care about - klass || klass->isa
			// class_getInstanceMethod on a metaclass is the same as class_getClassMethod on the real class
			BOOL pullOrig = NO, pullAlt = NO;
			if (origMethod == NULL) {
				origMethod = class_getInstanceMethod(iterKlass, origSel);
				pullOrig = YES;
			}
			if (altMethod == NULL) {
				altMethod = class_getInstanceMethod(iterKlass, altSel);
				pullAlt = YES;
			}
			
			// die now if one of the methods doesn't exist anywhere in the hierarchy
			// this way we won't make any changes to the class if we can't finish
			if (origMethod == NULL || altMethod == NULL) {
				return NO;
			}
			
			// we can safely assume one of the two methods, at least, will be pulled
			// pull them up
			size_t listSize = sizeof(Method);
			if (pullOrig && pullAlt) listSize += sizeof(Method); // need 2 methods
			if (pullOrig) {
				class_addMethod(iterKlass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
			}
			if (pullAlt) {
				class_addMethod(iterKlass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod));
			}
		}
		
		// now swizzle
		method_exchangeImplementations(origMethod, altMethod);
		
		return YES;
	}
	return NO;
}

@implementation NSObject(AWHSwizzle)
+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel {
    NSString *originalMethodName = [NSString stringWithCString:sel_getName(orig_sel)];
    NSString *alternateMethodName = [NSString stringWithCString:sel_getName(alt_sel)];    
    NSLog(@"Attempting to swizzle in class '%@': swapping method '%@' with '%@'...",[self class], originalMethodName, alternateMethodName);
	
	PerformSwizzle([self class], orig_sel, alt_sel, YES);
}

+ (void)swizzleClassMethod:(SEL)orig_sel withClassMethod:(SEL)alt_sel {
    NSString *originalMethodName = [NSString stringWithCString:sel_getName(orig_sel)];
    NSString *alternateMethodName = [NSString stringWithCString:sel_getName(alt_sel)];    
    NSLog(@"Attempting to swizzle in class '%@': swapping class method '%@' with '%@'...",[self class], originalMethodName, alternateMethodName);
	PerformSwizzle([self class], orig_sel, alt_sel, NO);
}
@end