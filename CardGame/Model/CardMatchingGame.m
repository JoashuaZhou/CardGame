//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-21.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;  //of cards

@end

@implementation CardMatchingGame

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2; //Also can use #define, but in this way we can define the type like int, char and etc.
static const int COST_TO_CHOOSE = 1;


- (NSMutableArray *)cards       //Lazy instantiation
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];   //super class's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

/*
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;                       //如果选择已翻过来的牌，就会翻回去
        }else{
            for (Card *otherCard in self.cards) {           //误解：UI上对纸牌的点击并不会造成chosen=YES，要在model这里实现chosen=YES！
                if (otherCard.isChosen && !otherCard.isMatched) {  //牌堆里已经有一个牌已经被选中的情况，otherCard就是之前被选中的牌
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}*/

- (NSString *)chooseCardAtIndex:(NSUInteger)index                   //Assignment 2, 3-card mode
{
    NSString *robotSays = @"";              //这种初始化, 而不是nil
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }else{
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            int cardAmount = [otherCards count];
/*            if (cardAmount == 1) {
                if (![card match:@[otherCards.lastObject]]) {
                    self.score -= MISMATCH_PENALTY;
                    ((Card *)otherCards.lastObject).chosen = NO;       //数组中取出来的类型是id，所以要转化一下
                }
            }*/
            if (cardAmount == 2) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    ((Card *)otherCards.firstObject).matched = YES;     //别忘了
                    ((Card *)otherCards.lastObject).matched = YES;      //别忘了
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    ((Card *)otherCards.firstObject).chosen = NO;   //firstObject和lastObject的优势是：当数组为空的时候返回nil，而不会出错
                    ((Card *)otherCards.lastObject).chosen = NO;
                    robotSays = [NSString stringWithFormat:@"%@, %@ and %@ doesn't match! %d points penalty", card.contents, ((Card *)otherCards.firstObject).contents, ((Card *)otherCards.lastObject).contents, MISMATCH_PENALTY];
                }
            }
            self.score -= COST_TO_CHOOSE;                           //牌堆里之前没有牌被选中
            card.chosen = YES;
            if (card.isMatched) {
                robotSays = [NSString stringWithFormat:@"%@, %@ and %@ match! Get %d points", card.contents, ((Card *)otherCards.firstObject).contents, ((Card *)otherCards.lastObject).contents, self.score];
            }
            if ([robotSays isEqualToString:@""]) {
                robotSays = [NSString stringWithFormat:@"You chose %@", card.contents];
            }
            // robotSays = [robotSays stringByAppendingString:@"sss"];  正确用法
        }
    }
    return robotSays;
}

- (void)resetScore
{
    self.score = 0;
}

@end
