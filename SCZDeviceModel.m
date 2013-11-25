//
//  SCZDeviceModel.m
//  cma-uuid
//
//  Created by Samuel Chandra on 6/7/13.
//  Copyright (c) 2013 Samuel Chandra. All rights reserved.
//

#import "SCZDeviceModel.h"

@implementation SCZDeviceModel

+ (NSDictionary *)deviceData {
    NSDictionary *hardwareInfo = [self hardwareInfo];
    NSDictionary *carrierInfo = [self carrierInfo];
    
    // combine the dictionaries together
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:hardwareInfo];
    [carrierInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![hardwareInfo objectForKey:key]) {
            [result setObject:obj forKey:key];
        }
    }];
    
    return [NSDictionary dictionaryWithDictionary:result];
}

# pragma mark - CTCarrier Information
+ (NSDictionary *)carrierInfo {
    
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *currentCarrier = [netInfo subscriberCellularProvider];
    
    // Default values when not available
    NSString *carrier = @"NA";
    NSString *isoCountryCode = @"NA";
    NSString *mobileCountryCode = @"NA";
    NSString *mobileNetworkCode = @"NA";
    
    if (currentCarrier && currentCarrier.carrierName) {
        carrier = currentCarrier.carrierName;
    }
    
    if (currentCarrier && currentCarrier.isoCountryCode) {
        isoCountryCode = currentCarrier.isoCountryCode;
    }
    
    if (currentCarrier && currentCarrier.mobileCountryCode) {
        mobileCountryCode = currentCarrier.mobileCountryCode;
    }
    
    if (currentCarrier && currentCarrier.mobileNetworkCode) {
        mobileNetworkCode = currentCarrier.mobileNetworkCode;
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            carrier,           @"carrier",
            isoCountryCode,    @"isoCC",
            mobileCountryCode, @"mobCC",
            mobileNetworkCode, @"mobNC",
            nil];
}

# pragma mark - UIDevice Information
+ (NSDictionary *)hardwareInfo {
    UIDevice *device = [UIDevice currentDevice];
    
//    NSString *oldUDID = [device uniqueIdentifier];
    NSString *newUUID = [[device identifierForVendor] UUIDString];
    NSString *name = [device name];
    NSString *os = [device systemName];
    NSString *version = [device systemVersion];
    NSString *model = [device model];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
//            oldUDID, @"old_UDID",
            newUUID, @"new_UUID",
            name,    @"name",
            os,      @"os",
            version, @"version",
            model,   @"model",
            nil];
    

}

@end
