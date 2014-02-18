//
//  GameHistoryViewController.m
//  CardGame
//
//  Created by Joshua Zhou on 14-2-10.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()

@end

@implementation GameHistoryViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    self.cardMatchingHistory.text = self.cardMatchingText;
    self.setCardHistory.text = self.setCardText;
}

@end
