//
//  UICollectionView+ReloadAnimated.h
//  pip
//
//  Created by BuUuKeen on 11/9/13.
//  Copyright (c) 2013 Buuuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (ReloadAnimated)
- (void)reloadItemsAtIndexPaths:(NSArray*)indexPaths animated:(BOOL)animated;
- (void)reloadSections:(NSIndexSet*)indexSet animated:(BOOL)animated;
@end
