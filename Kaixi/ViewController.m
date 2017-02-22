//
//  ViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
#import "UserInfo.h"
#import "Reachability.h"
#import "APService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    //注册键盘出现与隐藏时候的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                          selector:@selector(keyboadWillShow:)
//                                                          name:UIKeyboardWillShowNotification
//                                                          object:nil];
//         [[NSNotificationCenter defaultCenter] addObserver:self
//                                                          selector:@selector(keyboardWillHide:)
//                                                       name:UIKeyboardWillHideNotification
//                                                       object:nil];
//         //添加手势，点击屏幕其他区域关闭键盘的操作
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//        gesture.numberOfTapsRequired = 1;//手势敲击的次数
//        [self.view addGestureRecognizer:gesture];
    
    NSUserDefaults *pw = [NSUserDefaults standardUserDefaults];
    if (![pw objectForKey:@"PW"]) {
        _rePW.hidden=YES;
    }
    else{
        _forgetPW.hidden=YES;
        _CMR.text=[pw objectForKey:@"CRM"];
        _phoneNumber.text=[pw objectForKey:@"PW"];
    }
    
    
    
    _act.hidden=YES;
    _act.hidesWhenStopped=YES;
    _act.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
   
    
      NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=@"http://121.40.148.167";
    [url setObject:string forKey:@"string"];
    NSLog(@"%@",string);
    [url synchronize];
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
////键盘出现时候调用的事件
// -(void) keyboadWillShow:(NSNotification *)note{
//         NSDictionary *info = [note userInfo];
//         CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
//         CGFloat offY = (self.view.frame.size.height-keyboardSize.height)-_CMR.frame.size.height;//屏幕总高度-键盘高度-UITextField高度
//        [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
//         [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
//         _CMR.frame = CGRectMake(_CMR.frame.origin.x, offY, _CMR.frame.size.width, _CMR.frame.size.height);//UITextField位置的y坐标移动到offY
//   
//         [UIView commitAnimations];//开始动画效果
//    
//     }
// //键盘消失时候调用的事件
// -(void)keyboardWillHide:(NSNotification *)note{
//         [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
//         [UIView setAnimationDuration:0.3];
//         _CMR.frame = CGRectMake(_CMR.frame.origin.x, _CMR.frame.origin.y, _CMR.frame.size.width, _CMR.frame.size.height);//UITextField位置复原
//     
//         [UIView commitAnimations];
//     }
//隐藏键盘方法
//点击屏幕，让键盘弹回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
 -(void)hideKeyboard{
         [_CMR resignFirstResponder];
         [_phoneNumber resignFirstResponder];
     }

