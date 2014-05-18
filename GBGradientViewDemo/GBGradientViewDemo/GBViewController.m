//
//  GBViewController.m
//  GBMeditation
//
//  Created by Gerardo Blanco García on 25/04/14.
//  Copyright (c) 2014 gblancogarcia. All rights reserved.
//

#import "GBViewController.h"

#import "GBRoundBorderedButton.h"
#import "UIColor+Utils.h"

#import <QuartzCore/QuartzCore.h>

const CGFloat ColorAnimationDelay = 1.0f;

@interface GBViewController ()

@property (nonatomic, strong) GBGradientView *backgroundView;
@property (nonatomic, strong) UIColor *highColor;
@property (nonatomic, strong) UIColor *lowColor;
@property (nonatomic, strong) GBRoundBorderedButton *playButton;
@property (nonatomic, strong) GBRoundBorderedButton *animationDurationButton;
@property (nonatomic, strong) UIButton *orientationButton;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) GBGradientViewOrientation orientation;
@property(nonatomic) CGAffineTransform verticalOrientationTransform;
@property(nonatomic) CGAffineTransform horizontalOrientationTransform;

@property (nonatomic) BOOL keepColors;

@end

@implementation GBViewController

- (UIColor *)highColor
{
    if (!_highColor) {
        _highColor = [UIColor softCyanColor];
    }
    
    return _highColor;
}

- (UIColor *)lowColor
{
    if (!_lowColor) {
        _lowColor = [UIColor lightBlueColor];
    }
    
    return _lowColor;
}

- (NSMutableArray *)colors
{
    if (_colors && (self.keepColors == NO)) {
        self.highColor = [UIColor nextColor:self.highColor];
        self.lowColor = [UIColor nextColor:self.lowColor];
    }
    
    self.keepColors = NO;
    
    _colors = [NSMutableArray array];
    
    [_colors addObject:(id)[self.highColor CGColor]];
    [_colors addObject:(id)[self.lowColor CGColor]];
    
    return _colors;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.backgroundView stopAnimating];
}

- (void)setUp
{
    self.keepColors = false;
    self.animationDuration = 3.0f;
    
    [self setupBackgroundView];
    
    [self setUpPlayButton];
    [self setUpAnimationDurationButton];
    [self setUpOrientationButton];
}

- (void)setupBackgroundView
{
    if (!self.backgroundView) {
        self.orientation = GBGradientViewOrientationVertical;
        self.backgroundView = [[GBGradientView alloc] initWithFrame:self.view.bounds
                                                        orientation:self.orientation];
        
        self.backgroundView.delegate = self;
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundView.animationDuration = self.animationDuration;
        self.backgroundView.animationDelay = ColorAnimationDelay;
        
        [self.view addSubview:self.backgroundView];
        
        NSDictionary *views = @{@"backgroundView" : self.backgroundView};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];
    }
}

- (void)setUpPlayButton
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 128.0f, 44.0f);
    
    self.playButton = [[GBRoundBorderedButton alloc] initWithFrame:frame];
    
    self.playButton.center = self.view.center;
    self.playButton.color = [UIColor whiteColor];
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.playButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(startOrStop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.playButton];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.playButton
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0f
                                                              constant:128.0f];
    [self.view addConstraint:width];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.playButton
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:44.0f];
    [self.view addConstraint:height];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.playButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    [self.view addConstraint:centerX];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.playButton
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:8.0f];
    
    [self.view addConstraint:centerY];
}

- (void)setUpAnimationDurationButton
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    
    self.animationDurationButton = [[GBRoundBorderedButton alloc] initWithFrame:frame];
    
    NSString *title = [NSString stringWithFormat:@"%.0f", self.animationDuration];
    
    [self.animationDurationButton setTitle:title forState:UIControlStateNormal];
    [self.animationDurationButton addTarget:self action:@selector(changeAnimationDuration) forControlEvents:UIControlEventTouchUpInside];
    
    self.animationDurationButton.color = [UIColor whiteColor];
    
    [self.view addSubview:self.animationDurationButton];
    
    self.animationDurationButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.animationDurationButton
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0f
                                                              constant:44.0f];
    [self.view addConstraint:width];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.animationDurationButton
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:44.0f];
    [self.view addConstraint:height];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.animationDurationButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    [self.view addConstraint:centerX];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.animationDurationButton
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.playButton
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0f
                                                               constant:-24.0f];
    
    [self.view addConstraint:bottom];
}

- (void)setUpOrientationButton
{
    self.orientationButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 64.0f, 64.0f)];
    
    [self.orientationButton setImage:[UIImage imageNamed:@"OrientationButton"] forState:UIControlStateNormal];
    [self.orientationButton setImage:[UIImage imageNamed:@"OrientationButtonHighlighted"] forState:UIControlStateHighlighted];
    
    [self.orientationButton addTarget:self
                        action:@selector(switchGradientViewOrientation)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.orientationButton];
    
    [self.orientationButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.orientationButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    [self.view addConstraint:centerX];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.orientationButton
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.playButton
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:12.0f];
    
    [self.view addConstraint:top];
    
    self.verticalOrientationTransform = self.orientationButton.transform;
    self.horizontalOrientationTransform = CGAffineTransformRotate(self.orientationButton.transform, -M_PI_2);
}

- (void)updateUI
{
    
}

- (void)changeAnimationDuration
{
    self.animationDuration =  self.animationDuration + 1.0f;
    
    if (self.animationDuration > 5.0f) {
        self.animationDuration = 1.0f;
    }
    
    self.backgroundView.animationDuration = self.animationDuration;
    
    NSString *title = [NSString stringWithFormat:@"%.0f", self.animationDuration];
    [self.animationDurationButton setTitle:title forState:UIControlStateNormal];
}

- (void)startOrStop
{
    if ([self.playButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.playButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.backgroundView startAnimating];
    } else {
        [self.backgroundView stopAnimating];
        self.playButton.enabled = NO;
        self.animationDurationButton.enabled = NO;
        self.orientationButton.enabled = NO;
    }
}

- (void)switchGradientViewOrientation
{
    self.keepColors = YES;
    
    if (self.orientation == GBGradientViewOrientationHorizontal) {
        self.orientation = GBGradientViewOrientationVertical;
        self.orientationButton.transform = self.verticalOrientationTransform;
    } else {
        self.orientation = GBGradientViewOrientationHorizontal;
        self.orientationButton.transform = self.horizontalOrientationTransform;
    }
    
    self.backgroundView.orientation = self.orientation;
}

- (NSArray *)gradientColorsForGradientView:(GBGradientView *)gradientView
{
    return [self.colors mutableCopy];
}

- (void)gradientViewAnimationDidStop:(GBGradientView *)gradientView
{
    if (self.backgroundView.isAnimating == NO) {
        self.playButton.enabled = YES;
        self.animationDurationButton.enabled = YES;
        self.orientationButton.enabled = YES;
        [self.playButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
