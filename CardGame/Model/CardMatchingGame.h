//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Joshua Zhou on 14-1-21.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (NSString *)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)resetScore;                         //claim the method in .h file，makes it public

@property (nonatomic, readonly) NSInteger score;

@end
