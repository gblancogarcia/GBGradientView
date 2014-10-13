//
//  GBGradientView.m
//  GBMeditation
//
//  Created by Gerardo Blanco García on 25/04/14.
//  Copyright (c) 2014 gblancogarcia. All rights reserved.
//

#import "GBGradientView.h"

const CGFloat GBGradientViewDefaultAnimationDuration = 3.0f;
const CGFloat GBGradientViewDefaultAnimationDelay = 10.0f;

@implementation GBGradientView

@synthesize animating;

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _orientation = GBGradientViewOrientationVertical;
        [self setUp];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
        orientation:(GBGradientViewOrientation)orientation
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _orientation = orientation;
        
        [self setUp];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
        orientation:(GBGradientViewOrientation)orientation
           delegate:(id<GBGradientViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _orientation = orientation;
        _delegate = delegate;
        
        [self setUp];
    }
    
    return self;
}

- (NSMutableArray *)colors
{
    NSMutableArray *colors;
    
    if ([self.delegate respondsToSelector:@selector(gradientColorsForGradientView:)]) {
        colors = [[self.delegate gradientColorsForGradientView:self] mutableCopy];
    }
    
    if (!colors) {
        colors = [NSMutableArray array];
        [colors addObject:(id)[[UIColor blackColor] CGColor]];
        [colors addObject:(id)[[UIColor whiteColor] CGColor]];
    }
    
    return colors;
}

- (CGFloat)animationDuration
{
    if (!_animationDuration) {
        _animationDuration = GBGradientViewDefaultAnimationDuration;
    }
    
    return _animationDuration;
}

- (CGFloat)animationDelay
{
    if (!_animationDelay) {
        _animationDelay = GBGradientViewDefaultAnimationDelay;
    }
    
    return _animationDelay;
}

- (void)setOrientation:(GBGradientViewOrientation)orientation
{
    _orientation = orientation;
    
    [self reload];
}

- (void)setDelegate:(id<GBGradientViewDelegate>)delegate
{
    _delegate = delegate;
    
    [self reload];
}

- (void)reload
{
    [self setUp];
}

- (void)setUp
{
    CAGradientLayer *layer = (id)[self layer];
    
    if (self.orientation == GBGradientViewOrientationVertical) {
        [layer setStartPoint:CGPointMake(0.5, 0.0)];
        [layer setEndPoint:CGPointMake(0.5, 1.0f)];
    } else if (self.orientation == GBGradientViewOrientationHorizontal) {
        [layer setStartPoint:CGPointMake(0.0f, 0.5f)];
        [layer setEndPoint:CGPointMake(1.0f, 0.5f)];
    }
    
    [layer setColors:[NSArray arrayWithArray:[self colors]]];
}

- (void)performAnimation
{
    CAGradientLayer *layer = (id)[self layer];
    NSArray *fromColors = [layer colors];
    NSArray *toColors = [self colors];
    [layer setColors:toColors];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setFromValue:fromColors];
    [animation setToValue:toColors];
    [animation setDuration:self.animationDuration];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDelegate:self];
    
    [layer addAnimation:animation forKey:@"Gradient Animation"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if ([self isAnimating]) {
        [self performSelector:@selector(performAnimation) withObject:nil afterDelay:self.animationDelay];
    } else {
        if ([self.delegate respondsToSelector:@selector(gradientViewAnimationDidStop:)]) {
            [self.delegate gradientViewAnimationDidStop:self];
        }
    }
}

- (void)startAnimating
{
    if (![self isAnimating]) {
        animating = YES;
        [self performAnimation];
    }
}

- (void)startAnimatingAfterDelay
{
    if (![self isAnimating]) {
        animating = YES;
        [self performSelector:@selector(performAnimation) withObject:nil afterDelay:self.animationDelay];
    }
}

- (void)stopAnimating
{
    if ([self isAnimating]) {
        animating = NO;
    }
}

- (void)stopAnimatingImmediately
{
    if ([self isAnimating]) {
        animating = NO;
        [self.layer removeAllAnimations];
    }
}

@end
