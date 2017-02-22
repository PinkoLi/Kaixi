//
//  MenuViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)zhuxiao:(id)sender;

- (IBAction)diaoyan:(id)sender;
- (IBAction)jifen:(id)sender;
- (IBAction)qiandao:(id)sender;
- (IBAction)jiaoliu:(id)sender;
- (IBAction)zhengce:(id)sender;
- (IBAction)gonggao:(id)sender;
- (IBAction)listView:(id)sender;
- (IBAction)kxm:(id)sender;
@property(nonatomic, strong) NSMutableArray* nhArray;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag1;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag2;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag3;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag4;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag5;
@end
