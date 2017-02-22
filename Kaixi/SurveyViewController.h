//
//  SurveyViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/26.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


- (IBAction)nextAction:(id)sender;


@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) IBOutlet UILabel *questionLb;


@property (strong, nonatomic)NSMutableArray* responseObject;
@property (strong, nonatomic)NSMutableArray* shitiObject;
@property (nonatomic)NSInteger pagenow;

@property (strong, nonatomic)NSMutableArray*optionsArray;
@property (strong, nonatomic)NSMutableArray*titleArray;

- (IBAction)nextBth:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextBth;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *otherLb;
@property (strong, nonatomic) IBOutlet UILabel *otherLb2;

@property (nonatomic, strong) NSString *tag;
@end
