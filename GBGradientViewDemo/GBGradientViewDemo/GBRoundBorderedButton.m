//
//  GBRoundBorderedButton.m
//  GBMeditation
//
//  Created by Gerardo Blanco García on 08/02/14.
//  Copyright (c) 2014 ZIBLEC. All rights reserved.
//

#import "GBRoundBorderedButton.h"

static CGFloat const GBRoundBorderedButtonDefaultBorderWith = 2.0f;

@interface GBRoundBorderedButton()

@end

@implementation GBRoundBorderedButton

@synthesize color = _color;

@synthesize borderWidth = _borderWidth;

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    [self setTitleColor:self.color forState:UIControlStateNormal];
    [self setTitleColor:[self highlightedColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[self highlightedColor] forState:UIControlStateDisabled];
    
    self.layer.cornerRadius = self.frame.size.height / 2.0f;
    self.layer.borderWidth = self.borderWidth;
    
    [self refreshBorderColor];
}

- (UIColor *)highlightedColor
{
    
    UIColor *color = self.color;
    
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    
    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:0.5f];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    
    [self setTitleColor:tintColor forState:UIControlStateNormal];
    [self refreshBorderColor];
}

- (UIColor *)color
{
    return (_color ? _color : [self tintColor]);
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    
    [self setTitleColor:self.color forState:UIControlStateNormal];
    [self setTitleColor:[self highlightedColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[self highlightedColor] forState:UIControlStateDisabled];
    
    [self refreshBorderColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self setTitleColor:[self highlightedColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[self highlightedColor] forState:UIControlStateDisabled];
    
    [self refreshBorderColor];
}

- (CGFloat)borderWidth
{
    return (_borderWidth ? _borderWidth : GBRoundBorderedButtonDefaultBorderWith);
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    
    self.layer.borderWidth = self.borderWidth;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self refreshBorderColor];
}

- (void)refreshBorderColor
{
    UIColor *borderColor = [self highlightedColor];
    
    if (self.isHighlighted) {
        borderColor = [self highlightedColor];
    } else if (self.isEnabled) {
        borderColor = self.color;
    }
    
    self.layer.borderColor = [borderColor CGColor];
}

@end
