//
//  NSObject+PerformBlock.h
//  phonathon
//
//  Created by BuUuKeen on 9/11/13.
//  Copyright (c) 2013 Thkeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end
