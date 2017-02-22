//
//  ReviseofflineViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/5.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ReviseofflineViewController.h"
#import "UserInfo.h"
@interface ReviseofflineViewController ()

@end

@implementation ReviseofflineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {    return [self validateNumber:string];}- (BOOL)validateNumber:(NSString*)number {    BOOL res = YES;    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];    int i = 0;    while (i< number.length) {        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];        NSRange range = [string rangeOfCharacterFromSet:tmpSet];        if (range.length == 0) {            res = NO;            break;        }        i++;    }    return res;}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
     UserInfo*userInfo=[UserInfo MR_findFirst];
    if ([self.oldPW.text isEqualToString:@""]  || self.oldPW.text==nil||[self.freshPW.text isEqualToString:@""]  || self.freshPW.text==nil||[self.surePW.text isEqualToString:@""]  || self.surePW.text==nil
        
        ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
        
        
        
        NSLog(@"没有输入");
        
    }
    
    
    else if (![self.oldPW.text isEqualToString:userInfo.offpw]){
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"原始密码输入错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
    
    }
    else if (![self.freshPW.text isEqualToString:_surePW.text]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"两次密码不相同" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
        
    }

    else if((_freshPW.text.length)!=4){
    
    
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入4位数字密码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
    }
    else {
        
        
        
        userInfo.offpw=_surePW.text;
        
        [[NSManagedObjectContext MR_defaultContext] MR_save];
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改密码成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        [self performSegueWithIdentifier:@"goBack" sender:self];
        
        
        
    }

    
}
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
            self.view.frame = CGRectMake(self.view.frame.origin.x+215, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
            
        }  else{
            self.view.frame = CGRectMake(self.view.frame.origin.x-215, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }else{
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-220 , self.view.frame.size.width, self.view.frame.size.height);
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
            self.view.frame = CGRectMake(self.view.frame.origin.x-215, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
            
        }  else{
            self.view.frame = CGRectMake(self.view.frame.origin.x+215, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }
    else{
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+220 , self.view.frame.size.width, self.view.frame.size.height);
    }
    //设置动画结束
    [UIView commitAnimations];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
