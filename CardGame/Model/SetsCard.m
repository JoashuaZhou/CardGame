//
//  SetsCard.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-29.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "SetsCard.h"

@implementation SetsCard

- (NSString *)contents
{
    return nil;
}

- (int)match:(NSArray *)otherCards
{
/*    int matchScore = 0;
    
    NSMutableArray *cardColor = [[NSMutableArray alloc]initWithObjects:@(self.color), nil];
    NSMutableArray *cardNumber = [[NSMutableArray alloc]initWithObjects:@(self.number), nil];
    NSMutableArray *cardShading = [[NSMutableArray alloc]initWithObjects:@(self.shading), nil];
    NSMutableArray *cardSymbol = [[NSMutableArray alloc]initWithObjects:@(self.symbol), nil];
    
    for (SetsCard *otherCard in otherCards) {
        [cardColor addObject:@(otherCard.color)];
        [cardNumber addObject:@(otherCard.number)];
        [cardShading addObject:@(otherCard.shading)];
        [cardSymbol addObject:@(otherCard.symbol)];
    }
    
    int cardCount = 0;
    
    if ([self isASet:cardColor]) {
        cardCount++;
    }
    if ([self isASet:cardNumber]) {
        cardCount++;
    }
    if ([self isASet:cardShading]) {
        cardCount++;
    }
    if ([self isASet:cardSymbol]) {
        cardCount++;
    }
    
    if (cardCount == 4) {
        matchScore = 1;
    }
    
    return matchScore;
 */
    int matchScore = 0;
    
    if ([otherCards count] == 2) {
        id card1 = [otherCards firstObject];
        id card2 = [otherCards lastObject];
        if ([card1 isKindOfClass:[SetsCard class]] && [card2 isKindOfClass:[SetsCard class]]) {
            SetsCard *otherCard1 = (SetsCard *)card1;
            SetsCard *otherCard2 = (SetsCard *)card2;
            if ([self isASet:otherCard1 card2:otherCard2]) {
                matchScore = 1;
            }
        }
    }
    
    return matchScore;
}

- (BOOL)isASet:(SetsCard *)card1 card2:(SetsCard *)card2
{
    int cardCount = 0;
    if (self.color == card1.color && self.color == card2.color) {
        cardCount++;
    }else if (self.color != card1.color && self.color != card2.color && card1.color != card2.color)
    {
        cardCount++;
    }
    if (self.number == card1.number && self.number == card2.number) {
        cardCount++;
    }else if (self.number != card1.number && self.number != card2.number && card1.number != card2.number)
    {
        cardCount++;
    }
    if (self.shading == card1.shading && self.shading == card2.shading) {
        cardCount++;
    }else if (self.shading != card1.shading && self.shading != card2.shading && card1.shading != card2.shading)
    {
        cardCount++;
    }
    if (self.symbol == card1.symbol && self.symbol == card2.symbol) {
        cardCount++;
    }else if (self.symbol != card1.symbol && self.symbol != card2.symbol && card1.symbol != card2.symbol)
    {
        cardCount++;
    }
    
    if (cardCount == 4) {
        return YES;
    }
    
    return NO;
}

/*
- (BOOL)isASet:(NSMutableArray *)cardFeature
{
    int cardCount = [cardFeature count];
    if (cardCount == 1 || cardCount == 3) {
        return YES;
    }
    return NO;
}*/

+ (NSArray *)validColor
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbol
{
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validShading
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validNumber
{
    return @[@1, @2, @3];   //@+数字：NSNumber
}

@end
