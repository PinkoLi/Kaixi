//
//  KaiXuanMenViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/11.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KaiXuanMenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *nextBth;

- (IBAction)nestAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *endBth;
- (IBAction)endAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UILabel *questionLb;
@property (strong, nonatomic) IBOutlet UIImageView *bingo;



@property (strong, nonatomic)NSMutableDictionary* responseObject;
@property (strong, nonatomic)NSMutableDictionary* shitiObject;


@property (strong, nonatomic)NSMutableArray*optionsArray;
@property (strong, nonatomic)NSMutableArray*titleArray;
@property (strong, nonatomic)NSString*eid;
@property (strong, nonatomic)NSNumber *rightnumber;

@end
