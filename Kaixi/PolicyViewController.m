//
//  PolicyViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/20.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "PolicyViewController.h"
#import "PolocyList.h"
#import "PolocyInfo.h"
#import "PolicyTableViewCell.h"
#import "PolicyLeftTableViewCell.h"
#import "ZipArchive.h"
#import "LXF_OpenUDID.h"
#import "StudyImageViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface PolicyViewController ()

@end

@implementation PolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//                PolocyList *person21 = [PolocyList MR_createEntity];
//                person21.id= [NSNumber numberWithInt:1] ;
//                person21.name = @"人事";
//    
//                PolocyList *person22 = [PolocyList MR_createEntity];
//                person22.id= [NSNumber numberWithInt:2] ;
//                person22.name = @"行政";
//    
//                PolocyList *person23 = [PolocyList MR_createEntity];
//                person23.id= [NSNumber numberWithInt:3] ;
//                person23.name = @"合规";
//    
//                PolocyInfo * person111 =[PolocyInfo MR_createEntity];
//                person111.pid =[NSNumber numberWithInt:1] ;
//    
//                person111.name =@"详情1";
//                PolocyInfo * person222 =[PolocyInfo MR_createEntity];
//                person222.pid =[NSNumber numberWithInt:2] ;
//    
//                person222.name =@"详情2";
//                PolocyInfo * person333 =[PolocyInfo MR_createEntity];
//                person333.pid =[NSNumber numberWithInt:3] ;
//    
//                person333.name =@"详情3";

