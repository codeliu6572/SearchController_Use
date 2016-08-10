//
//  ViewController.h
//  SearchBar
//
//  Created by 刘浩浩 on 16/8/10.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchInputtingDelegate <NSObject>

- (void)searchMyInput:(NSString *)inputStr;

@end

@interface ViewController : UIViewController

@property(nonatomic,weak)id<SearchInputtingDelegate>delegate;

@end

