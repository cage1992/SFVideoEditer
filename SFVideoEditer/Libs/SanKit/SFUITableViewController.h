//
//  SLibUITableViewController.h
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
//
//  本类提供了常用的列表视图的变量，包括：
//  A. 解析成各自 Model 的数据数组: dataList
//  B. 每个单元格的视图数组:		 viewList
//
//  和可公用的代理实现，包括：
//  A. 计算列表区块数: 		 numberOfSectionsInTableView
//  B. 计算每个区块中列表的行数: numberOfRowsInSection
//  C. 每个单元格的内容: 		 cellForRowAtIndexPath
//
//  注: 每个单元格高度的计算实现在每个具体类中...
//

#import "SFUIViewController.h"

//每个表视图都要完成加载数据和高度的具体实现
@protocol SFUITableViewProtocal

@required
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

//@optional // 设置为optional是为了防止SLibUITableViewController编译时会有警告信息。
- (BOOL) loadDataFromOffset:(NSInteger)offset withLimit:(NSInteger)limit;

@end






@interface SFUITableViewController : SFUIViewController <UITableViewDelegate, UITableViewDataSource, SFUITableViewProtocal>

@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSMutableArray *viewList;
@property (nonatomic, retain) UITableView 	 *tableView;
@property (nonatomic, assign) CGFloat		 minCellHeight;
@property (nonatomic, assign) NSInteger		 tableViewPager;     // 每页多少条
@property (nonatomic, assign) NSInteger		 tableViewLastCount; // 最近一次取到多少条

- (void) addTableViewWithFrame:(CGRect)frame;
- (void) loadDataDelayed;

@end