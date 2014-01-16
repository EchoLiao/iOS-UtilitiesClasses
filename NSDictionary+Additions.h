//
//  NSDictionary+Additions.h
//  SalesKit
//
//  Created by Stan Chang Khin Boon on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (id)safeObjectForKey:(id)theKey;
- (id)notNilStringForKey:(id)theKey;

@end
