//
//  PlayingCardView.h
//  CardGame
//
//  Created by Joshua Zhou on 14-2-23.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)tapGestureHandler;

@end
