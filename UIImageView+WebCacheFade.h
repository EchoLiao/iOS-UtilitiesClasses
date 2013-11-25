//
//  UIImageView+WebCacheFade.h
//  pip
//
//  Created by BuUuKeen on 9/9/13.
//  Copyright (c) 2013 Buuuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (WebCacheFade)

- (void)setImageFadeInWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock;

- (void)setImageFadeInWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock;


@end
