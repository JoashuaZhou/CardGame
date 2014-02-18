//
//  GameHistoryViewController.h
//  CardGame
//
//  Created by Joshua Zhou on 14-2-10.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *cardMatchingHistory;
@property (weak, nonatomic) IBOutlet UITextView *setCardHistory;
@property (strong, nonatomic) NSString *cardMatchingText;
@property (strong, nonatomic) NSString *setCardText;
@end
