//
//  CardGameViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-16.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//
//  Blocks就是函数指针

#import "CardGameViewController.h"


@interface CardGameViewController ()

//@property (strong, nonatomic) CardMatchingGame *game;   //自己定义的就用strong，IBOutlet就用weak
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

//- (void)flipCard:(CardView *)cardView
//{
//    [CardView transitionWithView:cardView duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ cardView.chosen = !cardView.chosen; } completion:^(BOOL fin){ [self updateUI]; }];
//}

- (void)updateUI
{
    for (CardView *cardView in self.gamecards) {
        NSInteger index = [self.gamecards indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:index];
        if (cardView.chosen != card.isChosen) {
            [CardView transitionWithView:cardView duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ cardView.chosen = card.isChosen; } completion:^(BOOL fin){}];      //flip cards
        }
        cardView.matched = card.isMatched;
        if (cardView.matched) {
//          [self.gamecards removeObjectAtIndex:index]; 为什么不行？因为remove之后，cardView后面的元素序号全变了
            [CardView transitionWithView:cardView duration:1.8 options:UIViewAnimationOptionBeginFromCurrentState animations:^{ cardView.alpha = 0; } completion:^(BOOL fin){ if(fin)[cardView removeFromSuperview];}];
        }
    }
}

- (void)initialUI
{
    CGRect frame;   //CGRect不用指针*
    Card *card;
    NSInteger i = 0;
    for (int row = 0; row < self.grid.rowCount/*[self.game numbersOfDealCards]*/; row++) {
        for (int column = 0; column < self.grid.columnCount; column++) {
            card = [self.game cardAtIndex:i];
            frame = [self.grid frameOfCellAtRow:row inColumn:column];
            CardView *cardView = [self createView:card withFrame:frame];
            [self.gridView addSubview:cardView];    //如果没有这句话，纸牌将不能显示在屏幕上
            i++;
        }
    }
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tapRecognizer
{
    CardView *cardView = (CardView *)tapRecognizer.view;
    int index = [self.gamecards indexOfObject:cardView];
    [self.game chooseCardAtIndex:index];
//    [self flipCard:cardView];
    [self updateUI];
}

- (CardView *)createView:(Card *)card withFrame:(CGRect)frame
{
    return nil;
}

@end
