//
//  DiaoYanMenuViewController.m
//  Kaixi
//
//  Created by ck on 15/7/27.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "DiaoYanMenuViewController.h"
#import"SurveyViewController.h"
@interface DiaoYanMenuViewController ()

@end

@implementation DiaoYanMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tag=@"1";
    _tag2=@"2";
    _tag3=@"3";
    
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

- (IBAction)fengXian:(id)sender {
}

- (IBAction)zhiLiao:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"goto"]) {
    
    
        SurveyViewController* view = segue.destinationViewController;
        
       
        view.tag=_tag;

    }
    
    if ([segue.identifier isEqualToString:@"goto2"]) {
        
        
        SurveyViewController* view = segue.destinationViewController;
        
        
        view.tag=_tag2;
    }
    if ([segue.identifier isEqualToString:@"goto3"]) {
        
        
        SurveyViewController* view = segue.destinationViewController;
        
        
        view.tag=_tag3;
    }

    
}


@end
