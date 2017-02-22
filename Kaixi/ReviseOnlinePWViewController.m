//
//  ReviseOnlinePWViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/5.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ReviseOnlinePWViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
@interface ReviseOnlinePWViewController ()

@end

@implementation ReviseOnlinePWViewController

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

- (IBAction)save:(id)sender {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
     NSString *openUDID = [LXF_OpenUDID value];
  
    NSDictionary *parameters =@{@"oldpwd":_oldPW.text,@"newpwd":_freshPW.text,@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
   
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/passwordchange"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if([self.oldPW.text isEqualToString:@""]  || self.oldPW.text==nil||[self.freshPW.text isEqualToString:@""]  || self.freshPW.text==nil||[self.surePW.text isEqualToString:@""]  || self.surePW.text==nil)
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
        }

        else  if(![_surePW.text isEqualToString:_freshPW.text])
        {
             UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"新密码不一致" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
        }
        
              else   if([[responseObject objectForKey:@"isok"] intValue]==0)
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查初始密码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
        }

            else{
                
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
               
                
                [self performSegueWithIdentifier:@"goback" sender:self];
            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    
    
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
//点击屏幕，让键盘弹回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
