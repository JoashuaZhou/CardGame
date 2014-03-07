//
//  CardGameViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-1-16.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//
//  Blocks就是函数指针

#import "CardGameViewController.h"


@interface CardGameViewController ()

//@property (strong, nonatomic) CardMatchingGame *game;   //自己定义的就用strong，IBOutlet就用weak
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *robotSays;
@property (strong, nonatomic) NSMutableArray *attachArray;
@property (strong, nonatomic) NSMutableArray *cardsPreviousPosition;
//@property (nonatomic) float originDis;
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation CardGameViewController

#pragma mark - lazy initialization
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startCardsNumber usingDeck:[self createDeck]];
    }
    return _game;
}

- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];    //[Grid new] = [[Grid alloc] init]，但是你用designated initializer就不要用new了
        _grid.minimumNumberOfCells = self.startCardsNumber;
        _grid.cellAspectRatio = self.cardSize.width / self.cardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}

- (NSMutableArray *)gamecards
{
    if (!_gamecards) {
        _gamecards = [[NSMutableArray alloc] initWithCapacity:self.startCardsNumber];
    }
    return _gamecards;
}

- (NSMutableArray *)attachArray
{
    if (!_attachArray) {
        _attachArray = [[NSMutableArray alloc] init];
    }
    return _attachArray;
}

- (NSMutableArray *)cardsPreviousPosition
{
    if (!_cardsPreviousPosition) {
        _cardsPreviousPosition = [[NSMutableArray alloc] init];
    }
    return _cardsPreviousPosition;
}

- (Deck *)createDeck
{
    NSLog(@"%@",@"nil method!!");
    return nil;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gridView];
    }
    return _animator;
}

//- (UIAttachmentBehavior *)attachCards     //因为AttachmentBehavior没有addItem的方法，所以只能用到的时候initWithItem，故不用lazy initialization
//{
//    if (!_attachCards) {
//        _attachCards = [[UIAttachmentBehavior alloc] init];
//    }
//    return _attachCards;
//}

- (void)updateUI
{
    for (CardView *cardView in self.gamecards) {
        NSInteger index = [self.gamecards indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:index];
        if (cardView.chosen != card.isChosen) {
            [CardView transitionWithView:cardView duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ cardView.chosen = card.isChosen; } completion:^(BOOL fin){}];      //flip cards
        }
        cardView.matched = card.isMatched;
        if (cardView.matched) {
//          [self.gamecards removeObjectAtIndex:index]; 为什么不行？因为remove之后，cardView后面的元素序号全变了
            [CardView transitionWithView:cardView duration:1.8 options:UIViewAnimationOptionBeginFromCurrentState animations:^{ cardView.alpha = 0; } completion:^(BOOL fin){ if(fin)[cardView removeFromSuperview];}]; //为什么不用animation而用trasitionWithView? 因为要保证alpha = 0之后才被removeFromSuperView，不然用animation的话动画都还没演示完就已经被removeFromSuperView了
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.gamecards makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.grid.size = self.gridView.frame.size;      //设备旋转后，gridView的size改变了，所以要重新设置grid
    __block NSInteger index = 0;        //如果不加__block，index就是只读的
    [CardView animateWithDuration:1.0       //很简单的一个animation函数，你要把那个步骤动画化，就把它加入animations里面就可以了，不用考虑其他的
                       animations:^{
                            for (int row = 0; row < self.grid.rowCount; row++) {
                                for (int column = 0; column < self.grid.columnCount; column++) {
                                    if (index < self.startCardsNumber) {        //设备旋转时行列会改变，纸牌不一定能排成矩形，但grid是矩形，所以i可能会产生数组越界
                                        CardView *cardView = (CardView *)self.gamecards[index];
                                        cardView.frame = [self.grid frameOfCellAtRow:row inColumn:column]; //frame可以直接赋值
                                        [self.gridView addSubview:cardView];
                                        index++;
                                    }
                                }
                            }
                       }
     ];
}

- (void)initialUI
{
    CGRect frame;   //CGRect不用指针*
    Card *card;
    NSInteger i = 0;
    for (int row = 0; row < self.grid.rowCount/*[self.game numbersOfDealCards]*/; row++) {
        for (int column = 0; column < self.grid.columnCount; column++) {
            if (i < self.startCardsNumber) {            //设备旋转时行列会改变，纸牌不一定能排成矩形，但grid是矩形，所以i可能会产生数组越界
                card = [self.game cardAtIndex:i];
                frame = [self.grid frameOfCellAtRow:row inColumn:column];
                CardView *cardView = [self createView:card withFrame:frame];
                [self.gridView addSubview:cardView];    //如果没有这句话，纸牌将不能显示在屏幕上
                i++;
            }
        }
    }
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tapRecognizer
{
    CardView *cardView = (CardView *)tapRecognizer.view;
    int index = [self.gamecards indexOfObject:cardView];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (IBAction)pinchCards:(UIPinchGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self makePile];
        [self rememberCardsPreviousPosition];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        [CardView animateWithDuration:2.0
                         animations:^{
                             for (UIAttachmentBehavior *attach in self.attachArray) {
                                 attach.length = 0;
                             }
                                    }];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        for (UIAttachmentBehavior *attach in self.attachArray) {
            [self.animator removeBehavior:attach];
        }
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCards:)];
        [self.gamecards.lastObject addGestureRecognizer:self.pan];
        
        [[[self.gamecards.lastObject gestureRecognizers] lastObject] removeTarget:self action:@selector(tapGestureHandler:)];
        
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToBackHome:)];
        [self.gamecards.lastObject addGestureRecognizer:self.tap];

        [self.attachArray removeAllObjects];
    }
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        self.originDis = [self distOfPoint:[sender locationOfTouch:0 inView:self.view] andP2:[sender locationOfTouch:1 inView:self.view]];
//    }
//    
//    
//    CGFloat dis = [self distOfPoint:[sender locationOfTouch:0 inView:self.view] andP2:[sender locationOfTouch:1 inView:self.view]];
//    CGFloat ratio = dis/self.originDis;
//    
////    if (ratio>1.0) {
////        self.originDis = dis;
////        ratio = 1.0;
////    }
//    [self moveAllCardsWithRatio:ratio];
//    NSLog(@"%f",ratio);
//    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateFailed || sender.state == UIGestureRecognizerStateCancelled) {
//        [UIView animateWithDuration:0.5 animations:^{
//            [self moveAllCardsWithRatio:1.0];
//        }];
//    }
}

