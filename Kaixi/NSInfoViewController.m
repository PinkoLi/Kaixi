//
//  NSInfoViewController.m
//  Kaixi
//
//  Created by ck on 15-4-1.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "NSInfoViewController.h"

@interface NSInfoViewController ()

@end

@implementation NSInfoViewController

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
- (void)viewDidLoad {
    [super viewDidLoad];
   // _infoTitle.text=_info;
    _titleLb.text=_gonggao;
    _timeLb.text=_time;
   // _titleLb.textColor=UIColorFromRGB(0x1993CF);
   // [_titleLb setTintColor:UIColorFromRGB(0x1993CF)];
   
  
//    _infoTitle.layer.borderColor = [UIColor lightTextColor].CGColor;//边框颜色,要为CGColor
//    _infoTitle.layer.borderWidth = 0.5;//边框宽度
    _infoTitle.lineBreakMode=UILineBreakModeCharacterWrap;
    _infoTitle.numberOfLines=0;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120,267,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    label.text=_info;
    UIFont *font = [UIFont systemFontOfSize:22.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(730,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [label.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    //[label setFrame:CGRectMake:(0,0, labelsize.width, labelsize.height)];
    label.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:22]; ;
    [label setFrame:CGRectMake(120, 267, labelsize.width, labelsize.height)];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:15];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
    
    [self.view addSubview:label];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
