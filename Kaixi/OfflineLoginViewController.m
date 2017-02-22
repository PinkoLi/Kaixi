//
//  OfflineLoginViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "OfflineLoginViewController.h"
#import "UserInfo.h"
@interface OfflineLoginViewController ()

@end

@implementation OfflineLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    //设置动画的名字
//    [UIView beginAnimations:@"Animation" context:nil];
//    //设置动画的间隔时间
//    [UIView setAnimationDuration:0.20];
//    //??使用当前正在运行的状态开始下一段动画
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    //设置视图移动的位移
//    
//    double version = [[UIDevice currentDevice].systemVersion doubleValue];
//    if(version<=8.0){
//        self.view.frame = CGRectMake(self.view.frame.origin.x-200, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
//    }else{
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-200 , self.view.frame.size.width, self.view.frame.size.height);
//    }
//    //设置动画结束
//    [UIView commitAnimations];
//}
////在UITextField 编辑完成调用方法
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    //设置动画的名字
//    [UIView beginAnimations:@"Animation" context:nil];
//    //设置动画的间隔时间
//    [UIView setAnimationDuration:0.20];
//    //??使用当前正在运行的状态开始下一段动画
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    //设置视图移动的位移
//    double version = [[UIDevice currentDevice].systemVersion doubleValue];
//    if(version<=8.0){
//        self.view.frame = CGRectMake(self.view.frame.origin.x+210, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
//    }else{
//        
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+210 , self.view.frame.size.width, self.view.frame.size.height);
//    }
//    //设置动画结束
//    [UIView commitAnimations];
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version<8.0){
        if(self.interfaceOrientation==UIDeviceOrientationLandscapeLeft){
            self.view.frame = CGRectMake(self.view.frame.origin.x+200, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
            
        }  else{
            self.view.frame = CGRectMake(self.view.frame.origin.x-200, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }else{
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-200 , self.view.frame.size.width, self.view.frame.size.height);
    }
    //设置动画结束
    [UIView commitAnimations];
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    //    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    //    if(version<8.0){
    //        self.view.frame = CGRectMake(self.view.frame.origin.x+215, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version<8.0){
        if(self.interfaceOrientation==UIDeviceOrientationLandscapeLeft){
            self.view.frame = CGRectMake(self.view.frame.origin.x-200, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
            
        }  else{
            self.view.frame = CGRectMake(self.view.frame.origin.x+200, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }
    else{
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+200 , self.view.frame.size.width, self.view.frame.size.height);
    }
    //设置动画结束
    [UIView commitAnimations];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)loginMenu:(id)sender {
    
    UserInfo*userInfo=[UserInfo MR_findFirst];

    if (![userInfo.offpw isEqualToString:_passWord.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
    }
    else{
        NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
        [online setObject:@"0" forKey:@"online"];
        [online synchronize];
    
     [self performSegueWithIdentifier:@"offMenu" sender:self];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    //    textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 50;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _passWord.attributedText = [[NSAttributedString alloc] initWithString:_passWord.text attributes:attributes];
    
}
@end
