//
//  SearchResultViewController.m
//  SearchBar
//
//  Created by 刘浩浩 on 16/8/10.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *view;
}
@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条搜索数据",(long)indexPath.row];
    return cell;
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSLog(@"%@", searchText);
    
    
    if (searchController.searchBar.text.length >15) {
        searchController.searchBar.text = [searchText substringToIndex:15];
    }
}

#pragma mark - SearchInputtingDelegate
- (void)searchMyInput:(NSString *)inputStr
{
    NSLog(@"To Search My Inputthing");
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _tableView.alpha = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    view.backgroundColor = [UIColor orangeColor];
    view.alpha = 0;
    [self.view addSubview:view];
    [self creatBackBtn];

    
    [UIView animateWithDuration:1 animations:^{
        self.searchVC.searchBar.hidden = YES;
        _tableView.alpha = 1;
        view.alpha = 1;
        
    }];
    
   

}

- (void)creatBackBtn
{
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backbtn.frame = CGRectMake(0, 20, 60, 44);
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbtn];


}

- (void)backAction
{
    self.searchVC.searchBar.hidden = NO;
    [_tableView removeFromSuperview];
    [view removeFromSuperview];
    self.backBlock();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
