//
//  UIImageView+WebCacheFade.m
//  pip
//
//  Created by BuUuKeen on 9/9/13.
//  Copyright (c) 2013 Buuuk. All rights reserved.
//

#import "UIImageView+WebCacheFade.h"

@implementation UIImageView (WebCacheFade)

- (void)setImageFadeInWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock {
    
    __weak UIImageView *weakSelf = self;
    
    [self setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (image && cacheType == SDImageCacheTypeNone) {
            
            weakSelf.alpha = 0.0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 weakSelf.alpha = 1.0;
                             }];
        }
        
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}


- (void)setImageFadeInWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock {
    
    __weak UIImageView *weakSelf = self;
    
    [self setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (image && cacheType == SDImageCacheTypeNone) {
            
            weakSelf.alpha = 0.0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 weakSelf.alpha = 1.0;
                             }];
        }
        
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
    
}


@end
