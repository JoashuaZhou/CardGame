//
//  PlayingCardView.m
//  CardGame
//
//  Created by Joshua Zhou on 14-2-23.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//


#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView
//这些pragma你单击上面的“@implementation PlayingCardView”就知道其好处了
#pragma mark - Properties

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay]; //如果有些改变了这些值，就要重画纸牌
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay]; //如果有些改变了这些值，就要重画纸牌
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay]; //如果有些改变了这些值，就要重画纸牌
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank]; //这里的写法类似于：a[i];
}

#pragma mark - Gesture Handling

- (void)tapGestureHandler
{
    self.faceUp = !self.faceUp;
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }  //定义这些的原因是，view的大小不同，view的圆角半径也不同
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];  //self.bounds就是我的坐标系
    
    [roundedRect addClip];      //保证以后画的所有东西都在这个圆角矩形里
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);    //C函数，把整个view全填白了，但是因为前面有addclip，所以只会填白圆角矩形部分，而不会整个view。也可以使用[path fill];
    //到了这一步出现了一个问题：view不会是圆角矩形，它的角还是尖的(因为是矩形里面画一个圆角矩形)，所以要弄个setup函数(在下面)。
    [[UIColor blackColor] setStroke];   //在圆角矩形边上描上黑边
    [roundedRect stroke];
    
    if (self.faceUp) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        if (faceImage) {    //有Image(J,Q,K)的牌就用Image，没有(除J,Q,K之外的牌)就画出来
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0-self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0-self.faceCardScaleFactor));//纸牌的图片不可能占据整个view，所以缩小一点放在中间
            //CGRrectInset返回一个同Center的缩小版/放大版矩形，而且它们的中心相同
            [faceImage drawInRect:imageRect];   //把图片画进矩形
        } else {            //没有Image的牌就画出来
            [self drawPips];
        }
        
        [self drawCorners];      //画出两对角的suit和rank
    } else {
        [[UIImage imageNamed:@"CardBack"] drawInRect:self.bounds];
    }
}

- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();   //首先获得当前context
    CGContextSaveGState(context);   //把还没upside-down的Ace of Clubs的context存起来
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);    //改变坐标系的原点到右下角
    CGContextRotateCTM(context, M_PI);      //旋转坐标系
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Corners

- (void)drawCorners     //思路：设置段落对齐和字体，然后加到AttributedString里面
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]]; //设置字体大小，pointSize是现在字体的大小
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{ NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle }];
    
    CGRect textBounds;  //创建一个矩形，把AttributedString画在这个矩形里，如Ace of Clubs
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);  //自己定义的一个offSet量
    textBounds.size = [cornerText size];    //这个矩形有多大？ 问问AttributedString的Size
    [cornerText drawInRect:textBounds];     //画一个AttributedString。像UIImage、AttributedString都有drawInRect的方法
    
    [self pushContextAndRotateUpsideDown];  //颠倒一下Ace of Clubs（移动原点、颠倒坐标系等）
    [cornerText drawInRect:textBounds];     //颠倒完毕后，再画一次AttributedString
    [self popContext];                      //恢复upside-down之前的context的存档
}

#pragma mark - Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips    //如果没有图片，即纸牌是除J,Q,K之外的牌，此时把纸牌画出来
{
    if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
    }
    if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
    }
    if ((self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
    }
}

#define PIP_FONT_SCALE_FACTOR 0.012

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
    if (upsideDown) [self pushContextAndRotateUpsideDown];
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont }];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(
                                    middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                    );
    [attributedSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) [self popContext];
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset
                                upsideDown:YES];
    }
}

@end
