//
//  HamButtonVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/13.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "HamButtonVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface HamButtonVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSString *> *datas;
@property (nonatomic, strong) NSMutableArray<NSValue *> *piecesAndButtons;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HamButtonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonHam;
    
    [self initializeDatas];
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)initializeDatas
{
    self.datas = [NSMutableArray array];
    self.piecesAndButtons = [NSMutableArray array];
    [BuilderManager initializeDatasForHamButton:self.datas piecesAndButtons:self.piecesAndButtons];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bmb.piecePlaceEnum = [[self.piecesAndButtons objectAtIndex:indexPath.row] CGPointValue].x;
    self.bmb.buttonPlaceEnum = [[self.piecesAndButtons objectAtIndex:indexPath.row] CGPointValue].y;
    [self.bmb clearBuilders];
    for (int i = 0; i < self.bmb.pieceNumber; i++)
    {
        [self.bmb addBuilder:[BuilderManager hamButtonBuilder]];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HamButtonVCIdentifier = @"HamButtonVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HamButtonVCIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HamButtonVCIdentifier];
    }
    
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    return cell;
}

@end
