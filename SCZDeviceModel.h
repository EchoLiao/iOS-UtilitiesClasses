//
//  SCZDeviceModel.h
//  cma-uuid
//
//  Created by Samuel Chandra on 6/7/13.
//  Copyright (c) 2013 Samuel Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface SCZDeviceModel : NSObject

+ (NSDictionary *)deviceData;

@end
