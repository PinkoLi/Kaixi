//
//  DiaoYanViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/3/6.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "DiaoYanViewController.h"

@interface DiaoYanViewController ()

@end

@implementation DiaoYanViewController

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



- (IBAction)trace:(id)sender {
//    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
//    //    [online setObject:@"1" forKey:@"online"];
//    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
//        [self performSegueWithIdentifier:@"trace" sender:self];
//    }
//    
//    else{
//        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//        
//        
//        [alert show];
//        
//        
//        
//        
//    }
    [self performSegueWithIdentifier:@"trace" sender:self];

}
@end
