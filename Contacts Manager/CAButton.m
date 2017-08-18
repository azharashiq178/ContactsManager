//
//  CAButton.m
//  Clock
//
//  Created by apple on 8/17/16.
//  Copyright © 2016 Extreme Solutions. All rights reserved.
//

#import "CAButton.h"

@implementation CAButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self.layer setBorderColor:_borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    
    _borderWidth = borderWidth;
    [self.layer setBorderWidth:_borderWidth];
}



-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    _cornerRadius = cornerRadius;
    [self.layer setCornerRadius:_cornerRadius];
}

@end
