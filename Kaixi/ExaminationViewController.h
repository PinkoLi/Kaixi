//
//  ExaminationViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/9.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
@interface ExaminationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MZTimerLabelDelegate,UIAlertViewDelegate>{
   
    MZTimerLabel* timer;
   
}
@property (weak, nonatomic) IBOutlet UILabel *tishiLb;
@property (strong, nonatomic) IBOutlet UILabel *auctionTime;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *lastBth;
@property (strong, nonatomic) IBOutlet UIButton *nextBth;
@property (strong, nonatomic)NSMutableArray*optionsArray;
@property (strong, nonatomic)NSMutableArray*daanArr;
@property (strong, nonatomic)NSMutableArray*daanArr2;
@property (strong, nonatomic)NSMutableArray*titleArray;
@property (strong, nonatomic)NSMutableString*fen;
@property (strong, nonatomic)NSMutableString*totalnum;
@property (strong, nonatomic)NSMutableString*paiming;
@property (strong, nonatomic)NSString*eid;
@property (nonatomic)NSInteger pagenow;
@property (strong, nonatomic)NSTimer*timer2;
@property (strong, nonatomic)NSMutableDictionary* responseObject;
@property (strong, nonatomic)NSMutableDictionary* shitiObject;


@property (strong, nonatomic) IBOutlet UIButton *endBth;
- (IBAction)lastAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)endAction:(id)sender;
@end
