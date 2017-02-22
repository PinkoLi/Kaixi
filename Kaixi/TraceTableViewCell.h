//
//  TraceTableViewCell.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/3/3.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPLoadingView.h"
@interface TraceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UIButton *update2;
@property (strong, nonatomic) IBOutlet UIButton *update;
@property (strong, nonatomic) IBOutlet UILabel *lb;

@property (strong, nonatomic) IBOutlet GPLoadingView *act2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;

@end
