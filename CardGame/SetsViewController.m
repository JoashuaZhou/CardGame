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

@end

@implementation SetsViewController

- (SetsCardDeck *)createDeck
{
    return [[SetsCardDeck alloc] init];
}


- (void)updateViewforCard:(UIView *)view card:(Card *)card
{
    if ([view isKindOfClass:[SetCardView class]] && [card isKindOfClass:[SetsCard class]]) {
        SetsCard *setcard = (SetsCard *)card;
        SetCardView *cardView = (SetCardView *)view;
        cardView.symbol = setcard.symbol;
        cardView.color = setcard.color;
        cardView.shading = setcard.shading;
        cardView.number = setcard.number;
        cardView.chosen = setcard.chosen;
    }
}

- (UIView *)createView:(Card *)card withFrame:(CGRect)frame
{
    if ([card isKindOfClass:[SetsCard class]]) {
        SetsCard *playingCard = (SetsCard *)card;
        SetCardView *cardView = [[SetCardView alloc] initWithFrame:frame]; //initWithFrame is designated initializer
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:cardView action:@selector(tapGestureHandler)];
        [cardView addGestureRecognizer:tapRecognizer];
        [self updateViewforCard:cardView card:playingCard];
        return cardView;
    }
    return nil;
}

#pragma mark - initiate startCardsAmount

#define startCardsAmount 12;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startCardsNumber = startCardsAmount;
    self.cardSize = CGSizeMake(64, 96);
    [self updateUI];
}

@end
