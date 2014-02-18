//
//  Card.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-19.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
