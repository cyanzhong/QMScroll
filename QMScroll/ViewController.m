//
//  ViewController.m
//  QMScroll
//
//  Created by cyan on 16/4/17.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "ViewController.h"

static const CGFloat kTabBarHeight      = 44.0;
static const CGFloat kStatusBarHeight   = 20.0;
static const CGFloat kTableContentInset = 200;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UIView *tabBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = self.view.bounds.size;
    
    CGSize scrollSize = CGSizeMake(size.width, size.height - kTabBarHeight - kStatusBarHeight);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTabBarHeight + kStatusBarHeight, size.width, size.height - kTabBarHeight - kStatusBarHeight)];
    self.scrollView.contentSize = CGSizeMake(scrollSize.width*2, scrollSize.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(kTableContentInset, 0, 0, 0);
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scrollSize.width, scrollSize.height)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.contentInset = insets;
    self.tableView1.scrollIndicatorInsets = insets;
    self.tableView1.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.tableView1];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(scrollSize.width, 0, scrollSize.width, scrollSize.height)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.contentInset = insets;
    self.tableView2.scrollIndicatorInsets = insets;
    self.tableView2.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.tableView2];
    
    self.tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kTableContentInset, size.width, kTabBarHeight)];
    self.tabBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tabBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    cell.textLabel.textColor = tableView == self.tableView1 ? [UIColor redColor] : [UIColor blueColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        
    } else {
        
        CGFloat contentOffsetY = scrollView.contentOffset.y;

        CGPoint tabBarCenter = self.tabBar.center;
        tabBarCenter.y = fabs(MIN(0, contentOffsetY)) + kTabBarHeight;
        self.tabBar.center = tabBarCenter;
        
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UITableView class]]) {
                UITableView *tableView = (UITableView *)view;
                CGPoint contentOffset = tableView.contentOffset;
                contentOffset.y = contentOffsetY;
                tableView.contentOffset = contentOffset;
            }
        }
    }
}

@end
