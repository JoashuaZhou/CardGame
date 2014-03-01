//
//  SetsViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-2-8.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "SetsViewController.h"
#import "SetCardView.h"
#import "SetsCardDeck.h"
#import "SetsCard.h"

@interface SetsViewController ()
@property (strong, nonatomic) SetsCardDeck *setsDeck;
@end

@implementation SetsViewController

- (SetsCardDeck *)createDeck
{
    return [[SetsCardDeck alloc] init];
}
-(SetsCardDeck *)setsDeck{
    if (!_setsDeck) {
        _setsDeck = [SetsCardDeck new];
    }
    return _setsDeck;
}

- (void)updateUI
{
    for (CardView *cardView in self.gamecards) {
        NSInteger index = [self.gamecards indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:index];
        cardView.chosen = card.isChosen;
        cardView.matched = card.isMatched;
        if (cardView.matched) {
            //          [self.gamecards removeObjectAtIndex:index]; 为什么不行？因为remove之后，cardView后面的元素序号全变了
            [CardView transitionWithView:cardView duration:1.8 options:UIViewAnimationOptionBeginFromCurrentState animations:^{ cardView.alpha = 0; } completion:^(BOOL fin){ if(fin)[cardView removeFromSuperview];}];
        }
    }
}

- (CardView *)createView:(Card *)card withFrame:(CGRect)frame
{
    if ([card isKindOfClass:[SetsCard class]]) {
        SetsCard *setsCard = (SetsCard *)card;
        SetCardView *cardView = [[SetCardView alloc] initWithFrame:frame]; //initWithFrame is designated initializer
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        [cardView addGestureRecognizer:tapRecognizer];
        cardView.symbol = setsCard.symbol;
        cardView.shading = setsCard.shading;
        cardView.color = setsCard.color;
        cardView.number = setsCard.number;
        cardView.chosen = setsCard.isChosen;
        [self.gamecards addObject:cardView];
        return cardView;
    }
    return nil;
}

- (IBAction)dealCards:(UIButton *)sender
{
    for (SetCardView *cardView in self.gamecards) {
        if (cardView.matched) {
            Card *card = [self.setsDeck drawRandomCard];
            if ([card isKindOfClass:[SetsCard class]]) {
                SetsCard *setsCard = (SetsCard *)card;
                NSUInteger index = [self.gamecards indexOfObject:cardView];
                [self.game replaceCardAtIndex:index withCard:setsCard];
                cardView.symbol = setsCard.symbol;
                cardView.shading = setsCard.shading;
                cardView.color = setsCard.color;
                cardView.number = setsCard.number;
                cardView.chosen = setsCard.isChosen;
                cardView.matched = setsCard.isMatched;
                [CardView transitionWithView:cardView duration:2.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{ cardView.alpha = 1.0; } completion:^(BOOL fin){ [self.gridView addSubview:cardView]; }];
            }
         }
    }
}

#pragma mark - initiate startCardsAmount

#define startCardsAmount 12;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startCardsNumber = startCardsAmount;
    self.cardSize = CGSizeMake(64, 96);
    [self initialUI];
}

@end
