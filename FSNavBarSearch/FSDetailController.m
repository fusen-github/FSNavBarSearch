//
//  FSDetailController.m
//  FSNavBar11Demo
//
//  Created by 付森 on 2018/9/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSDetailController.h"

@interface FSDetailController ()

@end

@implementation FSDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

@end
