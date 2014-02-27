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
- (void)setChosen:(BOOL)chosen
{
    _chosen = chosen;
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
    UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundRect addClip];
    [[UIColor whiteColor] setFill];
    [roundRect fill];
    [[UIColor blackColor] setStroke];
    [roundRect stroke];
    
    if (self.chosen) {
        [[UIColor orangeColor] setStroke];
        roundRect.lineWidth = 5.0;
        [roundRect stroke];
    }
    
    [self drawSymbol];
}

- (void)drawSymbol
{
    if ([self.symbol isEqualToString:@"diamond"]) {
        [self drawDiamond];
    }
    if ([self.symbol isEqualToString:@"squiggle"]) {
       [self drawSquiggle];
    }
    if ([self.symbol isEqualToString:@"oval"]) {
        [self drawOval];
    }
}

- (void)drawDiamond  //Magic Number here
{
    UIBezierPath *diamond = [[UIBezierPath alloc]init];
    [[[self fillColor] colorWithAlphaComponent:[self drawShading]] setFill];
    [[self fillColor] setStroke];
    if (self.number == 1 || self.number == 3) { //无论number是1还是3，都要画中间那个，所以统一在一起
        [diamond moveToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.4)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height / 2)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.6)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height / 2)];
        [diamond closePath];
        [diamond fill];
        [diamond stroke];
    }
    if (self.number == 2) {
        UIBezierPath *diamond2 = [[UIBezierPath alloc] init];
        [diamond moveToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.25)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.35)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.45)];
        [diamond addLineToPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.35)];
        [diamond closePath];
        [diamond fill];
        [diamond stroke];
      
        [diamond2 moveToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.55)]; //self.center是父view的中心，而不是此类的中心
        [diamond2 addLineToPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.65)];
        [diamond2 addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.75)];
        [diamond2 addLineToPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.65)];
        [diamond2 closePath];
        [diamond2 fill];
        [diamond2 stroke];
    }
    if (self.number == 3) {
        UIBezierPath *diamond2 = [[UIBezierPath alloc] init];
        UIBezierPath *diamond3 = [[UIBezierPath alloc] init];
        [diamond2 moveToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.1)];
        [diamond2 addLineToPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.2)];
        [diamond2 addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.3)];
        [diamond2 addLineToPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.2)];
        [diamond2 closePath];
        [diamond2 fill];
        [diamond2 stroke];
        
        [diamond3 moveToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.7)]; //self.center是父view的中心，而不是此类的中心
        [diamond3 addLineToPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.8)];
        [diamond3 addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.9)];
        [diamond3 addLineToPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.8)];
        [diamond3 closePath];
        [diamond3 fill];
        [diamond3 stroke];
    }
}

