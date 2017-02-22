//
//  InfomationViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/25.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfomationViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *questionLb;
@property (strong, nonatomic) IBOutlet UILabel *answerLb;

@property (strong,nonatomic) NSMutableString * upstr;
@property (strong,nonatomic) NSMutableString * downstr;

@end
