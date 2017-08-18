//
//  CAButton.h
//  Clock
//
//  Created by apple on 8/17/16.
//  Copyright © 2016 Extreme Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface CAButton : UIButton


@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic,strong) IBInspectable UIColor * borderColor;


@end
