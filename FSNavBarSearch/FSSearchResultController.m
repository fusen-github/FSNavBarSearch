//
//  FSSearchResultController.m
//  FSNavBar11Demo
//
//  Created by 付森 on 2018/9/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSSearchResultController.h"


static NSString * const kTitleKey = @"title";

static NSString * const kDatasKey = @"datas";

@interface FSSearchResultController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSSearchResultController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:tableView];
}

- (void)viewWillLayoutSubviews
{
    CGFloat needY = 64;
    
    CGFloat needH = self.view.superview.bounds.size.height - needY;
    
    CGFloat needW = self.view.superview.bounds.size.width;
    
    self.view.frame = CGRectMake(0, needY, needW, needH);
    
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"Did: %@",NSStringFromCGRect(self.view.frame));
}


- (void)updateResultWithDatas:(NSArray *)datas
{
    self.dataArr = datas;
    
    self.tableView.hidden = !datas.count;
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArr objectAtIndex:section];
    
    NSArray *datas = [dict objectForKey:kDatasKey];
    
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"search_result_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.textColor = [UIColor redColor];
        
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    NSDictionary *dict = [self.dataArr objectAtIndex:indexPath.section];
    
    NSArray *datas = [dict objectForKey:kDatasKey];
    
    cell.textLabel.text = [datas objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArr objectAtIndex:section];
    
    NSString *title = [dict objectForKey:kTitleKey];
    
    return title;
}

- (void)dealloc
{
    NSLog(@"FSSearchResultController dealloc");
}

@end
