//
//  SearchResultViewController.h
//  SearchBar
//
//  Created by 刘浩浩 on 16/8/10.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface SearchResultViewController : UIViewController <UISearchResultsUpdating,SearchInputtingDelegate>

@property(nonatomic,copy)void(^backBlock)(void);
@property(nonatomic,strong)UISearchController *searchVC;

@end
