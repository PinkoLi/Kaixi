//
//  ListViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/28.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if([[defaults objectForKey:@"noticeTag6"] isEqualToString:@"1"])
    {
        _noticeTag6.hidden= NO;
    }else
    {
        _noticeTag6.hidden=YES;
    }
    
    if([[defaults objectForKey:@"noticeTag7"] isEqualToString:@"1"])
    {
        _noticeTag7.hidden= NO;
    }else
    {
        _noticeTag7.hidden=YES;
    }
    
    if([[defaults objectForKey:@"noticeTag8"] isEqualToString:@"1"])
    {
        _noticeTag8.hidden= NO;
    }else
    {
        _noticeTag8.hidden=YES;
    }
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

- (IBAction)letGo:(id)sender {
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
//    [online setObject:@"1" forKey:@"online"];
    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"noticeTag8"];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
        //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
        
        //    NSDictionary *parameters =@{@"udid":openUDID,@"registrationID":userInfo.registrationID};
        
        NSString *openUDID = [LXF_OpenUDID value];
        NSDictionary *parameters =@{@"uuid":openUDID};
        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
        NSString*string=[url objectForKey:@"string"];
        
        [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=question/examcan"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",parameters);
            
           
            
            if ([[responseObject objectForKey:@"isok"] intValue]==2) {
                
                
                
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您今天没有通过考试，请明天再试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
                
                
            }
            if ([[responseObject objectForKey:@"isok"] intValue]==3) {
                
                
                
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您今天已经通过考试，请明天再试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
                
                
            }
          else  if ([[responseObject objectForKey:@"isok"] intValue]==1) {
                
                
                
                //                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新只需1分钟。强烈建议您立即进行更新，如不更新将影响相关功能使用。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                [alertView show];
                
                [self performSegueWithIdentifier:@"exam" sender:self];
            }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
            NSLog(@"Error: %@", error);
        }];
    

       
    }
    
    else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];

    
    
    
    }

    
}

- (IBAction)kaoshi:(id)sender {
    
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"study"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"noticeTag6"];
    }
    if ([segue.identifier isEqualToString:@"yixue"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"noticeTag7"];
        
    }
    
}
- (IBAction)jidukaoshi:(id)sender {
    
    
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该板块尚未开放" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}
@end
