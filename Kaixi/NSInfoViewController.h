//
//  NSInfoViewController.h
//  Kaixi
//
//  Created by ck on 15-4-1.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *infoTitle;
@property (strong, nonatomic)NSString*info;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic)NSString*gonggao;
@property (strong, nonatomic)NSString*time;
@property (strong, nonatomic) IBOutlet UILabel *timeLb;
@end
