//
//  ViewController.m
//  SearchBar
//
//  Created by 刘浩浩 on 16/8/10.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "SearchResultViewController.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    UIBarButtonItem *_navRightButton;
}
@property (nonatomic, strong) SearchResultViewController *searchVC;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setHidesBottomBarWhenPushed:NO];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self initMySearchBar];
}

/**
 *  初始化子视图
 */
- (void) initMySearchBar
{
    // 搜索页
    _searchVC = [[SearchResultViewController alloc] init];
    //遵守代理，用于后面传值
    self.delegate = _searchVC;
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchVC];
    //设置后可以看到实时输入内容,可以在结果页的代理里面设置输入长度
    [_searchController setSearchResultsUpdater: _searchVC];
    [_searchController.searchBar setPlaceholder:@"搜索"];
    [_searchController.searchBar setBarTintColor:[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f]];
    //设置搜索logo
    [_searchController.searchBar setImage:[UIImage imageNamed:@"last.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_searchController.searchBar sizeToFit];
    [_searchController.searchBar setDelegate:self];
    [_searchController.searchBar.layer setBorderWidth:0.5f];
    [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
    [_tableView setTableHeaderView:_searchController.searchBar];
    
    _searchVC.searchVC = _searchController;
    __weak UISearchController *searchVC = _searchController;

    _searchVC.backBlock = ^(){
        [searchVC dismissViewControllerAnimated:YES completion:nil];
        searchVC.searchBar.text = @"";
    };
}

- (void) navRightButtonDown
{
    NSLog(@"---------------");
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
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}


#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //这里也可以不做取消操作，而是该用确认搜索的操作，使用.h中的代理把值传到搜索结果那里进行网络请求
    [self.tabBarController.tabBar setHidden:NO];
    NSLog(@"---------------Cancel");

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"---------------%@",searchBar.text);
    
    if ([self.delegate respondsToSelector:@selector(searchMyInput:)]) {
        [self.delegate searchMyInput:searchBar.text];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
