//
//  NSString+Date.m
//  JabberClient
//
//  Created by cesarerocchi on 9/12/11.
//  Copyright 2011 studiomagnolia.com. All rights reserved.
//

#import "NSString+Utils.h"

#define ISO_TIMEZONE_UTC_FORMAT @"Z"
#define ISO_TIMEZONE_OFFSET_FORMAT @"%+02d:%02d"

@implementation NSString (Utils)


+ (NSString *) getCurrentTime {

	NSDate *nowUTC = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	return [dateFormatter stringFromDate:nowUTC];
	
}

+ (NSString *) getCurrentHourAndMinute {
    static NSDateFormatter* sISO8601;
    
    if (sISO8601 == nil) {
        sISO8601 = [[NSDateFormatter alloc] init];
        [sISO8601 setDateFormat:@"HH:mm"];
        [sISO8601 setTimeZone:[NSTimeZone localTimeZone]];
    }
    
    NSString *timestampStr = [sISO8601 stringFromDate:[NSDate date]];
    
	return timestampStr;
}

+ (NSString *) stringHourAndMinuteFromDate: (NSDate *)date {
    static NSDateFormatter* sISO8601;
    
    if (sISO8601 == nil) {
        sISO8601 = [[NSDateFormatter alloc] init];
        [sISO8601 setDateFormat:@"HH:mm"];
        [sISO8601 setTimeZone:[NSTimeZone localTimeZone]];
    }
    
    NSString *timestampStr = [sISO8601 stringFromDate:date];
    
	return timestampStr;
}

+ (NSString *) stringFromDate: (NSDate *)date {
    static NSDateFormatter *dateFormatter;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }
	return [dateFormatter stringFromDate:date];
	
}

+ (NSString *)stringDateOnlyFromDate:(NSDate *)date {
    static NSDateFormatter* sISO8601;
    
    if (sISO8601 == nil) {
        sISO8601 = [[NSDateFormatter alloc] init];
        [sISO8601 setDateFormat:@"yy-MM-dd"];
        [sISO8601 setTimeZone:[NSTimeZone localTimeZone]];
    }
    
    NSString *timestampStr = [sISO8601 stringFromDate:date];
    
	return timestampStr;
}

+ (NSString *)stringFullDateWithoutTimeFromDate:(NSDate *)date {
    static NSDateFormatter* sISO8601;
    
    if (sISO8601 == nil) {
        sISO8601 = [[NSDateFormatter alloc] init];
        [sISO8601 setDateStyle:NSDateFormatterFullStyle];
        [sISO8601 setTimeZone:[NSTimeZone localTimeZone]];
    }
    
    NSString *timestampStr = [sISO8601 stringFromDate:date];
    
	return timestampStr;
}

+ (NSString *)ISO8601StringFromDate:(NSDate *)date {
    static NSDateFormatter* sISO8601;
    
    if (!sISO8601) {
        sISO8601 = [[NSDateFormatter alloc] init];
        
        NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyy-MM-dd'T'HH:mm:ss.SSS+00:00"]; // align with Android
        [sISO8601 setTimeZone:timeZone];
        [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
        [sISO8601 setDateFormat:strFormat];
    }
    return[sISO8601 stringFromDate:date];

}

- (NSString *) get150WidthScaledImageUrl {
    return [self stringByReplacingOccurrencesOfString:@"cphoto" withString:@"cphoto150"];
}
- (NSString *) get100SquareScaledImageUrl {
    return [self stringByReplacingOccurrencesOfString:@"uphoto" withString:@"uphoto100"];
}
@end
