//
//  NSString+Date.h
//  JabberClient
//
//  Created by cesarerocchi on 9/12/11.
//  Copyright 2011 studiomagnolia.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Utils)

+ (NSString *) getCurrentTime;
+ (NSString *) stringFromDate: (NSDate *)date;
+ (NSString *) getCurrentHourAndMinute;
+ (NSString *) stringHourAndMinuteFromDate: (NSDate *)date;
+ (NSString *) stringDateOnlyFromDate: (NSDate *)date;
+ (NSString *)stringFullDateWithoutTimeFromDate:(NSDate *)date;

+ (NSString *)ISO8601StringFromDate:(NSDate *)date;

- (NSString *) get150WidthScaledImageUrl;
- (NSString *) get100SquareScaledImageUrl;

@end
