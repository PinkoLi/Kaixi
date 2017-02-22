//
//  ExaminationViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/9.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ExaminationViewController.h"
#import "ExamTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
#import "ExamViewController.h"
@interface ExaminationViewController ()

@end

@implementation ExaminationViewController
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


- (void)viewDidLoad {
    
    _optionsArray =[[NSMutableArray alloc]init];
    _responseObject =[[NSMutableDictionary alloc]init];
    _shitiObject = [[NSMutableDictionary alloc]init];
    _daanArr = [[NSMutableArray alloc]init];
    _daanArr2 = [[NSMutableArray alloc]init];
   
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [_nextBth setTitle:@"下一题" forState:UIControlStateNormal];
    //_nextBth.titleLabel.backgroundColor=[UIColor whiteColor];
    [_nextBth setTintColor:UIColorFromRGB(0xFFFFFF)];
    _nextBth.backgroundColor=UIColorFromRGB(0x1993CF);
  
    
     [_lastBth setTitle:@"上一题" forState:UIControlStateNormal];
    [_lastBth setTintColor:UIColorFromRGB(0xC3C3C3)];
    //_endBth.backgroundColor=UIColorFromRGB(0x1993CF);

     [_endBth setTitle:@"退出考试" forState:UIControlStateNormal];
    [_endBth setTintColor:UIColorFromRGB(0x5A5656)];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"uuid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=question/getquestion" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    
       
        _optionsArray=[[[responseObject objectForKey:@"shiti"]objectForKey:[responseObject objectForKey:@"qarr"][0]]objectForKey:@"options"];
        
        
        _titleLabel.text=[NSString stringWithFormat:@"%d . %@" ,1,[[[responseObject objectForKey:@"shiti"]objectForKey:[responseObject objectForKey:@"qarr"][0]]objectForKey:@"title"]];
        
        _titleLabel.font=[UIFont systemFontOfSize:24];
        _titleLabel.lineBreakMode=UILineBreakModeCharacterWrap;
        _titleLabel.numberOfLines=0;

        _eid=[responseObject objectForKey:@"id"];
        _responseObject=responseObject;
        
        
        
        for(int i=0;i<20;i++)
        {
            
            //
            NSMutableDictionary * one = [[responseObject objectForKey:@"shiti"] objectForKey:[responseObject objectForKey:@"qarr"][i]];
        
            NSMutableDictionary * other = [[NSMutableDictionary alloc]init];
            
            [other setObject:[one objectForKey:@"title"] forKey:@"title"];
            NSMutableArray * options = [[NSMutableArray alloc]init];
            
            for(NSDictionary * optionone1 in [one objectForKey:@"options"])
            {
                NSMutableDictionary * optionone = [[NSMutableDictionary alloc]init];
                [optionone setObject:[optionone1 objectForKey:@"name"] forKey:@"name"];
                [optionone setObject:@"0" forKey:@"ischecked"];
                
                [options addObject: optionone];
            }
            [other setObject:options forKey:@"options"];
            
            [_shitiObject setObject:other forKey:[responseObject objectForKey:@"qarr"][i]];
            
        }
        
        
        NSLog(@"%@",_shitiObject);
        
        
//        [[[_shitiObject objectForKey:[responseObject objectForKey:@"qarr"][19]] objectForKey:@"options"][0] setObject:@"1" forKey:@"ischecked"];
//        
//        NSLog(@"%@",_shitiObject);
//        NSLog(@"%@",[responseObject objectForKey:@"qarr"][19]);
        _pagenow = 0;
        
        [_table reloadData];
         NSLog(@"%@",_optionsArray);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
    }];

    [self timer];
    
   
}

