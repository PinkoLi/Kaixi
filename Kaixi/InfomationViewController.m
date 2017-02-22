//
//  InfomationViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/25.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "InfomationViewController.h"

@interface InfomationViewController ()

@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _answerLb.text = _downstr;
//   _answerLb.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:25]; ;
//    _questionLb.text = _upstr;
////    _answerLb.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色,要为CGColor
////    _answerLb.layer.borderWidth = 1;//边框宽度
//    _answerLb.lineBreakMode=UILineBreakModeCharacterWrap;
//    _answerLb.numberOfLines=0;
  
    
    //初始化label
    
    _questionLb.text = _upstr;
        _questionLb.lineBreakMode=UILineBreakModeCharacterWrap;
        _questionLb.numberOfLines=0;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120,227,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    label.text=_downstr;
    UIFont *font = [UIFont systemFontOfSize:22.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(730,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [label.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    //[label setFrame:CGRectMake:(0,0, labelsize.width, labelsize.height)];
     label.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:22];
    [label setFrame:CGRectMake(120, 227, labelsize.width, labelsize.height)];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:15];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
    
    [self.view addSubview:label];
    
  
    
    //label.font = [UIFont systemFontOfSize:14];
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
