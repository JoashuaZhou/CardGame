//
//  PlayingCardViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-26.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//
//  subclass of CardGameViewController

#import "PlayingCardViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardViewController ()
@property (strong, nonatomic) Deck *deck;
@end

@implementation PlayingCardViewController

- (PlayingCardDeck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)updateViewforCard:(UIView *)view card:(Card *)card
{
    if ([view isKindOfClass:[PlayingCardView class]] && [card isKindOfClass:[PlayingCard class]]) {
        PlayingCardView *cardView = (PlayingCardView *)view;
        PlayingCard *playingCard = (PlayingCard *)card;
        cardView.rank = playingCard.rank;
        cardView.suit = playingCard.suit;
        cardView.faceUp = playingCard.chosen;
    }
}

- (UIView *)createView:(Card *)card withFrame:(CGRect)frame
{
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        PlayingCardView *cardView = [[PlayingCardView alloc] initWithFrame:frame]; //initWithFrame is designated initializer
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:cardView action:@selector(tapGestureHandler)];
        [cardView addGestureRecognizer:tapRecognizer];
        [self updateViewforCard:cardView card:playingCard];
        return cardView;
    }
    return nil;
}

#pragma mark - initiation
#define startCardsAmount 18;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startCardsNumber = startCardsAmount;
    self.cardSize = CGSizeMake(64, 96);
    [self updateUI];
}

@end
