//
//  CardView.m
//  CardGame
//
//  Created by Joshua Zhou on 14-2-26.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "CardView.h"

@implementation CardView

//这些pragma你单击上面的“@implementation PlayingCardView”就知道其好处了
#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;
- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];     //如果有些改变了这些值，就要重画纸牌。要知道drawRect函数是不可以被调用的，使用[setNeedsDisplay]
}

- (void)tapGestureHandler
{
}

#pragma mark - Initialization
- (void)setup
{
    self.backgroundColor = nil; //把view的背景色设为空
    self.opaque = NO;           //把view设成透明(默认不透明)，这样就只是留下画的部分，其他没画的部分都变透明了
    self.contentMode = UIViewContentModeRedraw; //一个选项，即如果self.bounds改变了，就调用setNeedsDisplay重画(slide P27)
}

- (void)awakeFromNib                //从storyboard创建的view启动时调用awakeFromNib，而通过alloc+initWithFrame创建的view就调用initWithFrame
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame           //designated initializer
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
