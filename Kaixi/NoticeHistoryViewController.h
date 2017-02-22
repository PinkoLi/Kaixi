//
//  NoticeHistoryViewController.h
//  Kaixi
//
//  Created by ck on 15-4-1.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;
@property(nonatomic, strong) NSMutableArray* nhArray;
@end
