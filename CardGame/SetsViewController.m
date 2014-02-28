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
                [self.gridView addSubview:cardView];
            }
         }
    }
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tapRecognizer
{
    CardView *cardView = (CardView *)tapRecognizer.view;
    int index = [self.gamecards indexOfObject:cardView];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
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
