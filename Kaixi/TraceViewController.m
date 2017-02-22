//
//  TraceViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/2.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "TraceViewController.h"
#import "TraceTableViewCell.h"
#import "ZipArchive.h"
#import "StudyImageViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserInfo.h"
#import "LXF_OpenUDID.h"
#import "Trace.h"
#import "GPLoadingView.h"
@interface TraceViewController ()

@end

@implementation TraceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tag2=@"4";
    
    
    _table.backgroundColor=[UIColor clearColor];
       _table.separatorColor = [UIColor clearColor];
    _traceArray= [[NSMutableArray alloc]init];
    _images= [[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=knowledge/trace"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
        
        for (NSDictionary*k in responseObject) {
            
            Trace *kOne=[Trace MR_findFirstByAttribute:@"id" withValue:[k objectForKey:@"id"]];
            if (kOne) {
                //kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                //kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mkid"]intValue]];
                kOne.pages=[k objectForKey:@"pages"];
               kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
                
            }
            else{
                kOne = [Trace MR_createEntity];
                kOne.id=[NSNumber numberWithInt:[[k objectForKey:@"id"]intValue]];
                //  kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mpid"]intValue]];
                //kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                kOne.hasdownload = @"0";
                kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
            }
            
            
        }
        
        _traceArray = [NSMutableArray arrayWithArray:[Trace MR_findAll]];
        NSLog(@"%@",_traceArray);
        [_table reloadData];
        
        
        //[Knowledge MR_numberOfEntities];
       // NSLog(@"%@", [PolocyInfo MR_numberOfEntities]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
      return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return _traceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
           static NSString *CellIdentifier = @"Cell";
        TraceTableViewCell *cell = (TraceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TraceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
         NSLog(@"%@", _traceArray[indexPath.section]);
    NSLog(@"%@", _traceArray[indexPath.row]);
        Trace * knowledge = _traceArray[indexPath.section];
    
       // NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        //
        cell.title.text = knowledge.name;
    NSLog(@"%@",cell.title.text);
    
    cell.act.hidden=YES;
    
        cell.lb.text = [NSString stringWithFormat:@"%@",knowledge.id];
        cell.lb.hidden = YES;
        //cell.prodect.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.kid] ];
        //cell.kidLb.text= [productarr objectForKey: [numberFormatter stringFromNumber:knowledge.mpid] ];
        cell.backgroundColor=[UIColor clearColor];
    
    if([knowledge.hasdownload isEqualToString:@"1"])
    {
        cell.update.hidden=NO;
        cell.update2.hidden=YES;
        cell.act2.hidden=YES;
        NSLog(@"%@--1>%ld",cell.lb.text,(long)indexPath.section);
    }
    else if([knowledge.hasdownload isEqualToString:@"0"])
    {
        cell.update2.hidden=NO;
        cell.update.hidden=YES;
        cell.act2.hidden=YES;
        NSLog(@"%@--0>%ld",cell.lb.text,(long)indexPath.section);
    }else
    {
        cell.update2.hidden=YES;
        cell.update.hidden=YES;
        cell.act2.hidden=NO;
        
        [cell.act2 startAnimation];
        NSLog(@"%@--2>%ld",cell.lb.text,(long)indexPath.section);
    }

    
        return cell;
    
    
   
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"cell"])
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
      double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if ([segue.identifier isEqualToString:@"dakai"]) {
        if (version<8.0) {
            
        
        
        TraceTableViewCell * cell = (TraceTableViewCell *)[[[sender superview] superview]superview];
        
        //        NSLog(@"%@",cell.lb);
        
        Trace *kOne=[Trace MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
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
        else{
        
            TraceTableViewCell * cell = (TraceTableViewCell *)[[sender superview] superview];
            
            //        NSLog(@"%@",cell.lb);
            
            Trace *kOne=[Trace MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
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
}
    else if ([segue.identifier isEqualToString:@"cell"]) {
        
        //  NSMutableDictionary *dict ;
        NSIndexPath *indexPath;
        
        indexPath=[_table indexPathForSelectedRow];
        //        NSLog(@"%ld",(long)indexPath.section);
        Trace * knowledge = _traceArray[indexPath.section];
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

- (IBAction)update:(id)sender  {
    
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }
    else{
         double version = [[UIDevice currentDevice].systemVersion doubleValue];
        if (version<8.0) {
            
        

    TraceTableViewCell * cell = (TraceTableViewCell *)[[[sender superview]superview]superview];
    
    //        NSLog(@"%@",cell.lb);
    
    Trace *kOne=[Trace MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
    //        NSLog(@"%@",kOne.hasdownload);
    
            cell.update2.hidden = YES;
            cell.act2.hidden=NO;
            
            
            kOne.hasdownload=@"2";
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            for(int i = 0; i<[_traceArray count];i++)
            {
                Trace * kkone = _traceArray[i];
                if([kkone.id intValue]==[cell.lb.text intValue])
                {
                    kkone.hasdownload = @"2";
                    _traceArray[i]=kkone;
                }
            }
            
            
            
            
            [cell.act2 startAnimation];
            //下载
    dispatch_queue_t queue = dispatch_get_global_queue(
                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
         cell.update2.hidden = YES;
        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
        NSString*string=[url objectForKey:@"string"];
        NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/trace/%@.zip",string,cell.lb.text]];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
        
        if(!error)
        {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            
            NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path2 = [paths2 objectAtIndex:0];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            NSString * zipstr = [ NSString stringWithFormat:@"tarce_tarce_%@",cell.lb.text];
            NSString *testDirectory = [path stringByAppendingPathComponent:@"tarce"];
            NSString *testDirectory2 = [path2 stringByAppendingPathComponent:@"tarce"];
            // 创建目录
            [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            //  NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path, @"knfiles"];
            
            NSString *zipPath2 = [testDirectory stringByAppendingPathComponent:zipstr];
            
            
            [data writeToFile:zipPath2 options:0 error:&error];
            //                    NSLog(@"%@zip=====",zipPath2);
            if(!error)
            {
                ZipArchive *za = [[ZipArchive alloc] init];
                if ([za UnzipOpenFile: zipPath2]) {
                    BOOL ret = [za UnzipFileTo: testDirectory2 overWrite: YES];
                    if (NO == ret){} [za UnzipCloseFile];
                    for(int i = 0; i<[_traceArray count];i++)
                    {
                        Trace * kkone = _traceArray[i];
                        if([kkone.id intValue]==[cell.lb.text intValue])
                        {
                            kkone.hasdownload = @"1";
                            _traceArray[i]=kkone;
                        }
                    }
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        cell.act2.hidden=YES;
                        [cell.act2 stopAnimation];
                        cell.update.hidden=NO;
                        kOne.hasdownload = @"1";
                        [[NSManagedObjectContext MR_defaultContext] MR_save];
                        
                        _traceArray[[cell.lb.text intValue]-1]=kOne;
                        
                        [self wancheng];
                        
                    });
                }
            }
            else
            {
                NSLog(@"Error saving file %@",error);
            }
        }
        else
        {
            NSLog(@"Error downloading zip file: %@", error);
        }
        
    });
    
        }else{
        
            TraceTableViewCell * cell = (TraceTableViewCell *)[[sender superview]superview];
            
            //        NSLog(@"%@",cell.lb);
            
            Trace *kOne=[Trace MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
            //        NSLog(@"%@",kOne.hasdownload);
            
            cell.update2.hidden = YES;
            cell.act2.hidden=NO;
            
            
            kOne.hasdownload=@"2";
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            for(int i = 0; i<[_traceArray count];i++)
            {
                Trace * kkone = _traceArray[i];
                if([kkone.id intValue]==[cell.lb.text intValue])
                {
                    kkone.hasdownload = @"2";
                    _traceArray[i]=kkone;
                }
            }
            
            
            
            
            [cell.act2 startAnimation];
            //下载
            dispatch_queue_t queue = dispatch_get_global_queue(
                                                               DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                cell.update2.hidden = YES;
                NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
                NSString*string=[url objectForKey:@"string"];
                NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/trace/%@.zip",string,cell.lb.text]];
                NSError *error = nil;
                NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
                
                if(!error)
                {
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                    NSString *path = [paths objectAtIndex:0];
                    
                    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *path2 = [paths2 objectAtIndex:0];
                    
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    
                    NSString * zipstr = [ NSString stringWithFormat:@"tarce_tarce_%@",cell.lb.text];
                    NSString *testDirectory = [path stringByAppendingPathComponent:@"trace"];
                    NSString *testDirectory2 = [path2 stringByAppendingPathComponent:@"trace"];
                    // 创建目录
                    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
                    //  NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path, @"knfiles"];
                    
                    NSString *zipPath2 = [testDirectory stringByAppendingPathComponent:zipstr];
                    
                    
                    [data writeToFile:zipPath2 options:0 error:&error];
                    //                    NSLog(@"%@zip=====",zipPath2);
                    if(!error)
                    {
                        ZipArchive *za = [[ZipArchive alloc] init];
                        if ([za UnzipOpenFile: zipPath2]) {
                            BOOL ret = [za UnzipFileTo: testDirectory2 overWrite: YES];
                            if (NO == ret){} [za UnzipCloseFile];
                            
                            for(int i = 0; i<[_traceArray count];i++)
                            {
                                Trace * kkone = _traceArray[i];
                                if([kkone.id intValue]==[cell.lb.text intValue])
                                {
                                    kkone.hasdownload = @"1";
                                    _traceArray[i]=kkone;
                                }
                            }
                            
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                //下载完成
                                cell.act2.hidden=YES;
                                [cell.act2 stopAnimation];
                                cell.update.hidden=NO;
                                kOne.hasdownload = @"1";
                                [[NSManagedObjectContext MR_defaultContext] MR_save];
                                
                                _traceArray[[cell.lb.text intValue]-1]=kOne;
                                
                                [self wancheng];
                                
                            });
                        }
                    }
                    else
                    {
                        NSLog(@"Error saving file %@",error);
                    }
                }
                else
                {
                    NSLog(@"Error downloading zip file: %@", error);
                }
                
            });
        
        
        }
    }
}
//-(void)progressSimulation:(NSTimer *)timer
//{
//    
//    SDPieLoopProgressView * p =(SDPieLoopProgressView *)[(TraceTableViewCell *)[timer userInfo] viewWithTag:109];
//    p.progress+=0.01;
//    if(p.progress>0.89)
//    {
//        [timer invalidate];
//    }
//    
//}
//
//-(void)progressSimulation2:(NSTimer *)timer2
//{
//    //    (KnowledgeTableViewCell *) cell1 = (KnowledgeTableViewCell *)[timer userInfo];
//    TraceTableViewCell * cell = [timer2 userInfo];
//    SDPieLoopProgressView * p =(SDPieLoopProgressView *)[(TraceTableViewCell *)[timer2 userInfo] viewWithTag:109];
//    p.progress+=0.01;
//    if(p.progress>1)
//    {
//        [timer2 invalidate];
//        cell.update.hidden = NO;
//    }
//    
//}

- (IBAction)sendMessage:(id)sender {
    
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }
    else{
        
        double version = [[UIDevice currentDevice].systemVersion doubleValue];
        if (version<8.0) {
    TraceTableViewCell * cell =(TraceTableViewCell *)[[[sender superview] superview] superview];
            cell.act.hidden=NO;
            [cell.act startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"pid":cell.lb.text,@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"%@",string);
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createtemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if([[responseObject objectForKey:@"ok"] intValue]==0)
        {
            
            
            cell.act.hidden=YES;
            [cell.act stopAnimating];
            
            UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
        }
        
        if([[responseObject objectForKey:@"ok"] intValue]==1){
            UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            cell.act.hidden=YES;
            [cell.act stopAnimating];
            
            [alert show];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
            
        }else{
            TraceTableViewCell * cell =(TraceTableViewCell *)[[sender superview] superview];
            
            cell.act.hidden=NO;
            [cell.act startAnimating];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
            //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
            
            NSString *openUDID = [LXF_OpenUDID value];
            NSDictionary *parameters =@{@"pid":cell.lb.text,@"udid":openUDID};
            
            
            NSLog(@"parm =  %@",parameters);
            NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
            NSString*string=[url objectForKey:@"string"];
            NSLog(@"%@",string);
            [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createtemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                if([[responseObject objectForKey:@"ok"] intValue]==0)
                {
                    
                    
                    
                    cell.act.hidden=YES;
                    [cell.act stopAnimating];
                    UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                    
                    
                    [alert show];
                }
                
                if([[responseObject objectForKey:@"ok"] intValue]==1){
                    
                    cell.act.hidden=YES;
                    [cell.act stopAnimating];
                    UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                    
                    
                    [alert show];
                }
                
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        
        
        
        }
    }
}

-(void)wancheng{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"%@",string);
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/downloadknowladge"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"isok"] intValue]==1) {
            
            //
            //            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送邮件至邮箱请查收" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            //
            //
            //           [ alert show];
            NSLog(@"增加分数咯！！！");
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        NSLog(@"Error: %@", error);
    }];
}
@end
