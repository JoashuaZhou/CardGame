//
//  CardGameViewController.h
//  CardGame
//
//  Created by Joshua Zhou on 14-1-16.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "Deck.h"
#import "GameHistoryViewController.h"
#import "Grid.h"
#import "CardView.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;    //abstract   //lecture 6, make abstract method public, so others can implement it
- (void)initialUI;
- (void)updateUI;
- (CardView *)createView:(Card *)card withFrame:(CGRect)frame;
- (void)tapGestureHandler:(UITapGestureRecognizer *)tapRecognizer;

@property (strong, nonatomic) NSMutableArray *gamecards;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (nonatomic) NSInteger startCardsNumber;
@property (nonatomic) CGSize cardSize;


@property (strong, nonatomic) CardMatchingGame *game;   //自己定义的就用strong，IBOutlet就用weak

@end
