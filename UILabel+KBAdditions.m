#import "UILabel+KBAdditions.h"
#import "NSString+KBAdditions.h"

@implementation UILabel (KBAdditions)

- (void)sizeToFitMultipleLines {
    if (self.adjustsFontSizeToFitWidth) {
        CGFloat adjustedFontSize = [self.text fontSizeWithFont:self.font constrainedToSize:self.frame.size minimumFontSize:self.minimumScaleFactor];
        self.font = [self.font fontWithSize:adjustedFontSize];
    }
    [self sizeToFit];
}

@end