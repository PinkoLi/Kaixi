//
//  SetPassWordViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "UserInfo.h"
@interface SetPassWordViewController ()

@end

@implementation SetPassWordViewController

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

- (IBAction)login:(id)sender {
    if([self.passWord.text length]!=4)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码必须是4位数" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
    }
    else
    if ([self.passWord.text isEqualToString:@""]  || self.passWord.text==nil||[self.passWord2.text isEqualToString:@""]  || self.passWord2.text==nil
        
        ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
        
        
        
        NSLog(@"没有输入");
        
    }
    else if (![_passWord.text isEqualToString:_passWord2.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不相同" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];
        
        
    }

//    BOOL result = [_passWord.text isEqualToString:_passWord2.text];

  
    else{
      
        UserInfo *userInfo = [UserInfo MR_findFirst];
        userInfo.offpw=_passWord.text;

         [[NSManagedObjectContext MR_defaultContext] MR_save];
        [self performSegueWithIdentifier:@"firistLogin" sender:self];
    
    
    
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {    return [self validateNumber:string];}- (BOOL)validateNumber:(NSString*)number {    BOOL res = YES;    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];    int i = 0;    while (i< number.length) {        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];        NSRange range = [string rangeOfCharacterFromSet:tmpSet];        if (range.length == 0) {            res = NO;            break;        }        i++;    }    return res;}
@end
