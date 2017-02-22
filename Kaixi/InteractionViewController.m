//
//  PolicyViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/20.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "InteractionViewController.h"
#import "InteractionInfo.h"
#import "InteractionList.h"
#import "InteractionLeftTableViewCell.h"
#import "InteractionRightTableViewCellTableViewCell.h"
#import "ZipArchive.h"

#import "AFHTTPRequestOperationManager.h"
#import "InfomationViewController.h"
#import "LXF_OpenUDID.h"
@interface InteractionViewController ()

@end

@implementation InteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftTable.backgroundColor=[UIColor clearColor];
     _rightTable.backgroundColor=[UIColor clearColor];
    _rightTable.separatorColor=[UIColor clearColor];
    _leftTable.separatorColor=[UIColor clearColor];
    
    //
//                    InteractionList *person21 = [InteractionList MR_createEntity];
//                    person21.id= [NSNumber numberWithInt:1] ;
//                    person21.name = @"产品知识";
//    
//                    InteractionList *person22 = [InteractionList MR_createEntity];
//                    person22.id= [NSNumber numberWithInt:2] ;
//                    person22.name = @"医学知识";
//    
//                    InteractionList *person23 = [InteractionList MR_createEntity];
//                    person23.id= [NSNumber numberWithInt:3] ;
//                    person23.name = @"人事政策";
//    
//                    InteractionList *person24 = [InteractionList MR_createEntity];
//                    person24.id= [NSNumber numberWithInt:4] ;
//                    person24.name = @"财务政策";
//    
//                    InteractionList *person25 = [InteractionList MR_createEntity];
//                    person25.id= [NSNumber numberWithInt:5] ;
//                    person25.name = @"合规政策";
//    
//                    InteractionList *person26 = [InteractionList MR_createEntity];
//                    person26.id= [NSNumber numberWithInt:6] ;
//                    person26.name = @"我的提问";
//    
//                    InteractionList *person27 = [InteractionList MR_createEntity];
//                    person27.id= [NSNumber numberWithInt:7] ;
//                    person27.name = @"我要提问";
//    
//                    InteractionInfo * person111 =[InteractionInfo MR_createEntity];
//                    person111.iid =[NSNumber numberWithInt:1] ;
//                    person111.name =@"详情1";
//    
//                    InteractionInfo * person222 =[InteractionInfo MR_createEntity];
//                    person222.iid =[NSNumber numberWithInt:2] ;
//                    person222.name =@"详情2";
//    
//                    InteractionInfo * person333 =[InteractionInfo MR_createEntity];
//                    person333.iid =[NSNumber numberWithInt:3] ;
//                    person333.name =@"详情3";
//    
//                   [[NSManagedObjectContext MR_defaultContext] MR_save];
    
    // Do any additional setup after loading the view.
    _interactionListArray=[[NSMutableArray alloc]init];
    _interactionInfoArray=[NSMutableArray arrayWithObjects:@"学术信息",@"凯西政策",@"我的问题",@"我要提问" ,nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
   
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=jhlist/jhalllist"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
        
        
        _interactionListArray = [responseObject objectForKey:@"arr"];
        [_rightTable reloadData];
        
        //                _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAll]];
        //                [_tableKnowledge reloadData];
        
        
        //[Knowledge MR_numberOfEntities];
        //        NSLog(@"%@", [Knowledge MR_numberOfEntities]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([tableView isEqual:_leftTable]) {
        return _interactionInfoArray.count;
    }
    else if ([tableView isEqual:_rightTable]) {
        return _interactionListArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_leftTable]){
        return 1;
        
    }else if ([tableView isEqual:_rightTable]) {
        
        return 1;
    }
    
    return -1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_leftTable]) {
        
        
        static NSString *indentifier = @"leftCell";
        InteractionLeftTableViewCell *cell = (InteractionLeftTableViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil) {
            cell = [[InteractionLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        
        cell.title.text= _interactionInfoArray[indexPath.row];
//        cell.title.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
       
        
        
        cell.title.backgroundColor = [UIColor clearColor];
        cell.title.textColor = [UIColor blackColor];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
    else if ([tableView isEqual:_rightTable]) {
        
        static NSString *CellIdentifier = @"rightCell";
        InteractionRightTableViewCellTableViewCell *cell = (InteractionRightTableViewCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[InteractionRightTableViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
       // InteractionInfo * info = _interactionInfoArray[indexPath.row];
        NSLog(@"%ld",(long)indexPath.row);
       // NSLog(@"%d",indexPath.section);


        cell.title.text = [_interactionListArray[indexPath.row] objectForKey:@"content"];
//         cell.title.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:22];
//        cell.title.lineBreakMode=UILineBreakModeCharacterWrap;
//       cell.title.numberOfLines=0;
        
        
        cell.jiluLb.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row ];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
        
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTable]){
        
        if (indexPath.row==3) {
           
            
            [self performSegueWithIdentifier:@"tiwen" sender:self];
        }
        else if(indexPath.row==2){
        
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
            NSString*string=[url objectForKey:@"string"];
            
            NSString *openUDID = [LXF_OpenUDID value];

            NSDictionary *parameters =@{@"udid":openUDID};
           
            
            [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=jhlist/jhmylist"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                //        _knowledgeArray = responseObject;
                
                if ([[responseObject objectForKey:@"arr"]count]==0) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未提过问题或您的问题尚未被采纳" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                    
                    
                    [alert show];
                    
                }

                _interactionListArray = [responseObject objectForKey:@"arr"];
                [_rightTable reloadData];
                
                //                _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAll]];
                //                [_tableKnowledge reloadData];
                
                
                //[Knowledge MR_numberOfEntities];
                //        NSLog(@"%@", [Knowledge MR_numberOfEntities]);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
        
        
        }
        
        else{
        
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
            NSString*string=[url objectForKey:@"string"];
            NSDictionary *parameters =@{@"tag":[NSString stringWithFormat:@"%ld",(long)indexPath.row+1 ]};
            [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=jhlist/jhlist"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSLog(@"JSON: %@", responseObject);
                //        _knowledgeArray = responseObject;
                if ([[responseObject objectForKey:@"arr"]count]==0) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前还没有人提问" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                    
                    
                    [alert show];

                }
                
                _interactionListArray = [responseObject objectForKey:@"arr"];
                [_rightTable reloadData];
                
//                _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAll]];
//                [_tableKnowledge reloadData];
                
                
                //[Knowledge MR_numberOfEntities];
                //        NSLog(@"%@", [Knowledge MR_numberOfEntities]);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];

        
        }
        //    _currentRow = indexPath.row;
        //    NSArray *personsAgeEuqals25   = [Knowledge MR_findByAttribute:@"kid" withValue:[NSNumber numberWithInt:1]];
        
        
        
    }
//    if ([tableView isEqual:_rightTable]){
//        
//      
//            
//            
//            [self performSegueWithIdentifier:@"info" sender:self];
//        
//        
//        
//        //    _currentRow = indexPath.row;
//        //    NSArray *personsAgeEuqals25   = [Knowledge MR_findByAttribute:@"kid" withValue:[NSNumber numberWithInt:1]];
//        
//        
//        
//    }
    

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    InteractionRightTableViewCellTableViewCell *cell = (InteractionRightTableViewCellTableViewCell *) sender;
    //NSLog(@"%@",sender);
    if ([segue.identifier isEqualToString:@"goToInfo"]) {
        
        
        InfomationViewController* view = segue.destinationViewController;
        NSLog(@"%@",[_interactionListArray[[cell.jiluLb.text intValue]] objectForKey:@"content"]);
        view.upstr = [_interactionListArray[[cell.jiluLb.text intValue]] objectForKey:@"content"];
        
        //NSLog(@"%@",[_interactionListArray[[cell.jiluLb.text intValue]] objectForKey:@"daan"]);
        
        if([[_interactionListArray[[cell.jiluLb.text intValue]] objectForKey:@"daan"] isKindOfClass:[NSNull class]])
        {
            view.downstr= [ NSMutableString stringWithString:@"未通过"];
            NSLog(@"%@",view.downstr);
        }
        else
        {
            view.downstr=  [_interactionListArray[[cell.jiluLb.text intValue]] objectForKey:@"daan"];
        }
        
        
    }


}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
