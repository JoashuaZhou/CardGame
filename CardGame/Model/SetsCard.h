//
//  SetsCard.h
//  CardGame
//
//  Created by Joshua Zhou on 14-1-29.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "Card.h"

@interface SetsCard : Card

@property (nonatomic) NSString *color;
@property (nonatomic) NSString *shading;
@property (nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColor;
+ (NSArray *)validShading;
+ (NSArray *)validSymbol;
+ (NSArray *)validNumber;

@end
