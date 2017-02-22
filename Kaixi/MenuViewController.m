//
//  MenuViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "MenuViewController.h"
#import "LXF_OpenUDID.h"
#import "AFHTTPRequestOperationManager.h"
#import "NoticeNowTableViewCell.h"
#import "NSInfoViewController.h"
#import "APService.h"
#import "UserInfo.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:)name:kJPFNetworkDidRegisterNotification object:nil];
    
    
    if (![UserInfo MR_countOfEntities]) {
        
        //
        
    }else{
        
        UserInfo * userInfo = [UserInfo MR_findFirst];
        NSLog(@"%@",userInfo);
        
        if([userInfo.registrationID isEqualToString:[APService registrationID]])
        {
            
        }else
        {
            userInfo.registrationID=[APService registrationID];
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
            //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
            
            NSString *openUDID = [LXF_OpenUDID value];
            NSDictionary *parameters =@{@"udid":openUDID,@"registrationID":userInfo.registrationID};
            
            
            NSLog(@"parm =  %@",parameters);
            NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
            NSString*string=[url objectForKey:@"string"];
            NSLog(@"%@",string);
            [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/ridchange"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                NSLog(@"%@",responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                
                
                NSLog(@"Error: %@", error);
            }];
            
            
            
            
        }
        
    }
    
    NSLog(@"^&*^@&^#&*^@!*^*^#*!%@",[APService registrationID]);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if([[defaults objectForKey:@"noticeTag1"] isEqualToString:@"1"])
    {
        _noticeTag1.hidden= NO;
    }else
    {
        _noticeTag1.hidden=YES;
    }
    
    if([[defaults objectForKey:@"noticeTag2"] isEqualToString:@"1"])
    {
        _noticeTag2.hidden= NO;
    }else
    {
        _noticeTag2.hidden=YES;
    }
    
    if([[defaults objectForKey:@"noticeTag3"] isEqualToString:@"1"])
    {
        _noticeTag3.hidden= NO;
    }else
    {
        _noticeTag3.hidden=YES;
    }
    
    if([[defaults objectForKey:@"noticeTag4"] isEqualToString:@"1"])
    {
        _noticeTag4.hidden= NO;
    }else
    {
        _noticeTag4.hidden=YES;
    }
    
    if([[defaults objectForKey:@"noticeTag5"] isEqualToString:@"1"])
    {
        _noticeTag5.hidden= NO;
    }else
    {
        _noticeTag5.hidden=YES;
    }
    
    _nhArray=[[NSMutableArray alloc]init];
    _table.backgroundColor=[UIColor clearColor];
     _table.separatorColor = [UIColor clearColor];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=notice/getnow"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
        
        //_nhArray=[responseObject objectForKey:@"title"];
        
        _nhArray=responseObject;
        
        
        NSLog(@"==========%@",_nhArray);
        
        
        
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)networkDidRegister:(NSNotification *)notification {
    
    //[[notification userInfo] valueForKey:@"RegistrationID"];
    NSLog(@"%@", [[notification userInfo] valueForKey:@"RegistrationID"]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)zhuxiao:(id)sender {
    
    
}

- (IBAction)diaoyan:(id)sender {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"noticeTag4"];
   
    [self performSegueWithIdentifier:@"diaoyan" sender:self];
   

}

- (IBAction)jifen:(id)sender {
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    //    [online setObject:@"1" forKey:@"online"];
    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"jifen" sender:self];
    }
    
    else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }

}

- (IBAction)qiandao:(id)sender {
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }
    else{

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
    
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=user/logup"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([[responseObject objectForKey:@"ok"] intValue]==0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您今天已经签到过了" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            
            [alert show];
            
            
            
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"签到成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            
            [alert show];
        
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    }
}

- (IBAction)jiaoliu:(id)sender {
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    //    [online setObject:@"1" forKey:@"online"];
    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"noticeTag5"];
      
        [self performSegueWithIdentifier:@"hudong" sender:self];
    }
    
    else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }

}

- (IBAction)zhengce:(id)sender {
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    //    [online setObject:@"1" forKey:@"online"];
    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"noticeTag2"];
        [self performSegueWithIdentifier:@"zhengce" sender:self];
    }
    
    else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }
   

}

- (IBAction)gonggao:(id)sender {
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"敬请期待" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    
    
    [alert show];

}

- (IBAction)listView:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"noticeTag1"];
     [self performSegueWithIdentifier:@"list" sender:self];
}

- (IBAction)kxm:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"noticeTag3"];
    [self performSegueWithIdentifier:@"kxm" sender:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _nhArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    static NSString *CellIdentifier = @"Cell";
    NoticeNowTableViewCell *cell = (NoticeNowTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NoticeNowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    //
    
    cell.title.text = [_nhArray[indexPath.section]objectForKey:@"content" ];
    
    
    // cell.prodect.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.kid] ];
    //cell.kidLb.text= [productarr objectForKey: [numberFormatter stringFromNumber:knowledge.mpid] ];
    cell.backgroundColor=[UIColor clearColor];
    cell.title.lineBreakMode=UILineBreakModeCharacterWrap;
    cell.title.numberOfLines=0;
    
    return cell;
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"gonggao"]) {
        
        //  NSMutableDictionary *dict ;
        NSIndexPath *indexPath;
        
        indexPath=[_table indexPathForSelectedRow];
        //        NSLog(@"%ld",(long)indexPath.section);
        // NSString * thetitle = [_nhArray[indexPath.section] objectForKey:@"title"];
        //        NSLog(@"%@",knowledge.pages);
        //        NSLog(@"%@",knowledge.id);
        
        
        
        
        
        //
        //        dict =[_images objectAtIndex:indexPath.row];
        //
        //
        //
        NSInfoViewController* view = segue.destinationViewController;
        
        view.info = [_nhArray[indexPath.section]objectForKey:@"content" ];
        view.gonggao = [_nhArray[indexPath.section]objectForKey:@"title" ];
        view.time=[_nhArray[indexPath.section]objectForKey:@"time" ];
        
        
        //        view.imageArray=_images;
        // NSLog(@"--------------%@",view.data);
        
        
        
    }
    
    
    
}

@end
