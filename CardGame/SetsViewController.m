//
//  SetsViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-2-8.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "SetsViewController.h"

@interface SetsViewController ()

@end

@implementation SetsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SetsHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *historyController = (GameHistoryViewController *)segue.destinationViewController;
            historyController.setCardText = [[NSString alloc] init];
            for (NSString *recordString in self.record) {
                historyController.setCardText = [historyController.setCardText stringByAppendingFormat:@"%@\n", recordString];
            }
        }
    }
}

- (SetsCardDeck *)createDeck
{
    return [[SetsCardDeck alloc] init];
}

- (NSMutableDictionary *)attributedDictionary:(Card *)card
{
    NSMutableDictionary *attributedDictionary = [[NSMutableDictionary alloc] init];
    if ([card isKindOfClass:[SetsCard class]]) {
        SetsCard *setCard = (SetsCard *)card;
        UIColor *cardColor = [self colorDictionary:setCard.color];
        if ([setCard.shading isEqualToString:@"solid"]) {
            attributedDictionary[NSForegroundColorAttributeName] = cardColor;   //NSMutableDictionary可以这样用
        }
        if ([setCard.shading isEqualToString:@"striped"])
        {
            attributedDictionary[NSStrokeColorAttributeName] = cardColor;
            attributedDictionary[NSStrokeWidthAttributeName] = @-3;
            attributedDictionary[NSForegroundColorAttributeName] = [cardColor colorWithAlphaComponent:0.2];
        }
        if ([setCard.shading isEqualToString:@"open"])
        {
            attributedDictionary[NSStrokeColorAttributeName] = cardColor;
            attributedDictionary[NSStrokeWidthAttributeName] = @-3;
            attributedDictionary[NSForegroundColorAttributeName] = [UIColor clearColor];    //透明
        }
    }
    return attributedDictionary;
}

- (UIColor *)colorDictionary:(NSString *)colorString
{
    NSDictionary *colorDictionary = @{@"green": [UIColor greenColor],
                                      @"red":   [UIColor redColor],
                                      @"purple":[UIColor purpleColor]};
    return colorDictionary[colorString];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    if ([card isKindOfClass:[SetsCard class]]) {
        SetsCard *setCard = (SetsCard *)card;
        NSMutableString *cardString = [[NSMutableString alloc] initWithString:setCard.symbol];
        for (int i = 0; i < (setCard.number-1); i++) {
            [cardString appendString:@"\n"];
            [cardString appendString:setCard.symbol];
        }
        NSAttributedString *cardContent = [[NSAttributedString alloc] initWithString:cardString attributes:[self attributedDictionary:setCard]];
        return cardContent;
    }
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"SetCard_Chosen" : @"CardFront"];
}

@end
