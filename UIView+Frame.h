//
//  UIView+Frame.h
//  SalesKit
//
//  Created by Kien Tran on 6/19/13.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (void) setFrameWidth:(CGFloat)newWidth;
- (void) setFrameHeight:(CGFloat)newHeight;
- (void) setFrameWidth:(CGFloat)newWidth height:(CGFloat)newHeight;
- (void) setFrameOriginX:(CGFloat)newX;
- (void) setFrameOriginY:(CGFloat)newY;
- (void) setFrameOriginX:(CGFloat)newX Y:(CGFloat)newY;

@end
