//
//  SetCardView.h
//  CardGame
//
//  Created by Joshua Zhou on 14-2-22.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSInteger number;
@property (nonatomic) BOOL chosen;

- (void)tapGestureHandler;

@end
