//
//  UIColor+Utils.h
//  GBMeditation
//
//  Created by Gerardo Blanco García on 25/04/14.
//  Copyright (c) 2014 gblancogarcia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+ (UIColor *)colorFromHexCode:(NSString *)hexString;

+ (UIColor *)blendedColorWithForegroundColor:(UIColor *)foregroundColor
                             backgroundColor:(UIColor *)backgroundColor
                                percentBlend:(CGFloat)percentBlend;

+ (UIColor *)nextColor:(UIColor *)color;

+ (UIColor *)softCyanColor;

+ (UIColor *)lightBlueColor;

@end
