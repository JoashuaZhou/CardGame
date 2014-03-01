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

- (CardView *)createView:(Card *)card withFrame:(CGRect)frame
{
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        PlayingCardView *cardView = [[PlayingCardView alloc] initWithFrame:frame]; //initWithFrame is designated initializer
//        cardView.delegate = self;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        [cardView addGestureRecognizer:tapRecognizer];
        cardView.rank = playingCard.rank;
        cardView.suit = playingCard.suit;
        cardView.chosen = playingCard.isChosen;
        [self.gamecards addObject:cardView];
        return cardView;
    }
    return nil;
}

- (IBAction)restartGame:(UIButton *)sender
{
    for (CardView *cardView in self.gamecards)
    {
        [cardView removeFromSuperview];
    }
    sleep(2);
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.startCardsNumber usingDeck:[self createDeck]];
    self.gamecards = [[NSMutableArray alloc] initWithCapacity:self.startCardsNumber];
    [self initialUI];
}

#pragma mark - initiation
#define startCardsAmount 20;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startCardsNumber = startCardsAmount;
    self.cardSize = CGSizeMake(64, 96);
    [self initialUI];
}

@end