//
//-(CGFloat)distOfPoint:(CGPoint)p1 andP2:(CGPoint)p2{
//    return sqrtf((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
//}
//-(void)moveAllCardsWithRatio:(float)ratio{
//    for(int i = 0; i<self.gamecards.count; i++){
//        CardView* cardV =(CardView*)self.gamecards[i];
//        CGPoint center = [self.grid centerOfCellAtRow:i / self.grid.columnCount inColumn:i % self.grid.columnCount];
//        cardV.center = CGPointMake(self.gridView.center.x + (center.x - self.gridView.center.x)*ratio,
//                                   self.gridView.center.y + (center.y - self.gridView.center.y)*ratio);
//    }
//}

- (IBAction)panCards:(UIPanGestureRecognizer *)sender
{
    CGPoint gesturePoint = [sender locationInView:self.gridView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self stackDrag:gesturePoint];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        for (UIAttachmentBehavior *attach in self.attachArray) {
            attach.anchorPoint = gesturePoint;
        }
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        for (UIAttachmentBehavior *attach in self.attachArray) {
            [self.animator removeBehavior:attach];
        }
//        [[[self.gamecards.lastObject gestureRecognizers] lastObject] removeTarget:self action:@selector(tapToBackHome:)];
//        [[[self.gamecards.lastObject gestureRecognizers] lastObject] addTarget:self action:@selector(tapToBackHome:)];
    }
}

- (IBAction)tapToBackHome:(UITapGestureRecognizer *)sender
{
    __block int i = 0;
    [CardView animateWithDuration:1.0
                       animations:^{
                           for (CardView *cardView in self.gamecards) {
                               cardView.frame = [self.cardsPreviousPosition[i++] CGRectValue];
                           }
                       }];
    [[[self.gamecards.lastObject gestureRecognizers] lastObject] removeTarget:self action:@selector(tapToBackHome:)];
    [[[self.gamecards.lastObject gestureRecognizers] lastObject] addTarget:self action:@selector(tapGestureHandler:)];
}

- (void)rememberCardsPreviousPosition
{
    for (CardView *cardView in self.gamecards) {
        [self.cardsPreviousPosition addObject:[NSValue valueWithCGRect:cardView.frame]];
    }
}

- (void)makePile
{
    for (CardView *cardView in self.gamecards) {
        UIAttachmentBehavior *attachCards = [[UIAttachmentBehavior alloc] initWithItem:cardView attachedToAnchor:[self.grid centerOfCellAtRow:1 inColumn:2]];
        [self.attachArray addObject:attachCards];
        [self.animator addBehavior:attachCards];
    }
}

- (void)stackDrag:(CGPoint)gesturePoint
{
    for (CardView *cardView in self.gamecards) {
        UIAttachmentBehavior *attachStack = [[UIAttachmentBehavior alloc] initWithItem:cardView attachedToAnchor:gesturePoint];
        attachStack.length = 0;
        [self.attachArray addObject:attachStack];
        [self.animator addBehavior:attachStack];
    }
}

- (CardView *)createView:(Card *)card withFrame:(CGRect)frame
{
    return nil;
}

@end
