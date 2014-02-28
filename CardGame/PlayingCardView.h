//
//  PlayingCardView.h
//  CardGame
//
//  Created by Joshua Zhou on 14-2-23.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"


//@protocol PlayingCardTapProtocol <NSObject>
//
//@required
//-(void)tapGestureHandler;
//
//@end


@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
//@property (nonatomic,weak) id <PlayingCardTapProtocol> delegate;
@end

