//
//  PlayingCard.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-19.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {                          //2-card mode
        id card = [otherCards firstObject];             //introspection
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;   //introspection
            // PlayingCard *otherCard = [otherCards firstObject];     original code which doesn't use introspection
            if (otherCard.rank == self.rank) {
                score = 4;
            }else if ([otherCard.suit isEqualToString:self.suit])
                score = 1;
        }
    }
    
    if ([otherCards count] == 2) {                          //3-card mode
        id card1 = [otherCards firstObject];                //introspection
        id card2 = [otherCards lastObject];
        if ([card1 isKindOfClass:[PlayingCard class]] && [card2 isKindOfClass:[PlayingCard class]]) {
            PlayingCard *selectedCard1 = (PlayingCard *)card1;
            PlayingCard *selectedCard2 = (PlayingCard *)card2;
            if (selectedCard1.rank == self.rank && selectedCard2.rank == self.rank) {
                score = 12;
            }else if ([selectedCard1.suit isEqualToString:self.suit] && [selectedCard2.suit isEqualToString:self.suit])
                score = 3;
        }
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
