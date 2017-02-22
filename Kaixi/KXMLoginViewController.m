//
//  KXMLoginViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/3/2.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "KXMLoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
@interface KXMLoginViewController ()

@end

@implementation KXMLoginViewController

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

    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
        //[online setObject:@"1" forKey:@"online"];
    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
        //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
        NSString *openUDID = [LXF_OpenUDID value];
        NSDictionary *parameters =@{@"udid":openUDID};
        
        
        NSLog(@"parm =  %@",parameters);
        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
        NSString*string=[url objectForKey:@"string"];
        [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=question/kaixuancan" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"isok"] intValue]==0)
            {
                //错误
                UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"一天只能挑战1次哦" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                
                
                [alert show];
                
            }
            else{
                [self performSegueWithIdentifier:@"login" sender:self];
            
            
            }
            
        }
         
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
    }
    
    
    else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }

}
@end
