//
//  CardGameViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-16.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//
//  Blocks就是函数指针

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;   //自己定义的就用strong，IBOutlet就用weak
@property (strong, nonatomic) NSMutableArray *gamecards;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *robotSays;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startCardsNumber usingDeck:[self createDeck]];
    }
    return _game;
}

- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.minimumNumberOfCells = self.startCardsNumber;
        _grid.cellAspectRatio = self.cardSize.width / self.cardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}

- (NSMutableArray *)gamecards
{
    if (!_gamecards) {
        _gamecards = [[NSMutableArray alloc] initWithCapacity:self.startCardsNumber];
    }
    return _gamecards;
}

- (Deck *)createDeck
{
    return nil;
}

- (void)updateUI
{
    CGRect frame;   //CGRect不用指针*
    Card *card;
    for (int row = 0; row < self.grid.rowCount/*[self.game numbersOfDealCards]*/; row++) {
        for (int column = 0; column < self.grid.columnCount; column++) {
            card = [self.game cardAtIndex:row];
            frame = [self.grid frameOfCellAtRow:row inColumn:column];
            UIView *cardView = [self createView:card withFrame:frame];
            [self.gridView addSubview:cardView];    //如果没有这句话，纸牌将不能显示在屏幕上
        }
   // UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 64, 96)];
    //if (card == nil) {
   //     cardView.backgroundColor = [UIColor blueColor];
    //}else
     //   cardView.backgroundColor = [UIColor greenColor];
    }
}

- (void)updateViewforCard:(UIView *)view card:(Card *)card
{
    
}

- (UIView *)createView:(Card *)card withFrame:(CGRect)frame
{
    return nil;
}

@end