//               [[NSManagedObjectContext MR_defaultContext] MR_save];

    // Do any additional setup after loading the view.
    _tag2=@"3";
    _leftTable.backgroundColor=[UIColor clearColor];
    _rightTable.backgroundColor=[UIColor clearColor];
    _rightTable.separatorColor=[UIColor clearColor];
    _leftTable.separatorColor=[UIColor clearColor];
    _policyInfoArray= [[NSMutableArray alloc]init];
    _images= [[NSMutableArray alloc]init];
    PolocyList *person1 = [PolocyList MR_createEntity];
    person1.id= [NSNumber numberWithInt:1] ;
    person1.name = @"人事政策";
    
    PolocyList *person3 = [PolocyList MR_createEntity];
    person3.id= [NSNumber numberWithInt:2] ;
    person3.name = @"合规政策";
  
    PolocyList *person2 = [PolocyList MR_createEntity];
    person2.id= [NSNumber numberWithInt:3] ;
    person2.name = @"其他政策";
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=yxknowledge/xzknowledgelist"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
        
        for (NSDictionary*k in responseObject) {
            
            PolocyInfo *kOne=[PolocyInfo MR_findFirstByAttribute:@"id" withValue:[k objectForKey:@"id"]];
            if (kOne) {
                kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                //kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mkid"]intValue]];
                kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
                
            }
            else{
                kOne = [PolocyInfo MR_createEntity];
                kOne.id=[NSNumber numberWithInt:[[k objectForKey:@"id"]intValue]];
                //  kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mpid"]intValue]];
                kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                kOne.hasdownload = @"0";
                kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
            }
            
            
        }
        
        _policyInfoArray = [NSMutableArray arrayWithArray:[PolocyInfo MR_findAll]];
        [_rightTable reloadData];
        
        
        //[Knowledge MR_numberOfEntities];
        NSLog(@"%@", [PolocyInfo MR_numberOfEntities]);
        
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
        return 1;
    }
    else if ([tableView isEqual:_rightTable]) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_leftTable]){
        return 3;
        
    }else if ([tableView isEqual:_rightTable]) {
        
        return _policyInfoArray.count;
    }
    
    return -1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"asdasfsadasfasf");
    
    if ([tableView isEqual:_leftTable]) {
        
        
        static NSString *indentifier = @"leftCell";
        PolicyLeftTableViewCell *cell = (PolicyLeftTableViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil) {
            cell = [[PolicyLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        PolocyList *kindone=[PolocyList MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLong:indexPath.section+1]];
      
        cell.title.text= kindone.name;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.textAlignment= UITextAlignmentCenter;
        
        return cell;
    }
    else if ([tableView isEqual:_rightTable]) {
        
         NSDictionary * kindarr = [NSDictionary dictionaryWithObjectsAndKeys:@"人事政策",@"1",@"其他政策",@"2",@"合规政策",@"3", nil];
        static NSString *CellIdentifier = @"rightCell";
        PolicyTableViewCell *cell = (PolicyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[PolicyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        PolocyInfo * knowledge = _policyInfoArray[indexPath.section];
        if([knowledge.hasdownload isEqualToString:@"1"])
        {
            cell.update.hidden=YES;
            cell.update2.hidden=YES;
        }
        else
        {
            cell.update2.hidden=YES;
            cell.update.hidden=YES;
        }
        
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        //
        cell.title.text = knowledge.name;
        cell.lb.text = [NSString stringWithFormat:@"%@",knowledge.id];
        cell.lb.hidden = YES;
        cell.prodect.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.kid] ];
        //cell.kidLb.text= [productarr objectForKey: [numberFormatter stringFromNumber:knowledge.mpid] ];
        cell.backgroundColor=[UIColor clearColor];
        
        
        return cell;

        
    }

    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTable]){
       
        {
            NSArray * numberarr = [NSArray arrayWithObjects:@"1",@"3",@"2", nil];
            
//            NSArray *kid   = [PolocyInfo MR_findByAttribute:@"kid" withValue:[NSNumber numberWithLong:indexPath.section+1]];
             NSArray *kid   = [PolocyInfo MR_findByAttribute:@"kid" withValue:numberarr[indexPath.section]];
            _policyInfoArray= [NSMutableArray arrayWithArray:kid];
        }
        
        //    _currentRow = indexPath.row;
        //    NSArray *personsAgeEuqals25   = [Knowledge MR_findByAttribute:@"kid" withValue:[NSNumber numberWithInt:1]];
        //NSLog(@"%@",_mKnowledgeArray);
        
        [_rightTable reloadData];
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"PolicyDetail"])
    {
        NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
        if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
            UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
            
            
            return NO;
        }
        else{
            return YES;
        }
    }
    else
    {
        return YES;
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"dakai"]) {
        
        PolicyTableViewCell * cell = (PolicyTableViewCell *)[[sender superview] superview];
        
        //        NSLog(@"%@",cell.lb);
        
        PolocyInfo *kOne=[PolocyInfo MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
        //        NSLog(@"%@",kOne.hasdownload);
        
        if([kOne.hasdownload isEqualToString:@"1"])
        {
            //打开
            
            StudyImageViewController* view = segue.destinationViewController;
            
            view.theid =[NSString stringWithFormat:@"%@",kOne.id];
            view.pages = kOne.pages;
            view.tag2=_tag2;
            view.tag=@"0";
            view.name=kOne.name;
            
        }
        
    }
    else if ([segue.identifier isEqualToString:@"PolicyDetail"]) {
        
        //  NSMutableDictionary *dict ;
        NSIndexPath *indexPath;
        
        indexPath=[_rightTable indexPathForSelectedRow];
        //        NSLog(@"%ld",(long)indexPath.section);
        PolocyInfo * knowledge = _policyInfoArray[indexPath.section];
        //        NSLog(@"%@",knowledge.pages);
        //        NSLog(@"%@",knowledge.id);
        
        
        
        
        
        //
        //        dict =[_images objectAtIndex:indexPath.row];
        //
        //
        //
        StudyImageViewController* view = segue.destinationViewController;
        
        view.theid =[NSString stringWithFormat:@"%@",knowledge.id];
        view.pages = knowledge.pages;
        view.tag=@"1";
        view.tag2=_tag2;
        view.name=knowledge.name;
        
        //        view.imageArray=_images;
        // NSLog(@"--------------%@",view.data);
        
        
        
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

- (IBAction)sendMessage:(id)sender {
    
//    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
//    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
//        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//        
//        
//        [alert show];
//        
//        
//        
//        
//    }
//    else{
//        
//        PolicyTableViewCell * cell = [(PolicyTableViewCell *)[sender superview] superview];
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
//        //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//        
//        NSString *openUDID = [LXF_OpenUDID value];
//        NSDictionary *parameters =@{@"pid":cell.lb.text,@"udid":openUDID};
//        
//        
//        NSLog(@"parm =  %@",parameters);
//        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
//        NSString*string=[url objectForKey:@"string"];
//        NSLog(@"%@",string);
//        [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createtemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            
//            if([[responseObject objectForKey:@"ok"] intValue]==0)
//            {
//                
//                
//                
//                
//                UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//                
//                
//                [alert show];
//            }
//            
//            if([[responseObject objectForKey:@"ok"] intValue]==1){
//                UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//                
//                
//                [alert show];
//            }
//            
//            
//            
//            
//            
//            
//            
//            
//            //[Knowledge MR_numberOfEntities];
//            //        NSLog(@"%@", [Knowledge MR_numberOfEntities]);
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
//        
//    }

    
    
}
- (void)update:(id)sender {
    
//    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
//    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
//        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//        
//        
//        [alert show];
//        
//        
//        
//        
//    }
//    else{
//
//    PolicyTableViewCell * cell = [(PolicyTableViewCell *)[sender superview]superview];
//    
//    //        NSLog(@"%@",cell.lb);
//    
//    PolocyInfo *kOne=[PolocyInfo MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
//    //        NSLog(@"%@",kOne.hasdownload);
//    
//    
//    //下载
//    dispatch_queue_t queue = dispatch_get_global_queue(
//                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
//        NSString*string=[url objectForKey:@"string"];
//        NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/xzfiles/%@.zip",string,cell.lb.text]];
//        NSError *error = nil;
//        NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
//        
//        if(!error)
//        {
//            /*
//             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//             NSString *path = [paths objectAtIndex:0];
//             
//             NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path, @"14"];
//             BOOL isDir = NO;
//             NSFileManager *fileManager = [NSFileManager defaultManager];
//             BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
//             
//             NSLog(@"%@",imageDir);
//             NSLog(@"%hhd",isDir);
//             if ( !(isDir == YES ) )
//             {
//             [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
//             }
//             
//             
//             */
//            
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//            NSString *path = [paths objectAtIndex:0];
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            NSString *testDirectory = [path stringByAppendingPathComponent:@"xzfile"];
//            // 创建目录
//            [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//            //  NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path, @"knfiles"];
//            
//            NSString *zipPath2 = [testDirectory stringByAppendingPathComponent:@"xzfile"];
//            
//            
//            [data writeToFile:zipPath2 options:0 error:&error];
//            //                    NSLog(@"%@zip=====",zipPath2);
//            if(!error)
//            {
//                ZipArchive *za = [[ZipArchive alloc] init];
//                if ([za UnzipOpenFile: zipPath2]) {
//                    BOOL ret = [za UnzipFileTo: testDirectory overWrite: YES];
//                    if (NO == ret){} [za UnzipCloseFile];
//                    
//                    for(int i = 0; i<[_policyInfoArray count];i++)
//                    {
//                        PolocyInfo * kkone = _policyInfoArray[i];
//                        if([kkone.id intValue]==[cell.lb.text intValue])
//                        {
//                            kkone.hasdownload = @"1";
//                            _policyInfoArray[i]=kkone;
//                        }
//                    }
//                    
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        //下载完成
//                        cell.update.hidden = NO;
//                        cell.update2.hidden = YES;
//                        kOne.hasdownload = @"1";
//                        [[NSManagedObjectContext MR_defaultContext] MR_save];
//                        
//                    });
//                }
//            }
//            else
//            {
//                NSLog(@"Error saving file %@",error);
//            }
//        }
//        else
//        {
//            NSLog(@"Error downloading zip file: %@", error);
//        }
//        
//    });
//    }
}
#pragma UISearchDisplayDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    //    _mySearchBar.text;
    
    
    NSString * sestr = [NSString stringWithFormat:@"name LIKE[cd] '*%@*'",_mySearch.text];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
    
    _policyInfoArray = [NSMutableArray arrayWithArray:[PolocyInfo MR_findAllWithPredicate:predicate]];
    [_rightTable reloadData];
    int theCount = [PolocyInfo MR_countOfEntitiesWithPredicate:predicate];
    NSLog(@"%d",theCount);
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

@end