- (void)drawSquiggle
{
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    [[[self fillColor] colorWithAlphaComponent:[self drawShading]] setFill];
    [[self fillColor] setStroke];
    if (self.number == 1 || self.number == 3) {
        [squiggle moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.6)];
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.55, self.bounds.size.height * 0.45) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.35)]; //QuadCurve:1个控制点的曲线 Curve:2个控制点的曲线
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.4) controlPoint:CGPointMake(self.bounds.size.width * 0.7, self.bounds.size.height * 0.5)];
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.45, self.bounds.size.height * 0.55) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.65)];
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.6) controlPoint:CGPointMake(self.bounds.size.width * 0.3, self.bounds.size.height * 0.5)];
        [squiggle fill];
        [squiggle stroke];
    }
    if (self.number == 2) {
        UIBezierPath *squiggle2 = [[UIBezierPath alloc] init];
        [squiggle moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.45)];
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.55, self.bounds.size.height * 0.3) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.2)]; //QuadCurve:1个控制点的曲线 Curve:2个控制点的曲线
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.25) controlPoint:CGPointMake(self.bounds.size.width * 0.7, self.bounds.size.height * 0.35)];
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.45, self.bounds.size.height * 0.4) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.5)];
        [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.45) controlPoint:CGPointMake(self.bounds.size.width * 0.3, self.bounds.size.height * 0.35)];
        [squiggle fill];
        [squiggle stroke];
        
        [squiggle2 moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.75)];
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.55, self.bounds.size.height * 0.6) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.5)]; //QuadCurve:1个控制点的曲线 Curve:2个控制点的曲线
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.55) controlPoint:CGPointMake(self.bounds.size.width * 0.7, self.bounds.size.height * 0.65)];
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.45, self.bounds.size.height * 0.7) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.8)];
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.75) controlPoint:CGPointMake(self.bounds.size.width * 0.3, self.bounds.size.height * 0.65)];
        [squiggle2 fill];
        [squiggle2 stroke];
    }
    if (self.number == 3) {
        UIBezierPath *squiggle2 = [[UIBezierPath alloc] init];
        UIBezierPath *squiggle3 = [[UIBezierPath alloc] init];
        
        [squiggle2 moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.3)];
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.55, self.bounds.size.height * 0.15) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.05)]; //QuadCurve:1个控制点的曲线 Curve:2个控制点的曲线
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.1) controlPoint:CGPointMake(self.bounds.size.width * 0.7, self.bounds.size.height * 0.2)];
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.45, self.bounds.size.height * 0.25) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.35)];
        [squiggle2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.3) controlPoint:CGPointMake(self.bounds.size.width * 0.3, self.bounds.size.height * 0.2)];
        [squiggle2 fill];
        [squiggle2 stroke];
        
        [squiggle3 moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.9)];
        [squiggle3 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.55, self.bounds.size.height * 0.75) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.65)]; //QuadCurve:1个控制点的曲线 Curve:2个控制点的曲线
        [squiggle3 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.7) controlPoint:CGPointMake(self.bounds.size.width * 0.7, self.bounds.size.height * 0.8)];
        [squiggle3 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.45, self.bounds.size.height * 0.85) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.95)];
        [squiggle3 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.9) controlPoint:CGPointMake(self.bounds.size.width * 0.3, self.bounds.size.height * 0.8)];
        [squiggle3 fill];
        [squiggle3 stroke];
    }
}

- (void)drawOval
{
    UIBezierPath *oval = [[UIBezierPath alloc] init];
    [[[self fillColor] colorWithAlphaComponent:[self drawShading]] setFill];
    [[self fillColor] setStroke];
    if (self.number == 1 || self.number == 3) {
        [oval moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.4)];
        [oval addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.6) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height / 2)];
        [oval addLineToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.6)];
        [oval addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.4) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height / 2)];
        [oval closePath];
        [oval fill];
        [oval stroke];
    }
    if (self.number == 2) {
        UIBezierPath *oval2 = [[UIBezierPath alloc] init];
        [oval moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.25)];
        [oval addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.45) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.35)];
        [oval addLineToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.45)];
        [oval addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.25) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.35)];
        [oval closePath];
        [oval fill];
        [oval stroke];
        
        [oval2 moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.55)];
        [oval2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.75) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.65)];
        [oval2 addLineToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.75)];
        [oval2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.55) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.65)];
        [oval2 closePath];
        [oval2 fill];
        [oval2 stroke];
    }
    if (self.number == 3) {
        UIBezierPath *oval2 = [[UIBezierPath alloc] init];
        UIBezierPath *oval3 = [[UIBezierPath alloc] init];
        [oval2 moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.1)];
        [oval2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.3) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.2)];
        [oval2 addLineToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.3)];
        [oval2 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.1) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.2)];
        [oval2 closePath];
        [oval2 fill];
        [oval2 stroke];
        
        [oval3 moveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.7)];
        [oval3 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.2, self.bounds.size.height * 0.9) controlPoint:CGPointMake(self.bounds.size.width * 0.1, self.bounds.size.height * 0.8)];
        [oval3 addLineToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.9)];
        [oval3 addQuadCurveToPoint:CGPointMake(self.bounds.size.width * 0.8, self.bounds.size.height * 0.7) controlPoint:CGPointMake(self.bounds.size.width * 0.9, self.bounds.size.height * 0.8)];
        [oval3 closePath];
        [oval3 fill];
        [oval3 stroke];
    }
}

- (UIColor *)fillColor
{
    if ([self.color isEqualToString:@"red"]) {
        return [UIColor redColor];
    }
    if ([self.color isEqualToString:@"green"]) {
        return [UIColor greenColor];
    }
    return [UIColor purpleColor];
}

- (CGFloat)drawShading
{
    if ([self.shading isEqualToString:@"open"]) {
        return 0;
    }
    if ([self.shading isEqualToString:@"striped"]) {
        return 0.1;
    }
    return 1.0;
}

#pragma mark - Gesture Handler
- (void)tapGestureHandler
{
    self.chosen = !self.chosen;
}

@end
