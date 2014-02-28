//
//  CardView.h
//  CardGame
//
//  Created by Joshua Zhou on 14-2-26.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL matched;
@property (nonatomic) CGFloat faceCardScaleFactor;
- (void)tapGestureHandler;

@end
