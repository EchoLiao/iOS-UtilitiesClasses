//
//  UIView+CoreAnimation.m
//  CoreAnimationPlayGround
//
//  Created by Daniel Tavares on 27/03/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+Explode.h"

#define HIRESDEVICE (((int)rintf([[[UIScreen mainScreen] currentMode] size].width/[[UIScreen mainScreen] bounds].size.width )>1))


@interface LPParticleLayer : CALayer

@property (nonatomic, strong) UIBezierPath *particlePath;

@end

@implementation UIView (Explode)

float randomFloat() {
    return (float)rand()/(float)RAND_MAX;
}

CGContextRef CreateARGBBitmapContext(CGSize size) {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = size.width;
    size_t pixelsHigh = size.height;
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
    
}

- (UIImage *)imageFromLayer:(CALayer *)layer {
    CGSize size = self.bounds.size;
    CGContextRef context = CreateARGBBitmapContext(size);
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext: context];
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage* img = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return img;
    
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (void)lp_explode {
    float size = self.frame.size.width/5;
    CGSize imageSize = CGSizeMake(size, size);
    
    CGFloat cols = self.frame.size.width / imageSize.width ;
    CGFloat rows = self.frame.size.height /imageSize.height;
    
    int fullColumns = floorf(cols);
    int fullRows = floorf(rows);
    
    CGFloat remainderWidth = self.frame.size.width  -
    (fullColumns * imageSize.width);
    CGFloat remainderHeight = self.frame.size.height -
    (fullRows * imageSize.height );
    
    
    if (cols > fullColumns) fullColumns++;
    if (rows > fullRows) fullRows++;
    
    CGRect originalFrame = self.layer.frame;
    CGRect originalBounds = self.layer.bounds;
    
   
    CGImageRef fullImage = [self imageFromLayer:self.layer].CGImage;
//    CGImageRef fullImage = [self blerg];
//    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*2, self.frame.size.height*2)];
//    CGImageRef fullImage = [self imageFromLayer:whiteView.layer].CGImage;
    
    //if its an image, set it to nil
    if ([self isKindOfClass:[UIImageView class]])
    {
        [(UIImageView*)self setImage:nil];
    }
    
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    for (int y = 0; y < fullRows; ++y)
    {
        for (int x = 0; x < fullColumns; ++x)
        {
            CGSize tileSize = imageSize;
            
            if (x + 1 == fullColumns && remainderWidth > 0)
            {
                // Last column
                tileSize.width = remainderWidth;
            }
            if (y + 1 == fullRows && remainderHeight > 0)
            {
                // Last row
                tileSize.height = remainderHeight;
            }
            
            CGRect layerRect = (CGRect){{x*imageSize.width, y*imageSize.height},
                tileSize};
            
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage,layerRect);
            
            LPParticleLayer *layer = [LPParticleLayer layer];
            layer.frame = layerRect;
            layer.contents = (__bridge id)(tileImage);
            layer.borderWidth = 0.0f;
            layer.borderColor = [UIColor blackColor].CGColor;
            layer.particlePath = [self pathForLayer:layer parentRect:originalFrame];
            [self.layer addSublayer:layer];
            
            CGImageRelease(tileImage);
        }
    }
    
    [self.layer setFrame:originalFrame];
    [self.layer setBounds:originalBounds];

    
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    NSArray *sublayersArray = [self.layer sublayers];
    [sublayersArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        LPParticleLayer *layer = (LPParticleLayer *)obj;
        
        //Path
        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = layer.particlePath.CGPath;
        moveAnim.removedOnCompletion = YES;
        moveAnim.fillMode=kCAFillModeForwards;
        NSArray *timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],nil];
        [moveAnim setTimingFunctions:timingFunctions];
        
        float r = randomFloat();

        NSTimeInterval speed = 2.35*r;
        
        CAKeyframeAnimation *transformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D startingScale = layer.transform;
        CATransform3D endingScale = CATransform3DConcat(CATransform3DMakeScale(randomFloat(), randomFloat(), randomFloat()), CATransform3DMakeRotation(M_PI*(1+randomFloat()), randomFloat(), randomFloat(), randomFloat()));
        
        NSArray *boundsValues = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:startingScale],
                                 
                                 [NSValue valueWithCATransform3D:endingScale], nil];
        [transformAnim setValues:boundsValues];
        
        NSArray *times = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:speed*.25], nil];
        [transformAnim setKeyTimes:times];
        
        
        timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                    nil];
        [transformAnim setTimingFunctions:timingFunctions];
        transformAnim.fillMode = kCAFillModeForwards;
        transformAnim.removedOnCompletion = NO;
        
        //alpha
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnim.fromValue = [NSNumber numberWithFloat:1.0f];
        opacityAnim.toValue = [NSNumber numberWithFloat:0.f];
        opacityAnim.removedOnCompletion = NO;
        opacityAnim.fillMode =kCAFillModeForwards;
       
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.animations = [NSArray arrayWithObjects:moveAnim,transformAnim,opacityAnim, nil];
        animGroup.duration = speed;
        animGroup.fillMode =kCAFillModeForwards;
        animGroup.delegate = self;
        [animGroup setValue:layer forKey:@"animationLayer"];
        [layer addAnimation:animGroup forKey:nil];
        
        //take it off screen
        [layer setPosition:CGPointMake(0, -600)];
        
    }];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
//    LPParticleLayer *layer = [theAnimation valueForKey:@"animationLayer"];
//    
//    if (layer)
//    {
//        //make sure we dont have any more
//        if ([[self.layer sublayers] count]==1)
//        {
//            [self removeFromSuperview];
//        }
//        else
//        {
//            [layer removeFromSuperlayer];
//        }
//    }
    
}

-(UIBezierPath *)pathForLayer:(CALayer *)layer parentRect:(CGRect)rect {
    UIBezierPath *particlePath = [UIBezierPath bezierPath];
    [particlePath moveToPoint:layer.position];
    
    float r = ((float)rand()/(float)RAND_MAX) + 0.3f;
    float r2 = ((float)rand()/(float)RAND_MAX)+ 0.4f;
    float r3 = r*r2;
    
    int upOrDown = (r <= 0.5) ? 1 : -1;
    
    CGPoint curvePoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    float maxLeftRightShift = 1.f * randomFloat();
    
    CGFloat layerYPosAndHeight = (self.superview.frame.size.height-((layer.position.y+layer.frame.size.height)))*randomFloat();
    CGFloat layerXPosAndHeight = (self.superview.frame.size.width-((layer.position.x+layer.frame.size.width)))*r3;
    
    float endY = self.superview.frame.size.height-self.frame.origin.y;
    
    if (layer.position.x <= rect.size.width*0.5)
    {
        //going left
        endPoint = CGPointMake(-layerXPosAndHeight, endY);
        curvePoint= CGPointMake((((layer.position.x*0.5)*r3)*upOrDown)*maxLeftRightShift,-layerYPosAndHeight);
    }
    else
    {
        endPoint = CGPointMake(layerXPosAndHeight, endY);
        curvePoint= CGPointMake((((layer.position.x*0.5)*r3)*upOrDown+rect.size.width)*maxLeftRightShift, -layerYPosAndHeight);
    }
    
    [particlePath addQuadCurveToPoint:endPoint
                     controlPoint:curvePoint];
    
    return particlePath;
    
}

@end

@implementation LPParticleLayer

@end
