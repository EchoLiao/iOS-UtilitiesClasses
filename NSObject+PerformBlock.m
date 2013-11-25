//
//  NSObject+PerformBlock.m
//  phonathon
//
//  Created by BuUuKeen on 9/11/13.
//  Copyright (c) 2013 Thkeen. All rights reserved.
//

#import "NSObject+PerformBlock.h"

@implementation NSObject (PerformBlock)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	int64_t delta = (int64_t)(1.0e9 * delay);
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}
@end
