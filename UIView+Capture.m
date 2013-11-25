//
//  UIView+Capture.m
//  Snoweee
//
//  Created by Kien Tran on 11/14/12.
//  Copyright (c) 2012 Thkeen. All rights reserved.
//

#import "UIView+Capture.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Capture)
- (UIImage *)imageByRenderingView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
@end
