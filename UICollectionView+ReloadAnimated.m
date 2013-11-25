//
//  UICollectionView+ReloadAnimated.m
//  pip
//
//  Created by BuUuKeen on 11/9/13.
//  Copyright (c) 2013 Buuuk. All rights reserved.
//

#import "UICollectionView+ReloadAnimated.h"
#import <QuartzCore/QuartzCore.h>

@implementation UICollectionView (ReloadAnimated)

- (void)reloadItemsAtIndexPaths:(NSArray*)indexPaths animated:(BOOL)animated {
    if (!animated) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    }
    
    [self reloadItemsAtIndexPaths:indexPaths];
    
    if (!animated) {
        [CATransaction commit];
    }
}

- (void)reloadSections:(NSIndexSet *)indexSet animated:(BOOL)animated {
    if (!animated) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    }
    
    [self reloadSections:indexSet];
    
    if (!animated) {
        [CATransaction commit];
    }
}

@end
