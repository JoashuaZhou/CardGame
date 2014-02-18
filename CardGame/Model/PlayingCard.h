//
//  PlayingCard.h
//  CardGame
//
//  Created by Joshua Zhou on 14-1-19.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSUInteger)maxRank;
+ (NSArray *)validSuits;

@end
