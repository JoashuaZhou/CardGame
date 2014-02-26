//
//  SetCardView.m
//  CardGame
//
//  Created by Joshua Zhou on 14-2-22.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView


#pragma mark - setters

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}
- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}
- (void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}
- (void)setNumber:(NSInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}


#pragma mark - drawing
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }  //定义这些的原因是，view的大小不同，view的圆角半径也不同
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *cardShade = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [cardShade addClip];
    [[UIColor whiteColor] setFill];
    [cardShade fill];
    if (self.chosen) {
        [[UIColor orangeColor] setStroke];
        cardShade.lineWidth = 3.0;
        [cardShade stroke];
    }
    if ([self.symbol isEqualToString:@"Diamond"]) {
        [self drawDiamond:self.number];
    }
    if ([self.symbol isEqualToString:@"Squiggle"]) {
        [self drawDiamond:self.number];
    }
    if ([self.symbol isEqualToString:@"Oval"]) {
        [self drawDiamond:self.number];
    }
}


- (void)drawDiamond: (NSInteger)number  //Magic Number here
{
    UIBezierPath *diamond = [[UIBezierPath alloc]init];
    if (number == 1) {
        [diamond moveToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-16)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width/2+24, self.bounds.size.height/2)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2+16)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width/2-24, self.bounds.size.height/2)];
        [diamond closePath];
        [[UIColor purpleColor] setFill];
        [diamond fill];
    }/*
    if (number == 2) {
        <#statements#>
    }
    if (number == 3) {
        <#statements#>
    }
      */
}

- (void)drawSquiggle
{

}

- (void)drawOval
{
    CGRect frame = CGRectInset(self.bounds, self.bounds.size.width * 0.1, self.bounds.size.height * 0.4);
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:frame];
    [[UIColor purpleColor] setFill];
    [oval fill];
}

#pragma mark - Gesture Handler
- (void)tapGestureHandler
{
    self.chosen = !self.chosen;
}

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

@end
