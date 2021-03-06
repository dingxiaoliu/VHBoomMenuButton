//
//  ShareVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/17.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "ShareVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface ShareVC ()

@property (weak, nonatomic) IBOutlet UISlider *showDelaySlider;
@property (weak, nonatomic) IBOutlet UISlider *showDurationSlider;
@property (weak, nonatomic) IBOutlet UISlider *hideDelaySlider;
@property (weak, nonatomic) IBOutlet UISlider *hideDurationSlider;

@property (weak, nonatomic) IBOutlet UILabel *showDelayLabel;
@property (weak, nonatomic) IBOutlet UILabel *showDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *hideDelayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hideDurationLabel;

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;

@end

@implementation ShareVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeBMB:self.bmb1 withDifferentPieceColor:NO];
    [self initializeBMB:self.bmb2 withDifferentPieceColor:YES];
    [self initializeBMB:self.bmb3 withDifferentPieceColor:NO];
    
    self.bmb1.shareLineLength = 25;
    self.bmb1.shareLineWidth = 3;
    self.bmb1.dotRadius = 6;
    
    self.bmb3.shareLine1Color = [UIColor blackColor];
    self.bmb3.shareLine2Color = [UIColor blackColor];
    
    [self onSliderValueChanged:self.showDelaySlider];
    [self onSliderValueChanged:self.showDurationSlider];
    [self onSliderValueChanged:self.hideDelaySlider];
    [self onSliderValueChanged:self.hideDurationSlider];
}

- (void)initializeBMB:(VHBoomMenuButton *)bmb withDifferentPieceColor:(BOOL)differentPieceColor
{
    bmb.buttonEnum = VHButtonTextInsideCircle;
    bmb.piecePlaceEnum = VHPiecePlaceShare;
    bmb.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    // Notice that you should use 'buttonNumber' as a loop number.
    // Because [VHBoomMenuButton pieceNumber] could NOT know the number of the pieces
    // when the piece-place-enum is Share.
    for (int i = 0; i < bmb.buttonNumber; i++)
    {
        if (differentPieceColor)
        {
            [bmb addBuilder:[BuilderManager textInsideCircleButtonBuilderWithDifferentPieceColor]];
        }
        else
        {
            [bmb addBuilder:[BuilderManager textInsideCircleButtonBuilder]];
        }
    }
}

#pragma mark - Sliders

- (IBAction)onSliderValueChanged:(UISlider *)sender
{
    if (sender == self.showDelaySlider)
    {
        self.showDelayLabel.text = [NSString stringWithFormat:@"Show delay = %.0lf ms", sender.value];
        self.bmb1.showDelay = self.bmb2.showDelay = self.bmb3.showDelay = sender.value / 1000;
    }
    else if (sender == self.showDurationSlider)
    {
        self.showDurationLabel.text = [NSString stringWithFormat:@"Show duration = %.0lf ms", sender.value];
        self.bmb1.showDuration = self.bmb2.showDuration = self.bmb3.showDuration = sender.value / 1000;
    }
    else if (sender == self.hideDelaySlider)
    {
        self.hideDelayLabel.text = [NSString stringWithFormat:@"Hide delay = %.0lf ms", sender.value];
        self.bmb1.hideDelay = self.bmb2.hideDelay = self.bmb3.hideDelay = sender.value / 1000;
    }
    else if (sender == self.hideDurationSlider)
    {
        self.hideDurationLabel.text = [NSString stringWithFormat:@"Hide duration = %.0lf ms", sender.value];
        self.bmb1.hideDuration = self.bmb2.hideDuration = self.bmb3.hideDuration = sender.value / 1000;
    }
}

@end
