//
//  NSDictionary+Additions.m
//  SalesKit
//
//  Created by Stan Chang Khin Boon on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

- (id)safeObjectForKey:(id)theKey {
    id theObject = [self objectForKey:theKey];
    return ([theObject isEqual:[NSNull null]]) ? nil : theObject;
}

@end
