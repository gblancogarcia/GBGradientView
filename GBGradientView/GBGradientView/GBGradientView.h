//
//  GBGradientView.h
//  GBMeditation
//
//  Created by Gerardo Blanco García on 25/04/14.
//  Copyright (c) 2014 gblancogarcia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, GBGradientViewOrientation) {
    GBGradientViewOrientationVertical,
    GBGradientViewOrientationHorizontal
};

@protocol GBGradientViewDelegate;

@interface GBGradientView : UIView {
    CALayer *maskLayer;
}

@property (nonatomic) GBGradientViewOrientation orientation;

@property (nonatomic) CGFloat animationDuration;

@property (nonatomic) CGFloat animationDelay;

@property (nonatomic, readonly, getter = isAnimating) BOOL animating;

@property (nonatomic, weak) id <GBGradientViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame
        orientation:(GBGradientViewOrientation)orientation;

- (id)initWithFrame:(CGRect)frame
        orientation:(GBGradientViewOrientation)orientation
           delegate:(id<GBGradientViewDelegate>)delegate;

- (void)startAnimating;

- (void)startAnimatingAfterDelay;

- (void)stopAnimating;

- (void)stopAnimatingImmediately;

- (void)reload;

@end

@protocol GBGradientViewDelegate <NSObject>

@optional

- (NSArray *)gradientColorsForGradientView:(GBGradientView *)gradientView;

- (void)gradientViewAnimationDidStop:(GBGradientView *)gradientView;

@end