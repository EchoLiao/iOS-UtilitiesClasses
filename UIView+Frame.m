//
//  UIView+Frame.m
//  SalesKit
//
//  Created by Kien Tran on 6/19/13.
//
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void) setFrameWidth:(CGFloat)newWidth {
    CGRect f = self.frame;
    f.size.width = newWidth;
    self.frame = f;
}

- (void) setFrameHeight:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.height = newHeight;
    self.frame = f;
}

- (void) setFrameWidth:(CGFloat)newWidth height:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.width = newWidth;
    f.size.height = newHeight;
    self.frame = f;
}

- (void) setFrameOriginX:(CGFloat)newX {
    CGRect f = self.frame;
    f.origin.x = newX;
    self.frame = f;
}

- (void) setFrameOriginY:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.y = newY;
    self.frame = f;
}

- (void) setFrameOriginX:(CGFloat)newX Y:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.x = newX;
    f.origin.y = newY;
    self.frame = f;
}

@end
