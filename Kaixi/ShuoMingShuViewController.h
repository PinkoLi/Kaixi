//
//  ShuoMingShuViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/3/20.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuoMingShuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *leftTable;

@property (strong, nonatomic) IBOutlet UITableView *rightTable;
@property(nonatomic, strong) NSMutableArray* policyListArray;
@property(nonatomic, strong) NSMutableArray* policyInfoArray;
@property(nonatomic, strong)NSMutableArray *images;

@property(nonatomic, strong)NSString*tag2;
@end
