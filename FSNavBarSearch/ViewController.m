//
//  ViewController.m
//  FSNavBar11Demo
//
//  Created by 付森 on 2018/9/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "ViewController.h"
#import "FSDetailController.h"
#import "FSSearchResultController.h"

static NSString * const kTitleKey = @"title";

static NSString * const kDatasKey = @"datas";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"列表";
    
    // API_AVAILABLE(ios(11.0))
    
    if (@available(iOS 11.0, *))
    {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        NSMutableDictionary *largeTitleTextAttributes = [NSMutableDictionary dictionary];
        
        [largeTitleTextAttributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        
        //    [attributeDict setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes;
        
        NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];
        
        [titleTextAttributes setObject:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = titleTextAttributes;
        
        FSSearchResultController *rstController = [[FSSearchResultController alloc] init];
        
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:rstController];
        
        searchController.searchResultsUpdater = self;
        
        searchController.searchBar.placeholder = @"搜索点东西...";
        
        self.navigationItem.searchController = searchController;
        
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
        
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
    
    self.dataArray = [self prepareDatas];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
}

- (NSArray *)getOriginArray
{
    NSString *str = @"而顺丰与搬运帮的强强联合可以快速抢占同城货运市场从而加速向综合物流服务商转型这也再次验证了王卫的金句顺丰的竞争对手不是同行而是跨界企业隆山小学的大门口有电动伸缩门有多名保安按照今年月日刚实施的出入管理制度家长等外来人员需经过严格的身份登记并获得受访者同意才能进校云米正式登陆纳斯达克向家庭物联网新征程又迈进了一大步其股票代码为云米表示未来的家应该是互联网的家云米开创全屋互联网家电用科技的手段升级家居体验重新定义家的未来云米创始人陈小平发表主题演讲感谢所有用户的信任与支持感谢时代相信未来在新的起点上我们将不忘初心继续奋进特朗普在演讲中批评联合国人权理事会国际刑事法院等多边机构以及伊朗核问题全面协议等多边协议称绝不会将美国的主权让渡给一个未经选举不负责任的全球官僚机构他还称美国反对全球主义理念他还在演讲中批评伊朗和委内瑞拉等国政府在巴以问题上他说美国奉行“有原则的现实主义政策";
    
    int step = 2;
    
    NSMutableArray *originArr = [NSMutableArray array];
    
    for (int i = 0; i < str.length - 2;)
    {
        NSString *sub = [str substringWithRange:NSMakeRange(i, 2)];
        
        [originArr addObject:sub];
        
        i = i + step;
    }
    
    return originArr;
}

- (NSArray *)getOriginArray22
{
    NSString *str = @"I was a shy girl and I never dared to make performance in the public, but everything will have the exception. Last week, our English teacher gave us a job. All students needed to make performance in group. I was chosen to be the protagonist in my team. At first, I told them that I couldn’t make it, but they believed that I was the suitable person. So I practised hard and tried to get over my fear. It was my stage. I stood in front of my classmates. With my teammates, I finished my job. I felt so cool and dared to face so many people. My parents paid special attention to let me master the basic skills when I was very small. They believed that these skills were easy to learn by a kid and they were right. I learned thing very quickly at that time. When my father gave me a bike, I felt so excited and was so eager to learn. At first, he would hold the bike for me, tell me to look forward and never look back. But I just couldn't do it, I needed to check if he was there. My father started to let go and I gain more confidence. At last, though I fell down many times, I learned to ride bike.I still remembered the horrible experience for my first interview. Early in the morning, I got a called that I was given a chance to the job interview. I felt so excited. When I came to the company, I found there were other six young people competed with me, then I started to feel nervous. The employers asked us to sit in the round table and introduced ourselves one by one. When it was my turn, I lowed down my head and spoke in low voice. Then the employers continued to let us give speeches in the stage. I lose confidence and made the horrible performance.";
    
    NSArray *array = [str componentsSeparatedByString:@" "];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSString *word in array)
    {
        NSString *tmp = word;
        
        unichar last = [word characterAtIndex:word.length - 1];
        
        /// 不是字母
        if (isalpha(last) == 0)
        {
            tmp = [word substringToIndex:word.length - 1];
        }
        
        [tmpArray addObject:tmp];
    }
    
    return tmpArray;
}

- (NSArray *)prepareDatas
{
    NSArray *originArr = [self getOriginArray22];
    
    NSMutableDictionary *groupedDict = [NSMutableDictionary dictionary];
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    for (NSString *obj in originArr)
    {
        NSInteger sectionIndex = [collation sectionForObject:obj collationStringSelector:@selector(description)];
        
        NSString *title = [collation.sectionIndexTitles objectAtIndex:sectionIndex];
        
        NSMutableArray *sectionArr = [groupedDict objectForKey:title];
        
        if (![sectionArr isKindOfClass:[NSMutableArray class]])
        {
            sectionArr = [NSMutableArray array];
            
            [groupedDict setObject:sectionArr forKey:title];
        }
        
        [sectionArr addObject:obj];
    }
    
    NSArray *sortedKeys = [groupedDict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray *groupedArray = [NSMutableArray array];
    
    for (NSString *key in sortedKeys)
    {
        NSArray *datas = [groupedDict objectForKey:key];
        
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
        
        [tmpDict setObject:key forKey:kTitleKey];
        
        [tmpDict setObject:datas forKey:kDatasKey];
        
        [groupedArray addObject:tmpDict];
    }
    
    return groupedArray;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.hidesSearchBarWhenScrolling = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    
    NSArray *datas = [dict objectForKey:kDatasKey];
    
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    
    NSArray *datas = [dict objectForKey:kDatasKey];
    
    NSString *title = [datas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = title;
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    
    NSString *title = [dict objectForKey:kTitleKey];
    
    return title;
}

- (NSArray <NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in self.dataArray)
    {
        NSString *title = [dict objectForKey:kTitleKey];
        
        [array addObject:title];
    }
    
    return array;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSDetailController *detail = [[FSDetailController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *input = searchController.searchBar.text;
    
    NSMutableArray *searchResult = [NSMutableArray array];
    
    for (NSDictionary *dict in self.dataArray)
    {
        NSString *title = [dict objectForKey:kTitleKey];
        
        NSArray *datas = [dict objectForKey:kDatasKey];
        
        NSMutableArray *searchedArr = [NSMutableArray array];
        
        for (NSString *dataObj in datas)
        {
            NSRange range = [dataObj rangeOfString:input options:NSWidthInsensitiveSearch|NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound && range.length > 0)
            {
                [searchedArr addObject:dataObj];
            }
        }
        
        if (searchedArr.count)
        {
            NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
            
            [newDict setObject:title forKey:kTitleKey];

            [newDict setObject:searchedArr forKey:kDatasKey];
            
            [searchResult addObject:newDict];
        }
    }
    
    UIViewController *searchResultController = searchController.searchResultsController;
    
    if ([searchResultController isKindOfClass:[FSSearchResultController class]])
    {
        [(FSSearchResultController *)searchResultController updateResultWithDatas:searchResult];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
