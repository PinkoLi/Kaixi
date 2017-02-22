//
//  SurveyViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/26.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "SurveyViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "SurveyTableViewCell.h"

#import "LXF_OpenUDID.h"
@interface SurveyViewController ()

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _optionsArray = [[NSMutableArray alloc]init];
    _responseObject = [[NSMutableArray alloc]init];
    
    _pagenow=0;
    if([_tag isEqualToString:@"1"]){
    NSArray*options=[NSArray arrayWithObjects:@"中枢化学感受器敏感性低，对CO2 升高的反应性降低，并抑制肺牵张反射",@"低氧刺激通过外周外学感受器对呼吸中枢的兴奋作用不足以克服低氧对中枢的直接抑制作用", nil ];
     NSArray*other=[NSArray arrayWithObjects:@"正确答案: A、B\n胚胎发育第20~32周，胚胎生发层基质主要提供胶质细胞。此时，早产儿大脑的突触连接、树突分枝及髓鞘的数量均明显少于足月儿，呼吸中枢远未发育成熟",@"刘利梅等.早产儿脑发育的影响因素及干预的研究进展.安徽医药,2009;13(8)：975-976 田欣等.早产儿呼吸暂停发病机制的研究进展.重庆医学.2010;39(17):2387-2389", nil ];
    NSDictionary*dict=[NSDictionary dictionaryWithObjectsAndKeys:@"早产儿呼吸中枢发育不成熟，因而存在呼吸运动调节障碍：" ,@"title",options,@"options",other,@"other",nil];
    
    
    NSArray*options2=[NSArray arrayWithObjects:@"≤ 34周",@"≤ 30周", nil ];
    NSArray*other2=[NSArray arrayWithObjects:@"正确答案: A \n国外报道，胎龄34周以下的早产儿发病率高达85% 。国内近年来报告，呼吸暂停在早产儿的发病率约为23%，在极低出生体重儿发病率高达90% ",@"Barrington K, Finer N. The natural history of the appearance of apnea of prematurity. Pediatr Res 1991;29:372-375. 赵婧等.早产儿呼吸暂停诊治进展.临床儿科杂志.2012;30（3）:291-294", nil ];
    NSDictionary*dict2=[NSDictionary dictionaryWithObjectsAndKeys:@"AOP发病率85%见于以下哪个胎龄组：" ,@"title",options2,@"options",other2,@"other",nil];
    
    NSArray*options3=[NSArray arrayWithObjects:@"反复间歇性缺氧导致早产儿视网膜病变，神经发育障碍",@"缺血缺氧会导致脑瘫、脑室周围白质软化和高频性耳聋", nil ];
    NSArray*other3=[NSArray arrayWithObjects:@"正确答案: A、B\n呼吸暂停如不及时处理，可引起脑损害，对小儿多器官生长发育均有影响。",@"毛健.早产儿呼吸暂停与间歇性缺氧.中国小儿急救医学.2014;21(10):617-621 孙眉月.极低出生体重儿并发呼吸暂停.小儿急救医学.2002;9(1):1-2", nil ];
    NSDictionary*dict3=[NSDictionary dictionaryWithObjectsAndKeys:@"反复发作的AOP会损害患儿的生长发育：" ,@"title",options3,@"options",other3,@"other",nil];
    NSLog(@"%@,%@,%@",dict,dict2,dict3);


        _responseObject = [NSMutableArray arrayWithObjects:dict,dict2,dict3, nil];
        NSLog(@"？？？？？？？？？？？？？？%@",_responseObject);
    }
    
    if([_tag isEqualToString:@"2"]){
        NSArray*options=[NSArray arrayWithObjects:@"中控制感染",@"辅助通气支持",@"兴奋呼吸中枢", nil ];
        NSArray*other=[NSArray arrayWithObjects:@"正确答案 C\n对于早产儿,特别是极不成熟的早产儿,AOP可能是呼吸调控发育不成熟的生理表现,其中枢机制主要包括:中枢化学敏感性降低,缺氧对通⽓气反应的抑制,抑制性神经递质上调(GABA,腺苷)及星形胶质发育受损。因此,治疗AOP的核心在于兴奋呼吸中枢",@"⽑健.早产儿呼吸暂停与间歇性缺氧.中国⼩儿急救医学.2014;21(10):617-621", nil ];
        NSDictionary*dict=[NSDictionary dictionaryWithObjectsAndKeys:@"以下哪⼀点是AOP治疗的核心?" ,@"title",options,@"options",other,@"other",nil];
        
        
        NSArray*options2=[NSArray arrayWithObjects:@"枸橼酸咖啡因",@"CPAP+枸橼酸咖啡因",@"CPAP",@"机械通气", nil ];
        NSArray*other2=[NSArray arrayWithObjects:@"正确答案: A \n一旦发现患⼉发生呼吸暂停,应⽴即进行托背、摇床、弹⾜底等刺激呼吸。呼吸暂停反复发作者,应给药物治疗。枸橼酸咖啡因是目前唯一具有AOP适应症的治疗药物。对频发的混合性呼吸暂停,药物治疗后仍然发作者,或者单纯的阻塞性呼吸暂停,可给予CPAP。经上述处理后,呼吸暂停仍频繁发⽣者需用⽓管插管和机械通气,呼吸机参数一般不需要很⾼。",@"陈超.早产儿呼吸系统的临床问题.中国实⽤儿科杂志.2000;15(12):714-716", nil ];
        NSDictionary*dict2=[NSDictionary dictionaryWithObjectsAndKeys:@"在治疗AOP时, 如果单纯物理刺激无效,您会⾸选哪种治疗方式?" ,@"title",options2,@"options",other2,@"other",nil];
        
        NSArray*options3=[NSArray arrayWithObjects:@"氨茶碱",@"枸橼酸咖啡因",@"纳络酮", nil ];
        NSArray*other3=[NSArray arrayWithObjects:@"正确答案:B\n咖啡因于1999年被美国FDA批准上市,倍优诺于2013年被CFDA批准⽤用于AOP治疗,是⽬前中国唯⼀具有AOP治疗适应症的药物。",@" ", nil ];
        NSDictionary*dict3=[NSDictionary dictionaryWithObjectsAndKeys:@"以下哪个药物是唯⼀具有AOP治疗适应症的药物?" ,@"title",options3,@"options",other3,@"other",nil];
        NSLog(@"%@,%@,%@",dict,dict2,dict3);
        
        
        _responseObject = [NSMutableArray arrayWithObjects:dict,dict2,dict3, nil];
        NSLog(@"？？？？？？？？？？？？？？%@",_responseObject);
    }

    
    if([_tag isEqualToString:@"3"]){
        NSArray*options=[NSArray arrayWithObjects:@"咖啡因治疗显著降低BPD和PDA的发生率",@"咖啡因治疗具有中长期神经保护作用",@"咖啡因治疗可以缩短机械通气时间达一周", nil ];
        NSArray*other=[NSArray arrayWithObjects:@"正确答案: A,B,C\n",@"1- Schmidt B, et al . Caffeine Therapy for Apnea of Prematurity. The new England journal of medicine,2006 :2112-2121.2- Schmidt B,et al . Long-Term Effects of Caffeine Therapy for Apnea of Prematurity. The new England journal of medicine,2007:1893-190 ", nil ];
        NSDictionary*dict=[NSDictionary dictionaryWithObjectsAndKeys:@"以下哪些是在CAP（咖啡因治疗早产儿AOP）研究中所观察到的？" ,@"title",options,@"options",other,@"other",nil];
        
        
        NSArray*options2=[NSArray arrayWithObjects:@"机械通气时间",@"动脉导管未闭", @"贫血",@"肺透明膜病",nil ];
        NSArray*other2=[NSArray arrayWithObjects:@"正确答案: A,B \n ",@"1- 早产儿支气管肺发育不良调查协作组. 中华儿科杂志2011;49(9):655-662. 2- Schmidt B, et al . Caffeine Therapy for Apnea of Prematurity. The new England journal of medicine,2006 :2112-2121.", nil ];
        NSDictionary*dict2=[NSDictionary dictionaryWithObjectsAndKeys:@"以下哪些BPD的高危因素，可以通过咖啡因治疗改善？" ,@"title",options2,@"options",other2,@"other",nil];
        
        NSArray*options3=[NSArray arrayWithObjects:@"发现AOP后使用，用药至呼吸暂停不发生5-7天（推荐至少持续用药到胎龄34周）",@"胎龄34周以下需要辅助通气支持的早产儿应在出生3天内开始使用，至少用药至呼吸暂停不发生5~7天",@"机械通气患儿在撤机前24小时使用", nil ];
        NSArray*other3=[NSArray arrayWithObjects:@"正确答案: A、B\n",@"1- 倍优诺说明书 2- Schmidt B, et al . Caffeine Therapy for Apnea of Prematurity. The new England journal of medicine,2006 :2112-2121.", nil ];
        NSDictionary*dict3=[NSDictionary dictionaryWithObjectsAndKeys:@"倍优诺的治疗方案是：" ,@"title",options3,@"options",other3,@"other",nil];
        NSLog(@"%@,%@,%@",dict,dict2,dict3);
        
        
        _responseObject = [NSMutableArray arrayWithObjects:dict,dict2,dict3, nil];
        NSLog(@"？？？？？？？？？？？？？？%@",_responseObject);
    }

    


       // NSLog(@"%@",[[responseObject objectForKey:@"shiti"]objectForKey:@"title"]);
        _questionLb.text=[_responseObject[0] objectForKey:@"title"];
        _questionLb.lineBreakMode = UILineBreakModeWordWrap;
        _questionLb.numberOfLines = 0;
        _optionsArray=[_responseObject[0]objectForKey:@"options"];
        _otherLb.text=[_responseObject[0]objectForKey:@"other"][0];
        _otherLb.lineBreakMode=UILineBreakModeCharacterWrap;
        _otherLb.numberOfLines=0;
        _otherLb2.lineBreakMode=UILineBreakModeCharacterWrap;
        _otherLb2.numberOfLines=0;
        
        
        NSLog(@"%@",_questionLb.text);
        
        
        _shitiObject = [[NSMutableArray alloc]init];
        
        for(int i=0;i<3;i++)
        {
            NSMutableArray * one2 = [[NSMutableArray alloc]init];
            for(NSDictionary * optionone1 in [_responseObject[i] objectForKey:@"options"])
            {
                NSMutableDictionary * optionone = [[NSMutableDictionary alloc]init];
                [optionone setObject:@"0" forKey:@"ischecked"];
                
                [one2 addObject: optionone];
            }
            
            [_shitiObject addObject: one2];
        }
        

        [_table reloadData];
