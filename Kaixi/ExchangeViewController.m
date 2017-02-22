//
//  ExchangeViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/2.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ExchangeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
#import "UserInfo.h"
#import "Reachability.h"

@interface ExchangeViewController ()

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      UserInfo*userInfo=[UserInfo MR_findFirst];
    _fen.text=[NSString stringWithFormat:@"%@",userInfo.surplusScore];
    [_fen setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
 
   
    // Do any additional setup after loading the view.
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

- (IBAction)Upan:(id)sender {
    
    [self isConnectionAvailable];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    
    NSDictionary *parameters =@{@"udid":openUDID,@"tag":@"7"};
    
    NSLog(@"%@",parameters);
    
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"parm =  %@",parameters);
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/jfthree" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            _fen.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fen"]] ;
            UserInfo*userInfo=[UserInfo MR_findFirst];
            userInfo.surplusScore=[NSNumber numberWithInt:[[responseObject objectForKey:@"fen"] intValue]];
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功！礼品会定期发放，敬请等待。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
            
            
            
        }else
        {
            
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                _fen=[responseObject objectForKey:@"fen"];
                // fen,fuhuo,totalfen
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的积分不够" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
                
                
            }
            else{
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)lockBei:(id)sender {
    
    [self isConnectionAvailable];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    
    NSDictionary *parameters =@{@"udid":openUDID,@"tag":@"2"};
    
    NSLog(@"%@",parameters);
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/jfthree" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            _fen.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fen"]] ;
            UserInfo*userInfo=[UserInfo MR_findFirst];
            userInfo.surplusScore=[NSNumber numberWithInt:[[responseObject objectForKey:@"fen"] intValue]];
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功！礼品会定期发放，敬请等待。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
            
            
            
        }else
        {
            
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                _fen=[responseObject objectForKey:@"fen"];
                // fen,fuhuo,totalfen
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的积分不够" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
                
                
            }
            else{
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"sb" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)pen:(id)sender {
    
    [self isConnectionAvailable];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    
    NSDictionary *parameters =@{@"udid":openUDID,@"tag":@"3"};
    
    NSLog(@"%@",parameters);
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/jfthree" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            _fen.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fen"]] ;
            UserInfo*userInfo=[UserInfo MR_findFirst];
            userInfo.surplusScore=[NSNumber numberWithInt:[[responseObject objectForKey:@"fen"] intValue]];
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功！礼品会定期发放，敬请等待。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
            
            
            
        }else
        {
            
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                _fen=[responseObject objectForKey:@"fen"];
                // fen,fuhuo,totalfen
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的积分不够" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
                
                
            }
            else{
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"sb" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)baby:(id)sender {
    
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"每季度积分最高（统计截至当季度最后1天）可获得兑换呼吸论坛名额的机会（届时将发送通知邮件，兑换后系统会扣除相应基础分值）" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
   
   
    [alert show];

}

- (IBAction)challenge:(id)sender {
    
    [self isConnectionAvailable];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    NSDictionary *parameters =@{@"udid":openUDID};
    
    NSLog(@"%@",parameters);
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/Jffuhuo" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            _fen.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fen"]] ;
             UserInfo*userInfo=[UserInfo MR_findFirst];
            userInfo.fuhuo=[NSNumber numberWithInt:[[responseObject objectForKey:@"fuhuo"] intValue]];
            userInfo.surplusScore=[NSNumber numberWithInt:[[responseObject objectForKey:@"fen"] intValue]];
          
            
              [[NSManagedObjectContext MR_defaultContext] MR_save];
            

            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功啦" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            

            
            
        }else
        {
            
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                _fen=[responseObject objectForKey:@"fen"];
                // fen,fuhuo,totalfen
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的积分不够" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
                
                
            }
            else{
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
- (IBAction)jiguang:(id)sender {
    [self isConnectionAvailable];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    
    NSDictionary *parameters =@{@"udid":openUDID,@"tag":@"1"};
    
    NSLog(@"%@",parameters);
    
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"parm =  %@",parameters);
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/jfthree" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            _fen.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fen"]] ;
            UserInfo*userInfo=[UserInfo MR_findFirst];
            userInfo.surplusScore=[NSNumber numberWithInt:[[responseObject objectForKey:@"fen"] intValue]];
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功！礼品会定期发放，敬请等待。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
            
            
            
        }else
        {
            
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                _fen=[responseObject objectForKey:@"fen"];
                // fen,fuhuo,totalfen
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的积分不够" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
                
                
            }
            else{
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)zipai:(id)sender {
    [self isConnectionAvailable];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    
    NSDictionary *parameters =@{@"udid":openUDID,@"tag":@"6"};
    
    NSLog(@"%@",parameters);
    
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"parm =  %@",parameters);
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/jfthree" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==1)
        {
            _fen.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fen"]] ;
            UserInfo*userInfo=[UserInfo MR_findFirst];
            userInfo.surplusScore=[NSNumber numberWithInt:[[responseObject objectForKey:@"fen"] intValue]];
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功！礼品会定期发放，敬请等待。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
            
            
            
        }else
        {
            
            if ([[responseObject objectForKey:@"p"] intValue]==1) {
                _fen=[responseObject objectForKey:@"fen"];
                // fen,fuhuo,totalfen
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的积分不够" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
                
                
            }
            else{
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
@end
