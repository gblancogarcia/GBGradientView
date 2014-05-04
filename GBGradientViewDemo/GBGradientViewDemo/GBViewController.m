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

const CGFloat ColorAnimationDuration = 1.0f;
const CGFloat ColorAnimationDelay = 1.0f;

@interface GBViewController ()

@property (nonatomic, strong) GBGradientView *backgroundView;
@property (nonatomic, strong) UIColor *highColor;
@property (nonatomic, strong) UIColor *lowColor;
@property (nonatomic, strong) GBRoundBorderedButton *button;
@property (nonatomic, strong) NSMutableArray *colors;

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
    if (_colors) {
        self.highColor = [UIColor nextColor:self.highColor];
        self.lowColor = [UIColor nextColor:self.lowColor];
    }
    
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
    [self setupBackgroundView];
    
    CGRect frame = CGRectMake(0.0f, 0.0f, 200.0f, 48.0f);
    
    self.button = [[GBRoundBorderedButton alloc] initWithFrame:frame];

    self.button.center = self.view.center;
    self.button.color = [UIColor whiteColor];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.button setTitle:@"Start" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(startOrStop) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.button];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.button
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0f
                                                                constant:200.0f];
    [self.view addConstraint:width];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.button
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0f
                                                              constant:48.0f];
    [self.view addConstraint:height];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.button
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    [self.view addConstraint:centerX];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.button
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:0.0f];
    [self.view addConstraint:centerY];
}

-(void)startOrStop
{
    if ([self.button.titleLabel.text isEqualToString:@"Start"]) {
        [self.button setTitle:@"Stop" forState:UIControlStateNormal];
        [self.backgroundView startAnimating];
    } else {
        [self.backgroundView stopAnimating];
        self.button.enabled = NO;
    }
}

- (void)updateUI
{

}

- (void)setupBackgroundView
{
    if (!self.backgroundView) {
        self.backgroundView = [[GBGradientView alloc] initWithFrame:self.view.bounds
                                                        orientation:GBGradientViewOrientationVertical];
        
        self.backgroundView.delegate = self;
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        
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

- (NSArray *)gradientColorsForGradientView:(GBGradientView *)gradientView
{
    return [self.colors mutableCopy];
}

- (void)gradientViewAnimationDidStop:(GBGradientView *)gradientView
{
    if (self.backgroundView.isAnimating == NO) {
        self.button.enabled = YES;
        [self.button setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
