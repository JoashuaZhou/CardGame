//
//  PlayingCardViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-26.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//
//  subclass of CardGameViewController

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CardMatchingHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *historyController = (GameHistoryViewController *)segue.destinationViewController;
            historyController.cardMatchingText = [[NSString alloc] init];
            for (NSString *recordString in self.record) {
                    historyController.cardMatchingText = [historyController.cardMatchingText stringByAppendingFormat:@"%@\n", recordString];
            }
        }
    }
}

- (PlayingCardDeck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    if (card.isChosen) {
        return [[NSAttributedString alloc] initWithString:card.contents attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];   //无属性的AtrributedString就是NSString, 不过字体颜色和Global tint颜色一样
    }
    
    return [[NSAttributedString alloc] initWithString:@""];     //alloc + init各种形式， AtrributeString和String的联系
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

@end
