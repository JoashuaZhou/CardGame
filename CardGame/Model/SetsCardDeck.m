//
//  SetsCardDeck.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-29.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "SetsCardDeck.h"
#import "SetsCard.h"

@implementation SetsCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetsCard validSymbol]) {
            for (NSString *color in [SetsCard validColor]) {
                for (NSString *shading in [SetsCard validShading]) {
                    for (NSUInteger number = 1; number <= [[SetsCard validNumber] count]; number++) {
                        SetsCard *card = [[SetsCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.number = number;
                        card.shading = shading;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return  self;
}

@end
