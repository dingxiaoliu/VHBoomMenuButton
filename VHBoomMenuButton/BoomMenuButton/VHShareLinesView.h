//
//  VHShareLinesView.h
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/17.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VHShareLinesView : UIView

@property (nonatomic, strong) UIColor *line1Color;
@property (nonatomic, strong) UIColor *line2Color;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat processForLine1;
@property (nonatomic, assign) CGFloat processForLine2;

- (void)setPiecePositions:(NSMutableArray<NSValue *> *)piecePositions
                dotRadius:(CGFloat)dotRadius
                showDelay:(CFTimeInterval)showDelay
             showDuration:(CFTimeInterval)showDuration
                hideDelay:(CFTimeInterval)hideDelay
             hideDuration:(CFTimeInterval)hideDuration;

- (void)pieceStartShowAnimation:(NSUInteger)pieceIndex withDuration:(CFTimeInterval)duration;

- (void)pieceFinishHideAnimation:(NSUInteger)pieceIndex withDuration:(CFTimeInterval)duration;

@end