//    }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"Error: %@", error);
//          }];
    _imageView.hidden=YES;
    _nextBth.hidden=YES;
    _otherLb.hidden=YES;
    _otherLb2.hidden=YES;
    
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
    SurveyTableViewCell *cell = (SurveyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SurveyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray * arr = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
    
    cell.options.text =[NSString stringWithFormat:@"%@:   %@",arr[indexPath.row],_optionsArray[indexPath.row] ];
    
    
    //    if ([cell.update isSelected]) {
    //
    //        [cell.update setTitle:@"打开" forState:UIControlStateNormal];
    //NSUserDefaults *state = [NSUserDefaults standardUserDefaults];
    _table.backgroundColor=[UIColor clearColor];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.options.lineBreakMode = UILineBreakModeWordWrap;
     cell.options.numberOfLines = 0;
    cell.bingo.hidden = YES;
    
//    //自适应高度
//    CGRect txtFrame =  cell.options.frame;
//    
//    cell.options.frame = CGRectMake(10, 100, 300,
//                             txtFrame.size.height =[ cell.options.text boundingRectWithSize:
//                                                    CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
//                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys cell.options.font,NSFontAttributeName, nil] context:nil].size.height);
//    cell.options.frame = CGRectMake(10, 100, 300, txtFrame.size.height);
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        
//        for(int i = 0;i<[_shitiObject[_pagenow] count];i++)
//        {
//            [_shitiObject[_pagenow][i]setObject:@"0" forKey:@"ischecked"];
//            
//        }
//        
//        [_shitiObject[_pagenow][indexPath.row]setObject:@"1" forKey:@"ischecked"];
    
    
    SurveyTableViewCell *cell = (SurveyTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    if(cell.bingo.hidden==YES)
    {
        
        cell.bingo.hidden=NO;
    }else
    {
        cell.bingo.hidden=YES;
    }

//    NSLog(@"%@",[_shitiObject[_pagenow][indexPath.row]objectForKey:@"ischecked"]);

}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)nextAction:(id)sender {
    
    int j=0;
    for(int i = 0;i<[_shitiObject[_pagenow] count];i++)
    {
        NSIndexPath * indexPath= [NSIndexPath indexPathForRow:i inSection:0];
        
        SurveyTableViewCell *cell = (SurveyTableViewCell *) [_table cellForRowAtIndexPath:indexPath];
        
        if(cell.bingo.hidden==NO)
        {
            j=1;
        }
        
//        if([[_shitiObject[_pagenow][i] objectForKey:@"ischecked"]isEqualToString:@"1"])
//        {
//            j=1;
//        }
//        [_shitiObject[_pagenow][i]setObject:@"0" forKey:@"ischecked"];
        
    }
    if(j==1)
    {
        _imageView.hidden=NO;
        _nextBth.hidden=NO;
        _otherLb.hidden=NO;
        _otherLb2.hidden=NO;
        if(_pagenow==2)
        {
            _nextBth.titleLabel.text = @"完成";
        }
        
        
        
        
        _otherLb.text = [_responseObject[_pagenow] objectForKey:@"other"][0];
        _otherLb2.text = [_responseObject[_pagenow] objectForKey:@"other"][1];
        
    }else
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择问题答案" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];

    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        
        
        if (buttonIndex==0) {
            

        }
    
    }

}
- (IBAction)nextBth:(id)sender {
    
    
    
    
    if(_pagenow>=2)
    {
//        _imageView.hidden=YES;
//        _nextBth.hidden=YES;
//        _otherLb.hidden=YES;
//        _otherLb2.hidden=YES;
        
        int i1 = 0;
        int i2 = 0;
        int i3 = 0;
        
        for(int i = 0;i<[_shitiObject[0] count];i++)
        {
            if([[_shitiObject[0][i]objectForKey:@"ischecked"]isEqualToString:@"1" ])
            {
                i1=i+1;
            }
                
        }
        
        for(int i = 0;i<[_shitiObject[1] count];i++)
        {
            if([[_shitiObject[1][i]objectForKey:@"ischecked"]isEqualToString:@"1" ])
            {
                i2=i+1;
            }
            
        }
        
        for(int i = 0;i<[_shitiObject[2] count];i++)
        {
            if([[_shitiObject[2][i]objectForKey:@"ischecked"]isEqualToString:@"1" ])
            {
                i3=i+1;
            }
            
        }
        
        NSString * answerjson = [NSString stringWithFormat:@"%d,%d,%d",i1,i2,i3];
        
        
        
//        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
//        NSString*string=[url objectForKey:@"string"];
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
//        //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//        
//            NSString *openUDID = [LXF_OpenUDID value];
//            NSDictionary *parameters =@{@"udid":openUDID,@"answerjson":answerjson};
//        
//        
//        // NSLog(@"parm =  %@",parameters);
//        
//        
//        [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=aop/postmystr" ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"%@",responseObject);
        
            
            [self performSegueWithIdentifier:@"goback" sender:self];
            
//        }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  NSLog(@"Error: %@", error);
//              }];
        
    }else
    {
        _imageView.hidden=YES;
        _nextBth.hidden=YES;
        _otherLb.hidden=YES;
        _otherLb2.hidden=YES;
        
        _pagenow++;
        _optionsArray=[(_responseObject [_pagenow]) objectForKey:@"options" ];
         _questionLb.text=[_responseObject[_pagenow] objectForKey:@"title"];
        
        [_table reloadData];
    }
}
@end