-(void)timer{
    
    timer = [[MZTimerLabel alloc] initWithLabel:_auctionTime andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:1200];
    timer.delegate=self;
    timer.resetTimerAfterFinish = YES;
    timer.timeFormat = @"mm:ss:SS";
    [timer startWithEndingBlock:^(NSTimeInterval countTime) {
        if(![timer counting]){
            
                
//                NSString *msg = [NSString stringWithFormat:@"Countdown of Example 7 finished!\nTime counted: %i seconds",(int)countTime];
              UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"时间到" delegate:self cancelButtonTitle:@"好的!" otherButtonTitles:nil];
                [alertView show];
            alertView.tag=1;
        
          
        }
       
        
        
    }];


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"sadas");
    if ((alertView.tag==1)) {
        
     [timer pause];
    if (buttonIndex==0) {
        

        [self performSegueWithIdentifier:@"goback" sender:self];
        }
    }
    
    if ((alertView.tag==2)) {
        
         [timer pause];
        if (buttonIndex==0) {
           

            
            //NSMutableDictionary * answerjson = [[NSMutableDictionary alloc]init];
            NSMutableString *answerjson = [[NSMutableString alloc]initWithString:@"{"];
            
            for(int i=0;i<20;i++)
            {
                
                //
                NSMutableDictionary * one = [_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][i]];
            
                int j = 0;
                
                NSMutableString * str = [[NSMutableString alloc] initWithString:@""];
                
                NSLog(@"%@",one);
                
                for(NSMutableDictionary * optionone in [one objectForKey:@"options"])
                {
                    if([[optionone objectForKey:@"ischecked"] isEqualToString:@"1"])
                    {
                        [str appendString:[NSString stringWithFormat:@"%d",j+1]];
                        
                    }
                    j++;
                }
                
                
                //[other setObject:options forKey:@"options"];
                [answerjson appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",[_responseObject objectForKey:@"qarr"][i],str]];
                
//                [answerjson setObject:str forKey:[_responseObject objectForKey:@"qarr"][i]];
                
            }
            answerjson=[NSMutableString stringWithFormat:@"%@",[answerjson substringToIndex:([answerjson length]-1)]];
            [answerjson appendString:@"}"];
            /*{"6":"234","11":"2","13":"1234","25":"1","31":"12","48":"34","53":"1234","59":"1","65":"1","70":"2","72":"123","86":"3","111":"2","117":"3","122":"2","140":"2","142":"4","146":"2","147":"1","157":"123"}
             */
            
           // http://192.168.3.105/kaixi/index.php?r=question/postanswer
           //eid: id   answerjson:answerjson
            //fen ok:==1
            
            NSLog(@"%@",answerjson);
            
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSDictionary *parameters =@{@"eid":_eid,@"answerjson":answerjson};
            
            NSLog(@"%@",parameters);
            
            
            NSLog(@"parm =  %@",parameters);
            NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
            NSString*string=[url objectForKey:@"string"];
            [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=question/postanswer" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                if([[responseObject objectForKey:@"ok"] intValue]==1)
                {
                    _fen=[responseObject objectForKey:@"fen"];
                    _totalnum=[responseObject objectForKey:@"totalnum"];
                    _paiming=[responseObject objectForKey:@"paiming"];
                    NSLog(@"%@,%@,%@",_fen,_totalnum,_paiming);
                    
                    if ([_fen intValue] >=80) {
                        
//                        ExamViewController*view=[[ExamViewController alloc]init];
//                        view.fent=[NSString stringWithFormat:@"%@",_fen];
//                        view.totalnumt=[NSString stringWithFormat:@"%@",_totalnum];
//                        view.paimingt=[NSString stringWithFormat:@"%@",_paiming];
//                        
//                        NSLog(@">>>>>>%@,%@,%@",view.fent,view.totalnumt,view.paimingt);
                        
                        [self performSegueWithIdentifier:@"pass" sender:self];

                    }
                    else{
                       

                    
                        [self performSegueWithIdentifier:@"fail" sender:self];

                    
                    }
                    
                }
            
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
             }];

            
            
            NSLog(@"%@",answerjson);
            
//            [self performSegueWithIdentifier:@"goback" sender:self];
        }
    }
    
    if ((alertView.tag==3)) {
        
         [timer pause];
        if (buttonIndex==0) {
           
            
                        [self performSegueWithIdentifier:@"goback" sender:self];
        }
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"pass"])
    {       ExamViewController*view =segue.destinationViewController;
        view.fent=[NSString stringWithFormat:@"%@",_fen];
        view.totalnumt=[NSString stringWithFormat:@"%@",_totalnum];
        view.paimingt=[NSString stringWithFormat:@"%@",_paiming];
        
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return _optionsArray.count ;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ExamTableViewCell *cell = (ExamTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ExamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray * arr = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
    
    cell.questionLabel.text =[NSString stringWithFormat:@"%@:   %@",arr[indexPath.row],[_optionsArray[indexPath.row] objectForKey:@"name"]];
    cell.questionLabel.font=[UIFont systemFontOfSize:24];
     cell.questionLabel.lineBreakMode=UILineBreakModeCharacterWrap;
     cell.questionLabel.numberOfLines=0;

    NSLog(@"%@",cell.questionLabel);
    
    
    if([[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"]isEqualToString:@"0" ])
    {
        cell.bingo.hidden=YES;
        
    }else{

        cell.bingo.hidden= NO;
    }
    
    //    if ([cell.update isSelected]) {
    //
    //        [cell.update setTitle:@"打开" forState:UIControlStateNormal];
    //NSUserDefaults *state = [NSUserDefaults standardUserDefaults];
    _table.backgroundColor=[UIColor clearColor];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.font=[UIFont systemFontOfSize:24];
    
     //cell.separatorColor = [UIColor clearColor];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     //NSIndexPath *indexPath2 = [tableView indexPathForSelectedRow];
    
    ExamTableViewCell *cell = (ExamTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
   
    long a=0;
    a=indexPath.row+1;
    NSNumber*c=[NSNumber numberWithLong:a];
   
    NSString*b=[NSString stringWithFormat:@"%@",c];
   
    
    //NSLog(@"%ld",(long)indexPath.row);
    
   
    //获取当前选中cell
 
    
    
    
    if([[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"]isEqualToString:@"0" ])
    {
        [[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][indexPath.row] setObject:@"1" forKey:@"ischecked"];
        cell.bingo.hidden=NO;
          [_daanArr addObject:b];
        
    }else{
        [[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][indexPath.row] setObject:@"0" forKey:@"ischecked"];
        cell.bingo.hidden= YES;
          [_daanArr removeObject:b];
    }
    //indexPath.row+1;
    NSLog(@"%@",[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"]);
    
    
//    if ([[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][indexPath.row]objectForKey:@"ischecked"] isEqualToString:@"1"]) {
//        
//        [_daanArr addObject:b];
//        
//    }
    
    
    
    NSLog(@"%@",_daanArr);
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)lastAction:(id)sender {
    
    NSLog(@"%ld",(long)_pagenow);
    
       if(_pagenow>0)
    {
        if (_pagenow<=1){
            
            
            [_lastBth setEnabled:NO];
            
            [_lastBth setTintColor:UIColorFromRGB(0xC3C3C3)];
            _lastBth.backgroundColor=[UIColor clearColor];
            
        }else
        {
            
            [_nextBth setEnabled:YES];
            [_nextBth setTintColor:UIColorFromRGB(0xFFFFFF)];
            _nextBth.backgroundColor=UIColorFromRGB(0x1993CF);
            
           
            
        }
        
        if(_pagenow>-1)
        {
             _pagenow--;
//            [_lastBth setEnabled:YES];
//            [_lastBth setTintColor:UIColorFromRGB(0xFFFFFF)];
//            _lastBth.backgroundColor=UIColorFromRGB(0x1993CF);
            
            
            _optionsArray=[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"options"];
            
            
            
            _titleLabel.text=[NSString stringWithFormat:@"%ld . %@" ,_pagenow+1,[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"title"]];
            [_table reloadData];
        }
        
        if(_pagenow!=19){
            _endBth.titleLabel.text=@"退出考试";
            
        }
    }
    
    
    
    
}

- (IBAction)nextAction:(id)sender {
    
    int j =0;
    for (int i =0; i<[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"] count] ; i++) {
        if([[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][i]objectForKey:@"ischecked"]isEqualToString:@"1" ])
        {
            j=1;
        }
    }
    if(j==0)
    {
        
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有选择答案" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
    }else
    {
        
        
        
        
      //  [_daanArr removeAllObjects];
        
        if(_pagenow<19)
        {
            if (_pagenow>=18){
                
                [_nextBth setEnabled:NO];
                
                [_nextBth setTintColor:UIColorFromRGB(0xC3C3C3)];
                _nextBth.backgroundColor=[UIColor clearColor];
                
            }else
            {
                [_lastBth setEnabled:YES];
                [_lastBth setTintColor:UIColorFromRGB(0xFFFFFF)];
                _lastBth.backgroundColor=UIColorFromRGB(0x1993CF);
                
            }
            _pagenow++;
            
            
            
            _optionsArray=[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"options"];
            
            
            NSString*str=[[NSString alloc] init];
            
            str=[[_responseObject objectForKey:@"rightjson"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow-1]];
            
            NSLog(@"%@",str);
            
            for (int i = 0; i < str.length; i ++) {
                NSRange range;
                range.location = i;
                range.length = 1;
                NSString *tempString = [str substringWithRange:range];
                [_daanArr2 addObject:tempString];
            }
            NSLog(@"%@",_daanArr2);
            
            
            NSArray *result = [_daanArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                
                //NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
                
                return [obj1 compare:obj2]; //升序
                
            }];
            
            NSLog(@"result=%@",result);
            
            
            NSMutableArray*arr=[[NSMutableArray alloc] init];
            
            if (![result isEqualToArray:_daanArr2]) {
                NSLog(@"错误的");
                
                NSLog(@"%@",_daanArr2);
                
                for (NSString*str in _daanArr2) {
                    
                    if ([str isEqualToString:@"1"]) {
                        [arr addObject:@"A"];
                    }
                    if ([str isEqualToString:@"2"]) {
                        [arr addObject:@"B"];
                    }
                    if ([str isEqualToString:@"3"]) {
                        [arr addObject:@"C"];
                    }
                    if ([str isEqualToString:@"4"]) {
                        [arr addObject:@"D"];
                    }
                    if ([str isEqualToString:@"5"]) {
                        [arr addObject:@"E"];
                    }
                    if ([str isEqualToString:@"6"]) {
                        [arr addObject:@"F"];
                    }
                    
                }
                
                NSLog(@"%@",arr);
                NSString*str2=[[NSString alloc] init];
                if (arr.count==1) {
                    
                    str2=arr.lastObject;
                }
                else{
                str2= [arr  componentsJoinedByString:@","];
                
                }
                
                                  // something
                    _tishiLb.hidden=NO;
                //_tishiLb.text=[@"回答错误,正确答案是" stringByAppendingString:str2];
                _tishiLb.text=@"回答错误";
                [_tishiLb setTextColor:UIColorFromRGB(0x1993CF)];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                    _tishiLb.hidden=YES;
                    
                    
                    _titleLabel.text=[NSString stringWithFormat:@"%ld . %@" ,_pagenow+1,[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"title"]];
                    
                    
                    [_daanArr removeAllObjects];
                    [_daanArr2 removeAllObjects];
                    
                    
                    [_table reloadData];

                    
                });//这句话的意思
          
           
                
            }
            else{
            
                NSLog(@"正确的");
                
                _tishiLb.hidden=NO;
                _tishiLb.text=@"回答正确";
                
                 [_tishiLb setTextColor:UIColorFromRGB(0x1993CF)];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                    _tishiLb.hidden=YES;
                    
                    
                    _titleLabel.text=[NSString stringWithFormat:@"%ld . %@" ,_pagenow+1,[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"title"]];
                    
                    
                    [_daanArr removeAllObjects];
                    [_daanArr2 removeAllObjects];
                    
                    
                    [_table reloadData];

                });//这句话的意思是1.5秒后，把label移出视图

                //设置动画
              
            }
            
        
            
            
            
            
            
            
            
            
            
        }
        if (_pagenow==19) {
            
            _endBth.titleLabel.text=@"完成考试";
        }
    }
    

    
    
    
    
}
-(void)thred{
    
  
    
    [NSThread sleepForTimeInterval:3.0];
    _tishiLb.hidden=YES;
    
    
}
- (IBAction)endAction:(id)sender {
    
    
    NSLog(@"%@",_optionsArray);
    
    if (_pagenow==19) {
        int j =0;
        for (int i =0; i<[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"] count] ; i++) {
            if([[[[_shitiObject objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]] objectForKey:@"options"][i]objectForKey:@"ischecked"]isEqualToString:@"1" ])
            {
                j=1;
            }
        }
        if(j==0)
        {
            
            UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有选择答案" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
        }else
        {
            _endBth.titleLabel.text=@"完成考试";
            [_endBth setTintColor:UIColorFromRGB(0xFFFFFF)];
            _endBth.backgroundColor=UIColorFromRGB(0x1993CF);
            
            
            
            NSString*str=[[NSString alloc] init];
            
            str=[[_responseObject objectForKey:@"rightjson"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow-1]];
            
            NSLog(@"%@",str);
            
            for (int i = 0; i < str.length; i ++) {
                NSRange range;
                range.location = i;
                range.length = 1;
                NSString *tempString = [str substringWithRange:range];
                [_daanArr2 addObject:tempString];
            }
            NSLog(@"%@",_daanArr2);
            
            
            NSArray *result = [_daanArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                
                //NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
                
                return [obj1 compare:obj2]; //升序
                
            }];
            
            NSLog(@"result=%@",result);
            
            
            NSMutableArray*arr=[[NSMutableArray alloc] init];
            
            if (![result isEqualToArray:_daanArr2]) {
                NSLog(@"错误的");
                
                NSLog(@"%@",_daanArr2);
                
                for (NSString*str in _daanArr2) {
                    
                    if ([str isEqualToString:@"1"]) {
                        [arr addObject:@"A"];
                    }
                    if ([str isEqualToString:@"2"]) {
                        [arr addObject:@"B"];
                    }
                    if ([str isEqualToString:@"3"]) {
                        [arr addObject:@"C"];
                    }
                    if ([str isEqualToString:@"4"]) {
                        [arr addObject:@"D"];
                    }
                    if ([str isEqualToString:@"5"]) {
                        [arr addObject:@"E"];
                    }
                    if ([str isEqualToString:@"6"]) {
                        [arr addObject:@"F"];
                    }
                    
                }
                
                NSLog(@"%@",arr);
                NSString*str2=[[NSString alloc] init];
                if (arr.count==1) {
                    
                    str2=arr.lastObject;
                }
                else{
                    str2= [arr  componentsJoinedByString:@","];
                    
                }
                
                // something
                _tishiLb.hidden=NO;
                //_tishiLb.text=[@"回答错误,正确答案是" stringByAppendingString:str2];
                _tishiLb.text=@"回答错误";
                
                [_tishiLb setTextColor:UIColorFromRGB(0x1993CF)];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                    _tishiLb.hidden=YES;
                    
                    
                    _titleLabel.text=[NSString stringWithFormat:@"%ld . %@" ,_pagenow+1,[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"title"]];
                    
                    
                    [_daanArr removeAllObjects];
                    [_daanArr2 removeAllObjects];
                    
                    
                   // [_table reloadData];
                    
                    
                });//这句话的意思
                
                
                
            }
            else{
                
                NSLog(@"正确的");
                
                _tishiLb.hidden=NO;
                _tishiLb.text=@"回答正确";
                
                [_tishiLb setTextColor:UIColorFromRGB(0x1993CF)];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                    _tishiLb.hidden=YES;
                    
                    
                    _titleLabel.text=[NSString stringWithFormat:@"%ld . %@" ,_pagenow+1,[[[_responseObject objectForKey:@"shiti"]objectForKey:[_responseObject objectForKey:@"qarr"][_pagenow]]objectForKey:@"title"]];
                    
                    
                    [_daanArr removeAllObjects];
                    [_daanArr2 removeAllObjects];
                    
                    
                  //  [_table reloadData];
                    
                });//这句话的意思是1.5秒后，把label移出视图
                
                //设置动画
                
            }

            
            
            
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要提交吗？" delegate:self cancelButtonTitle:@"提交" otherButtonTitles:@"取消",nil];
            [alertView show];
            alertView.tag=2;
            
        }
    }
    
    //                NSString *msg = [NSString stringWithFormat:@"Countdown of Example 7 finished!\nTime counted: %i seconds",(int)countTime];
    else{
        //_endBth.titleLabel.text=@"退出考试";
        [_endBth setTintColor:UIColorFromRGB(0xFFFFFF)];
        _endBth.backgroundColor=UIColorFromRGB(0x1993CF);
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出考试吗？" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"取消",nil];
        [alertView show];
        alertView.tag=3;
        
    }
    

    
}
@end
