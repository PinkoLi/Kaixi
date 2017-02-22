//
//  KaiXuanMenViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/11.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "KaiXuanMenViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
#import "KaiXuanMenlTableViewCell.h"
@interface KaiXuanMenViewController ()

@end

@implementation KaiXuanMenViewController

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shitiObject = [[NSMutableDictionary alloc]init];
    
    _rightnumber = [NSNumber numberWithInt: 1];
    
    [_nextBth setTitle:@"下一题" forState:UIControlStateNormal];
    
    [_nextBth setTintColor:UIColorFromRGB(0xFFFFFF)];
    _nextBth.backgroundColor=UIColorFromRGB(0x1993CF);
    
    [_endBth setTitle:@"退出挑战" forState:UIControlStateNormal];
    [_endBth setTintColor:UIColorFromRGB(0x5A5656)];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=question/kaixuangetquestion" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
            
            
            NSLog(@"%@",[[responseObject objectForKey:@"shiti"]objectForKey:@"title"]);
       // @"%d . %@", [_rightnumber intValue],
            _questionLb.text=[NSString stringWithFormat:@" %@", [[responseObject objectForKey:@"shiti"]objectForKey:@"title"]];
        _questionLb.font=[UIFont systemFontOfSize:24];
        _questionLb.lineBreakMode=UILineBreakModeCharacterWrap;
        _questionLb.numberOfLines=0;

            
            _eid=[responseObject objectForKey:@"id"];
            
            _responseObject=responseObject;
            
            NSLog(@"---%@",_responseObject);
            NSMutableDictionary * one = [responseObject objectForKey:@"shiti"];
            
            
            [_shitiObject setObject:[one objectForKey:@"title"] forKey:@"title"];
            
            NSMutableArray * options = [[NSMutableArray alloc]init];
            
            for(NSDictionary * optionone1 in [one objectForKey:@"options"])
            {
                NSMutableDictionary * optionone = [[NSMutableDictionary alloc]init];
                [optionone setObject:[optionone1 objectForKey:@"name"] forKey:@"name"];
                [optionone setObject:@"0" forKey:@"ischecked"];
                
                [options addObject: optionone];
            }
            [_shitiObject setObject:options forKey:@"options"];
            
            [_table reloadData];

        }
        
        
    
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
   
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_shitiObject objectForKey:@"options"] count] ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    KaiXuanMenlTableViewCell *cell = (KaiXuanMenlTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[KaiXuanMenlTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSArray * arr = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
    
    if([[[_shitiObject objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"]isEqualToString:@"0" ])
    {
        cell.bingo.hidden = YES;
    }else{
        cell.bingo.hidden = NO;
    }
    
    cell.options.text = [NSString stringWithFormat:@"%@:   %@",arr[indexPath.row],[[_shitiObject objectForKey:@"options"][indexPath.row] objectForKey:@"name"]];
    _table.backgroundColor=[UIColor clearColor];
    cell.options.font=[UIFont systemFontOfSize:24];
    cell.backgroundColor=[UIColor clearColor];
    cell.options.lineBreakMode=UILineBreakModeCharacterWrap;
    cell.options.numberOfLines=0;

    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KaiXuanMenlTableViewCell *cell = (KaiXuanMenlTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    //ExamTableViewCell *cell ;
    
    if([[[_shitiObject objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"]isEqualToString:@"0" ])
    {
        [[_shitiObject objectForKey:@"options"][indexPath.row] setObject:@"1" forKey:@"ischecked"];
        cell.bingo.hidden = NO;
    }else{
        [[_shitiObject objectForKey:@"options"][indexPath.row] setObject:@"0" forKey:@"ischecked"];
        cell.bingo.hidden = YES;
    }
    //indexPath.row+1;
    NSLog(@"%@",[[_shitiObject objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"]);
    
}

- (IBAction)nestAction:(id)sender {
        
        int j = 0;
        int p=0;
        
        NSMutableString * str = [[NSMutableString alloc] initWithString:@""];
        
        NSLog(@"%@",_shitiObject);
        
        for(NSMutableDictionary * optionone in [_shitiObject objectForKey:@"options"])
        {
            if([[optionone objectForKey:@"ischecked"] isEqualToString:@"1"])
            {
                [str appendString:[NSString stringWithFormat:@"%d",j+1]];
                p=1;
            }
            j++;
        }
    
    if(p==0)
    {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有选择答案" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
    }else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *parameters =@{@"eid":_eid,@"answerjson":str};
        
        NSLog(@"%@",parameters);
        
        
        NSLog(@"parm =  %@",parameters);
        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
        NSString*string=[url objectForKey:@"string"];
        [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=question/kaixuangetquestion2" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSLog(@"%@",responseObject);
            
            if([[responseObject objectForKey:@"ok"]intValue]==1)
            {
                _rightnumber =[NSNumber numberWithInt:[_rightnumber intValue]+1];
                
                _questionLb.text=[NSString stringWithFormat:@" %@", [[responseObject objectForKey:@"shiti"]objectForKey:@"title"]];
               _questionLb.font=[UIFont systemFontOfSize:24];
                _questionLb.lineBreakMode=UILineBreakModeCharacterWrap;
                _questionLb.numberOfLines=0;
                _responseObject=responseObject;
                
                NSMutableDictionary * one = [responseObject objectForKey:@"shiti"];
                
                
                [_shitiObject setObject:[one objectForKey:@"title"] forKey:@"title"];
                
                NSMutableArray * options = [[NSMutableArray alloc]init];
                
                for(NSDictionary * optionone1 in [one objectForKey:@"options"])
                {
                    NSMutableDictionary * optionone = [[NSMutableDictionary alloc]init];
                    [optionone setObject:[optionone1 objectForKey:@"name"] forKey:@"name"];
                    [optionone setObject:@"0" forKey:@"ischecked"];
                    
                    [options addObject: optionone];
                }
                [_shitiObject setObject:options forKey:@"options"];
                
                [_table reloadData];
                
                
                
                
            }
            else
                if([[responseObject objectForKey:@"ok"]intValue]==0)
                {
                    if([[responseObject objectForKey:@"p"] intValue] ==1&&[[responseObject objectForKey:@"fuhuo"]intValue]==1)
                    {
                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你有一张复活卷" delegate:self cancelButtonTitle:nil otherButtonTitles:@"使用",@"放弃",nil];
                        [alertView show];
                        alertView.tag=1;
                        
                        
                    }
                    else{
                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"挑战失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                        [alertView show];
                        alertView.tag=2;
                        
                    }
                }
            
                else
                    if([[responseObject objectForKey:@"ok"]intValue]==2)
                    {
                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"今日挑战成功，明天再来哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                        [alertView show];
                         alertView.tag=2;
                    
                    }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSDictionary *parameters =@{@"eid":_eid,@"fuhuo":@"1"};
            
            
            
            NSLog(@"parm =  %@",parameters);
            NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
            NSString*string=[url objectForKey:@"string"];
            [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=question/kaixuangetquestion2" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                
                if([[responseObject objectForKey:@"ok"]intValue]==1)
                {
                    _questionLb.text=[[responseObject objectForKey:@"shiti"]objectForKey:@"title"];
                    
                    _responseObject=responseObject;
                    
                    NSMutableDictionary * one = [responseObject objectForKey:@"shiti"];
                    
                    
                    [_shitiObject setObject:[one objectForKey:@"title"] forKey:@"title"];
                    
                    NSMutableArray * options = [[NSMutableArray alloc]init];
                    
                    for(NSDictionary * optionone1 in [one objectForKey:@"options"])
                    {
                        NSMutableDictionary * optionone = [[NSMutableDictionary alloc]init];
                        [optionone setObject:[optionone1 objectForKey:@"name"] forKey:@"name"];
                        [optionone setObject:@"0" forKey:@"ischecked"];
                        
                        [options addObject: optionone];
                    }
                    [_shitiObject setObject:options forKey:@"options"];
                    
                    [_table reloadData];
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
            
            
            
        }
        if (buttonIndex==1) {
            [self performSegueWithIdentifier:@"goback" sender:self];

            
        }
    }
    else if (alertView.tag==2) {
        if (buttonIndex==0) {
         [self performSegueWithIdentifier:@"goback" sender:self];
        
        
        }

    }
    else if (alertView.tag==3) {
        if (buttonIndex==0) {
            [self performSegueWithIdentifier:@"goback" sender:self];
            
            
        }
        
    }


}
- (IBAction)endAction:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否退出挑战？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [alertView show];
    alertView.tag=3;
    
    
}
@end
