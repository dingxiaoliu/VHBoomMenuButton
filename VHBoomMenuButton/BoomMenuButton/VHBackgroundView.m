//
//  VHBackgroundView.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHBackgroundView.h"
#import "VHAnimationManager.h"

@interface VHBackgroundView ()

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) NSMutableArray<UIView *> *goneViews;

@end

@implementation VHBackgroundView

#pragma mark - In-BMB-Only Methods

- (void)dim:(CFTimeInterval)duration
 completion:(void (^ __nullable)(BOOL finished))completion
{
    self.hidden = NO;
    if (self.blurBackground && [UIVisualEffectView class])
    {
        self.visualEffectView.effect = nil;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.visualEffectView.effect = self.blurEffect;
        } completion:completion];
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundColor = self.dimColor;
        } completion:completion];
    }
    
    CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                         delay:0
                                                                      duration:duration
                                                                        values:@[@(0), @(1)]];
    [VHAnimationManager addAnimation:opacityAnimation toViews:self.goneViews];
}

- (void)light:(CFTimeInterval)duration
   completion:(void (^ __nullable)(BOOL finished))completion
{
    if (self.blurBackground && [UIVisualEffectView class])
    {
        self.visualEffectView.effect = self.blurEffect;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.visualEffectView.effect = nil;
        } completion:completion];
    }
    else
    {
        self.backgroundColor = self.dimColor;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundColor = [UIColor clearColor];
        } completion:completion];
    }
    
    CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                         delay:0
                                                                      duration:duration
                                                                        values:@[@(1), @(0)]];
    [VHAnimationManager addAnimation:opacityAnimation toViews:self.goneViews];
}

- (void)removeAllBoomButtons
{
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[VHBoomButton class]])
        {
            [view removeFromSuperview];
        }
    }
}

- (void)removeAllAnimations
{
    if ([UIVisualEffectView class])
    {
        [self.visualEffectView.layer removeAllAnimations];
    }
    for (UIView *view in self.goneViews)
    {
        [view.layer removeAllAnimations];
    }
}

- (void)addGoneView:(UIView *)view
{
    if (!self.goneViews)
    {
        self.goneViews = [NSMutableArray arrayWithCapacity:1];
    }
    [self.goneViews addObject:view];
    [self addSubview:view];
}

- (void)adjustTipLabel:(BOOL)tipBelowButton
   withTipButtonMargin:(CGFloat)tipButtonMargin
       withEndPosition:(NSArray<NSValue *> * _Nullable)endPositions
      withButtonHeight:(CGFloat)buttonHeight
{
    CGRect frame = self.tipLabel.frame;
    frame.origin.x = self.bounds.size.width / 2 - frame.size.width / 2;
    if (tipBelowButton)
    {
        CGFloat maxY = CGFLOAT_MIN;
        for (NSValue *value in endPositions)
        {
            maxY = MAX(maxY, [value CGPointValue].y);
        }
        frame.origin.y = maxY + buttonHeight / 2 + tipButtonMargin;
    }
    else
    {
        CGFloat minY = CGFLOAT_MAX;
        for (NSValue *value in endPositions)
        {
            minY = MIN(minY, [value CGPointValue].y);
        }
        frame.origin.y = minY - buttonHeight / 2 - tipButtonMargin - frame.size.height;
    }
    self.tipLabel.frame = frame;
    [self bringSubviewToFront:self.tipLabel];
}

- (void)setBlurBackground:(BOOL)blurBackground
{
    _blurBackground = blurBackground;
    if ([UIVisualEffectView class])
    {
        if (blurBackground)
        {
            if (!self.visualEffectView)
            {
                self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:nil];
                self.visualEffectView.frame = self.bounds;
                [self addSubview:self.visualEffectView];
            }
        }
        else
        {
            [self.visualEffectView removeFromSuperview];
            self.visualEffectView = nil;
        }
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if ([UIVisualEffectView class])
    {
        self.visualEffectView.frame = self.bounds;
    }
}

- (void)setTip:(NSString *)tip
{
    _tip = tip;
    self.tipLabel.text = tip;
    [self.tipLabel sizeToFit];
    CGRect frame = self.tipLabel.frame;
    frame.origin.x = self.bounds.size.width / 2 - frame.size.width / 2;
    self.tipLabel.frame = frame;
}

- (void)setTipLabel:(UILabel *)tipLabel
{
    [_tipLabel removeFromSuperview];
    [self.goneViews removeObject:_tipLabel];
    _tipLabel = tipLabel;
    [self addGoneView:_tipLabel];
}

#pragma mark - Private Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = _tip;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        [self addGoneView:_tipLabel];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(onBackgroundClick)])
    {
        [self.delegate onBackgroundClick];
    }
}

@end