//-(void)viewDidDisappear:(BOOL)animated{
//        [super viewDidDisappear:animated];
//         [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
//     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    _act.hidden=NO;
    [_act startAnimating ];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"user":_CMR.text,@"phone":_phoneNumber.text,@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
      NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"%@",string);
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/login"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        
        if([[responseObject objectForKey:@"ok"] intValue]==0)
        {
            [_act stopAnimating ];
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                
                
                _alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录设备错误" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [_alert show];
            }
            if ([[responseObject objectForKey:@"p"] intValue]==2) {
                [_act stopAnimating ];
                
                _alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您输入用户名或密码错误" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [_alert show];
            }

            
        
            
            
        }
        else if ([[responseObject objectForKey:@"ok"] intValue]==1){
            
            
            
        
        
            _dict=responseObject;
            NSLog(@"-------%@",_dict);

            
            BOOL hasNum=[UserInfo MR_countOfEntities];
            UserInfo *userInfo;
            if(hasNum)
            {
                userInfo = [UserInfo MR_findFirst];
                
            }else
            {
                userInfo = [UserInfo MR_createEntity];
            }
            if([userInfo.noticeTag isEqualToString:[_dict objectForKey:@"noticeTag"]])
            {
                
                
            }else
            {
                userInfo.noticeTag = [_dict objectForKey:@"noticeTag"];
                
//                [APService setTags:(NSSet *)tags callbackSelector:(SEL)cbSelector object:(id)theTarget];
                [APService setTags:[NSSet setWithObject:@"haha"] callbackSelector:nil object:nil];
            }
            
//            UserInfo *userInfo = [UserInfo MR_createEntity];
            userInfo.name=[_dict objectForKey:@"name"];
            userInfo.account=[_dict objectForKey:@"account"];
            userInfo.large=[_dict objectForKey:@"large"];
            userInfo.area=[_dict objectForKey:@"area"];
            userInfo.fuhuo=[NSNumber numberWithInt:[[_dict objectForKey:@"fuhuo"]intValue]];
           // userInfo.offpw=[_dict objectForKey:@"offpw"];
            userInfo.highScore=[NSNumber numberWithInt:[[_dict objectForKey:@"highScore"]intValue]];
            userInfo.surplusScore=[NSNumber numberWithInt:[[_dict objectForKey:@"surplusScore"]intValue]];                userInfo.countryRanking=[NSNumber numberWithInt:[[_dict objectForKey:@"countryRanking"]intValue]];
            userInfo.areaRanking=[NSNumber numberWithInt:[[_dict objectForKey:@"areaRanking"]intValue]];
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
            [online setObject:@"1" forKey:@"online"];
            [online synchronize];
            
            if (!hasNum) {
                [self performSegueWithIdentifier:@"setPassWord" sender:self];
            }
            else{
                
                
                [_act stopAnimating ];
                
                
                   NSUserDefaults *pw = [NSUserDefaults standardUserDefaults];
                if (_rePW.hidden==NO) {
                    [pw setObject:_CMR.text forKey:@"CRM"];
                    [pw setObject:_phoneNumber.text forKey:@"PW"];
                    [NSUserDefaults standardUserDefaults];
                }
                else{
                    [pw removeObjectForKey:@"CRM"];
                    [pw removeObjectForKey:@"PW"];
                    [NSUserDefaults standardUserDefaults];
                
                }
               
            
            [self performSegueWithIdentifier:@"menu" sender:self];
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_act stopAnimating ];
        _alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [_alert show];

        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)zhaohui:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"%@",string);
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/passwordget"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        if ([[responseObject objectForKey:@"ok"] intValue]==1) {
            
            
            _alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送邮件至邮箱请查收" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [_alert show];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        _alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [_alert show];
        
        NSLog(@"Error: %@", error);
    }];


}
//- (void)willPresentAlertView:(UIAlertView *)alertView
//{
//    
//    [[[_alert subviews]objectAtIndex:2]setFrame:CGRectMake(19, _alert.bounds.size.height - 60, 70, 40)];
//    
//    
//}




- (IBAction)packUp:(id)sender {
     [sender resignFirstResponder];  
}

- (IBAction)backView:(id)sender {
    
    if (![UserInfo MR_countOfEntities]) {
       [self performSegueWithIdentifier:@"first" sender:self];
    }
    else{
         [self performSegueWithIdentifier:@"second" sender:self];
    }

}

- (IBAction)pwAction:(id)sender {
    [self isConnectionAvailable];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    //NSString *mail =@"529491165@qq.com";
    NSDictionary *parameters =@{@"udid":openUDID};
    
    
   // NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];

    [manager POST:@"http://1.laboratoryback.sinaapp.com/index.php/Duijie/aa.html" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送至指定邮箱，请查收" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            
            [alert show];
            
        
        
       
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络是否连接" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        return NO;
    }
    
    return isExistenceNetwork;
}


- (IBAction)forget:(id)sender {
    _forgetPW.hidden=YES;
    _rePW.hidden=NO;
}

- (IBAction)remerb:(id)sender {
    _rePW.hidden=YES;
    _forgetPW.hidden=NO;
}
@end
