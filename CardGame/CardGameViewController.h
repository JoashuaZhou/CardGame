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

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;    //abstract   //lecture 6, make abstract method public, so others can implement it
- (void)updateUI;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@property (strong, nonatomic) NSMutableArray *record;

@end
