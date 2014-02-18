//
//  CardGameViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-16.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "CardGameViewController.h"
//#import "PlayingCardDeck.h"   //lecture 6, for abstract class
#import "CardMatchingGame.h"

@interface CardGameViewController ()
/*
 Only used for lession 1~2 and assignment 1
 
@property (weak, nonatomic) IBOutlet UILabel *filpsLable;
@property (nonatomic) int filpsCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
 */
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *robotSays;
//@property (strong, nonatomic) NSMutableArray *record;         //大哥，需要分配空间的类型使用之前要lazy init！！！！！   //为什么要strong?
//@property (weak, nonatomic) IBOutlet UISlider *sliderValue;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        self.record = [[NSMutableArray alloc] init];    //又忘了使用前alloc + init
    }
    return _game;
}
/* assignment 2, extra credit
- (NSMutableArray *)record
{
    if (!_record) {
        _record = [[NSMutab=leArray alloc] init];
    }
    return _record;
}
 */

/*
 Only used for lession 1~2 and assignment 1
 
- (Deck *)deck
{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (void) setFilpsCount:(int)filpsCount
{
    _filpsCount = filpsCount;
    self.filpsLable.text = [NSString stringWithFormat:@"Filps Count:%d",self.filpsCount];
    //    NSLog(@"filpscount changed to %d",self.filpsCount);  //与终端相关，用于debug
}
*/

/*
- (PlayingCardDeck *)createDeck                                 //For readability, increase a method
{
    return [[PlayingCardDeck alloc] init];                      //误解：Superclass can initialze as a subclass  //Lazy instanlization(instanlize in getter)
}
 */

- (Deck *)createDeck
{
    return nil;         //lecture 6, for abstract method
}

- (IBAction)touchCardButton:(UIButton *)sender
{
/*  Only used for lession 1 ~ 2 & assignment 1
    if ([sender.currentTitle length]) {
        UIImage *cardImage = [UIImage imageNamed:@"CardBack"];  //else部分没有这句，合成到下一句话中，可读性强
        [sender setBackgroundImage:cardImage
                          forState:UIControlStateNormal];       //这样设置是为了可读性，一排下来就知道有什么参数
        [sender setTitle:@""
                forState:UIControlStateNormal];
        self.filpsCount++;        
    } else {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:@"CardFront"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents
                    forState:UIControlStateNormal];
            self.filpsCount++;
        }
    } */
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    NSString *robotSays = @"";            //初始化时不能只是NSString *robotSays; 要像这样初始化
    robotSays = [robotSays stringByAppendingString:[self.game chooseCardAtIndex:chosenButtonIndex]];
    self.robotSays.text = robotSays;
    if (robotSays.length >= 20) {
        [self.record addObject:robotSays];
    }
//    [self addRecord:robotSays];
    [self updateUI];
}
/* assignment 2, extra credit
- (void)addRecord:(id)string        //Assignment 2, extra credit
{
    if ([self.record count] >= 10) {
        [self.record removeObjectAtIndex:0];        //删除前面的元素后，后面的所有元素前移一位
    }
    [self.record addObject:string];
    self.sliderValue.maximumValue++;
    self.sliderValue.value = self.sliderValue.maximumValue;
}
 */

- (IBAction)restartGame                 //Assignment 2
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        card.chosen = NO;
        card.matched = NO;
    }
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    //[self.robotSays.text isEqualToString:@"  Robot:   Choose mode and Start!"];
    [self.game resetScore];
    self.robotSays.text = @"  Choose mode and Start the game!";
    [self updateUI];
}
/* UISlider
- (IBAction)viewHistory:(UISlider *)sender
{
    if ([self.record count]) {      //防止没翻开牌就滑动slider
        self.robotSays.alpha = sender.value;           //alpha：透明度
        if (((int)sender.value) >= [self.record count]) {      //防止value和maxValue在数组越界(它们的值总比数组上限大1)
            self.robotSays.text = (NSString *)[self.record lastObject];
        }else {
            self.robotSays.text = (NSString *)[self.record objectAtIndex:(int)sender.value];
        }
    }
}
 */


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;               //if the card match, then this button will disable 即isMatched和enabled取反值
        self.scoreLable.text = [NSString stringWithFormat:@"Your Score: %d", self.game.score];
    }
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}

@end
