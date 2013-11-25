//
//  UIApplication+Info.m
//  pip
//
//  Created by BuUuKeen on 25/11/13.
//  Copyright (c) 2013 Buuuk. All rights reserved.
//

#import "UIApplication+Info.h"

@implementation UIApplication (Info)

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)build {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

+ (NSString *)versionBuild {
    NSString * version = [self appVersion];
    NSString * build = [self build];
    NSString * versionBuild = [NSString stringWithFormat:@"v%@", version];
    
    if (![version isEqualToString: build]) {
        versionBuild = [NSString stringWithFormat:@"%@(%@)", versionBuild, build];
    }
    
    return versionBuild;
}

@end
