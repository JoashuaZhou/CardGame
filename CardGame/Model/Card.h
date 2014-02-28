//
//  Card.h
//  CardGame
//
//  Created by Joshua Zhou on 14-1-19.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic) NSUInteger viewTag;

- (int)match:(NSArray *)otherCards;

@end
