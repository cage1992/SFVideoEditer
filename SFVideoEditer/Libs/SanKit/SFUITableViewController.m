//
//  SLibUITableViewController.m
//  SanFramework
//
//  Created by shelley on 14-1-12.
//  Copyright (c) 2014 Sanfriend Co, Ltd. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "SFUITableViewController.h"
#import "SFMacro.h"

@interface SFUITableViewController ()

@end

@implementation SFUITableViewController

@synthesize dataList = _dataList;
@synthesize viewList = _viewList;
@synthesize tableView = _tableView;
@synthesize minCellHeight = _minCellHeight;
@synthesize tableViewPager = _tableViewPager;
@synthesize tableViewLastCount = _tableViewLastCount;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.dataList = [[NSMutableArray alloc] init];
    self.viewList = [[NSMutableArray alloc] init];
}

#pragma mark - 添加列表视图
- (void)addTableViewWithFrame:(CGRect)frame
{
    int tag = 90000000 + frame.origin.x + frame.origin.y + frame.size.width + frame.size.height;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.tag = tag;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // fix table background color
    //UIView *backgroundView = [[UIView alloc] initWithFrame:tableView.bounds];
    //backgroundView.backgroundColor = [UIColor clearColor];
    //tableView.backgroundView = backgroundView;
    tableView.backgroundColor = [UIColor clearColor];

    
    _tableView = tableView;
    
    if (![self.view viewWithTag:tag]) {
    	[self.view addSubview:_tableView];
    }
}


#pragma mark - 列表 Datasource Delegate
// 列表板块数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

#pragma mark 每个板块单元格行数
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%@: datalist count: %d", [[self class] description], self.dataList.count);
    //NSLog(@"pager: %d, loaded: %d", self.tableViewPager, self.tableViewLastCount);

    return self.viewList.count;
}

#pragma mark 每个单元格内容
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistCell"];
    //NSLog(@"count: %d, i: %d", self.viewList.count, indexPath.row);
    [cell.contentView addSubview:[self.viewList objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark 显示最后一个单元格时，如果需要，加载更多数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 == self.viewList.count) {
        [self loadDataDelayed];
    }
}


#pragma mark - 加载数据 (具体实现在各自实现类中)
-(void)loadDataDelayed
{
    if(self.dataList.count < 10) { // 太少，不用再加载
        return;
	}
    
    if (_tableViewLastCount < _tableViewPager) {
        return;
    }
    
    if ([self loadDataFromOffset:self.viewList.count withLimit:_tableViewPager]) {
    	[self.tableView reloadData];
    }
}

- (BOOL) loadDataFromOffset:(NSInteger)offset withLimit:(NSInteger)limit
{
    // 在各个子类中实现。 缺省不加载数据，不刷新表视图
    
    return NO;
}

// 每个单元格高度的计算实现在每个具体类中...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.f;
    if (self.viewList.count > 0) {
        UIView *cellView = [self.viewList objectAtIndex:indexPath.row];
        height = cellView.frame.size.height;
    }
    return height;
}




- (void) dealloc
{
    if (DEBUG_ON) NSLog(@"%@ Releasing dataList, viewList", [[self class] description]);
    self.dataList = nil;
    self.viewList = nil;
    self.tableView = nil;
}


@end
