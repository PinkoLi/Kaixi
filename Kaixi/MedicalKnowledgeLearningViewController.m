//
//  MedicalKnowledgeLearningViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/14.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "MedicalKnowledgeLearningViewController.h"


#import "MedicalKind.h"
#import "MedicalKnowledge.h"
#import "MedicalProduct.h"
#import "MedicalImage.h"
#import "MedicalTableViewCell.h"
#import "ZipArchive.h"
#import "StudyImageViewController.h"
#import "LXF_OpenUDID.h"
#import "AFHTTPRequestOperationManager.h"
#import "GPLoadingView.h"
@interface MedicalKnowledgeLearningViewController ()

@end

@implementation MedicalKnowledgeLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tag2=@"2";
    
    _leftTable.backgroundColor=[UIColor clearColor];
    _rightTable.backgroundColor=[UIColor clearColor];
    _leftTable.separatorColor = [UIColor clearColor];
    _leftTable.backgroundColor = [UIColor clearColor];
    _mKnowledgeArray= [[NSMutableArray alloc]init];
    _images= [[NSMutableArray alloc]init];
    
    
            MedicalKind *person1 = [MedicalKind MR_createEntity];
            person1.id= [NSNumber numberWithInt:1] ;
            person1.name = @"培训PPT";
    
            MedicalKind *person2 = [MedicalKind MR_createEntity];
            person2.id= [NSNumber numberWithInt:2] ;
            person2.name = @"推荐文献";
    
            MedicalKind *person3 = [MedicalKind MR_createEntity];
            person3.id= [NSNumber numberWithInt:3] ;
            person3.name = @"指南";
    
//        MedicalKnowledge *K=[MedicalKnowledge MR_createEntity];
//        [K MR_deleteEntity];
//      [[NSManagedObjectContext MR_defaultContext] MR_save];
//
//
//
//    
//    
//    
//    
//            MedicalProduct *person21 = [MedicalProduct MR_createEntity];
//            person21.id= [NSNumber numberWithInt:1] ;
//            person21.name = @"说明书";
//    
//            MedicalProduct *person22 = [MedicalProduct MR_createEntity];
//            person22.id= [NSNumber numberWithInt:2] ;
//            person22.name = @"DA";
//    
//            MedicalProduct *person23 = [MedicalProduct MR_createEntity];
//            person23.id= [NSNumber numberWithInt:3] ;
//            person23.name = @"科室会";
//    
//            MedicalProduct *person24 = [MedicalProduct MR_createEntity];
//            person24.id= [NSNumber numberWithInt:4] ;
//            person24.name = @"文献解读";
//    
//            MedicalProduct *person25 = [MedicalProduct MR_createEntity];
//            person25.id= [NSNumber numberWithInt:5] ;
//            person25.name = @"其他";
//    
//    
//    
//            MedicalKnowledge * person111 =[MedicalKnowledge MR_createEntity];
//            person111.mpid =[NSNumber numberWithInt:1] ;
//            person111.mkid = [NSNumber numberWithInt:1] ;
//            person111.name =@"详情1";
//            MedicalKnowledge * person222 =[MedicalKnowledge MR_createEntity];
//            person222.mpid =[NSNumber numberWithInt:2] ;
//            person222.mkid = [NSNumber numberWithInt:2] ;
//            person222.name =@"详情2";
//        
//               [[NSManagedObjectContext MR_defaultContext] MR_save];
    
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    //zaixian
    if ([[online objectForKey:@"online"]isEqualToString:@"1"])
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=yxknowledge2/yxknowledgelist"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
       
//            NSArray*kk=[MedicalKnowledge MR_findByAttribute:@"id" withValue:[NSNumber numberWithInt:[[responseObject objectForKey:@"del"]intValue]]];
             for (NSNumber*i in [responseObject objectForKey:@"del"]) {
             MedicalKnowledge *kOne=[MedicalKnowledge MR_findFirstByAttribute:@"id" withValue:i];
                 
                 if (kOne) {
                      [kOne MR_deleteEntity];
                      [[NSManagedObjectContext MR_defaultContext] MR_save];
                     
                     
                     
                 }
                 
            
        }
       
        
        NSLog(@"%@",[responseObject objectForKey:@"del"]);
       
        for (NSDictionary*k in [responseObject objectForKey:@"on"]) {
            
            MedicalKnowledge *kOne=[MedicalKnowledge MR_findFirstByAttribute:@"id" withValue:[k objectForKey:@"id"]];
            NSLog(@"1111111111111111%@",kOne.id);
            if (kOne) {
                kOne.mkid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                //kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mkid"]intValue]];
                 kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
                
            }
            else{
                kOne = [MedicalKnowledge MR_createEntity];
                kOne.id=[NSNumber numberWithInt:[[k objectForKey:@"id"]intValue]];
              //  kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mpid"]intValue]];
                kOne.mkid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                kOne.hasdownload = @"0";
                kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
            }
            
            
        }
        
        _mKnowledgeArray = [NSMutableArray arrayWithArray:[MedicalKnowledge MR_findAll]];
        [_rightTable reloadData];
        
        
        //[Knowledge MR_numberOfEntities];
        NSLog(@"--------------%@", [MedicalKnowledge MR_numberOfEntities]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    }
    
    else
    {
        NSString * sestr = @"hasdownload=1";
        NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
        _mKnowledgeArray = [NSMutableArray arrayWithArray:[MedicalKnowledge MR_findAllWithPredicate:predicate]];
        
    }
    _leftArray=[NSMutableArray arrayWithObjects:@"资料类型分类" ,nil];
   
    
    
    
    
    [self loadModel];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadModel{
    _currentRow = -1;
    _headViewArray = [[NSMutableArray alloc]init ];
    //_kindArray =[NSMutableArray arrayWithArray:[Kind MR_findAll]];
    
    
    for(int i = 0;i< _leftArray.count ;i++)
    {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        //       Knowledge * knowledge = _knowledgeArray[indexPath.row];
        //Kind *kindone= _kindArray[i];
        [headview.backBtn setTitle:_leftArray[i] forState:UIControlStateNormal];
         [headview.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          headview.backBtn.titleLabel.font=[UIFont systemFontOfSize: 24.0];
        UIImageView * imgone =[[UIImageView alloc] initWithFrame:CGRectMake(220, 22 ,35,35)];
        imgone.tag = 100+i;
        UIImageView * imgone2 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 75  ,850,1)];
        [imgone2 setImage:[UIImage imageNamed:@"横线-短.png"]];
        
        [imgone setImage:[UIImage imageNamed:@"箭头2.png"]];
        
        [headview addSubview:imgone];
              [headview addSubview:imgone2];
        
        [self.headViewArray addObject:headview];

        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTable]) {
        HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
        
        return headView.open?60:0;
    }
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_leftTable]) {
        return 70;
    }
    return -1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:_leftTable]) {
        return 0.1;
    }
    return -1;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_leftTable]) {
        return [self.headViewArray objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_leftTable]) {
        
        int i=0;
        if (section==0) {
            i=3;
        }
       
        HeadView* headView = [self.headViewArray objectAtIndex:section];
        return headView.open?i:0;
    }
    else if ([tableView isEqual:_rightTable]) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_leftTable]){
        return [self.headViewArray count];
        
    }else if ([tableView isEqual:_rightTable]) {
        
        return [_mKnowledgeArray count];
    }
    
    return [self.leftArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_leftTable]){
        static NSString *indentifier = @"leftCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] ;
            UIButton* backBtn=  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 330, 45)];
            backBtn.tag = 20000;
//            [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_on"] forState:UIControlStateHighlighted];
            backBtn.userInteractionEnabled = NO;
            [cell.contentView addSubview:backBtn];
            
            
            UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 340, 1)];
            line.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:line];
            
            
        }
        UIButton* backBtn = (UIButton*)[cell.contentView viewWithTag:20000];
        HeadView* view = [self.headViewArray objectAtIndex:indexPath.section];
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_2_nomal"] forState:UIControlStateNormal];
        
        if (view.open) {
            if (indexPath.row == _currentRow) {
//                [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            }
        }
        
        
        if(indexPath.section==0)
        {
            MedicalKind *kindone=[MedicalKind MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLong:indexPath.row+1]];
            cell.textLabel.text= kindone.name;
            cell.textLabel.font=[UIFont systemFontOfSize:20];
             cell.textLabel.textAlignment= UITextAlignmentCenter;
            
        }
//        else if(indexPath.section==1){
//            MedicalProduct *productone=[MedicalProduct MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLong:indexPath.row+1]];
//            cell.textLabel.text= productone.name;
//            
//        }
        
        //    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor=[UIColor clearColor];
        
        
        return cell;
    }
    else if ([tableView isEqual:_rightTable]) {
        
        
        
        NSDictionary * kindarr = [NSDictionary dictionaryWithObjectsAndKeys:@"培训PPT",@"1",@"推荐文献",@"2",@"指南",@"3", nil];
        
      

        static NSString *CellIdentifier = @"rightCell";
        MedicalTableViewCell *cell = (MedicalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MedicalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
      

        cell.act.hidden=YES;
        MedicalKnowledge * knowledge = _mKnowledgeArray[indexPath.section];
               
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        //
        
        cell.ib.text =[NSString stringWithFormat:@"%ld",(long)indexPath.section];
        cell.ib.hidden = YES;
        
        cell.title.text = knowledge.name;
        cell.lb.text = [NSString stringWithFormat:@"%@",knowledge.id];
        cell.lb.hidden = YES;
        cell.pidLb.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.mkid] ];
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
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTable]){
        
        NSUserDefaults *online=[NSUserDefaults standardUserDefaults];

//        if(indexPath.section==0)
//        {
//            NSArray *mkid   = [MedicalKnowledge MR_findByAttribute:@"mkid" withValue:[NSNumber numberWithLong:indexPath.row+1]];
//            _mKnowledgeArray= [NSMutableArray arrayWithArray:mkid];
//        }
//        
//        //    _currentRow = indexPath.row;
//        //    NSArray *personsAgeEuqals25   = [Knowledge MR_findByAttribute:@"kid" withValue:[NSNumber numberWithInt:1]];
//        //NSLog(@"%@",_mKnowledgeArray);
        
        if(indexPath.section==0){
            
            if ([[online objectForKey:@"online"]isEqualToString:@"1"])
            {
                NSArray *mkid   = [MedicalKnowledge MR_findByAttribute:@"mkid" withValue:[NSNumber numberWithLong:indexPath.row+1]];
                _mKnowledgeArray= [NSMutableArray arrayWithArray:mkid];
            }
            else
            {
                NSString * sestr = [NSString stringWithFormat:@"hasdownload=1 AND mkid=%d", indexPath.row+1];
                NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
                _mKnowledgeArray = [NSMutableArray arrayWithArray:[MedicalKnowledge MR_findAllWithPredicate:predicate]];
            }
            //            NSArray *pid   = [Knowledge MR_findByAttribute:@"pid" withValue:[NSNumber numberWithLong:indexPath.row+1]];
            //            _knowledgeArray= [NSMutableArray arrayWithArray:pid];
            
        }

        
        [_rightTable reloadData];
    }
}

#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    _currentRow = -1;
    if (view.open) {
        for(int i = 0;i<[_headViewArray count];i++)
        {
            HeadView *head = [_headViewArray objectAtIndex:i];
            head.open = NO;
           // [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            UIImageView * imgone = [head viewWithTag:(100+i)];
            
            [imgone setImage:[UIImage imageNamed:@"箭头2.png"]];

        }
        [_leftTable reloadData];
        return;
    }
    _currentSection = view.section;
    [self reset];
    
}

//界面重置
- (void)reset
{
    for(int i = 0;i<[_headViewArray count];i++)
    {
        HeadView *head = [_headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
           // [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            UIImageView * imgone = [head viewWithTag:(100+i)];
            
            [imgone setImage:[UIImage imageNamed:@"箭头1.png"]];
            
        }else {
           // [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            UIImageView * imgone = [head viewWithTag:(100+i)];
            
            [imgone setImage:[UIImage imageNamed:@"箭头2.png"]];
            
            head.open = NO;
        }
        
    }
    [_leftTable reloadData];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"MedicalDetail"])
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
            
        
        
        MedicalTableViewCell * cell = (MedicalTableViewCell *)[[[sender superview] superview]superview];
        
        //        NSLog(@"%@",cell.lb);
        
        MedicalKnowledge *kOne=[MedicalKnowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
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
        
            MedicalTableViewCell * cell = (MedicalTableViewCell *)[[sender superview] superview];
            
            //        NSLog(@"%@",cell.lb);
            
            MedicalKnowledge *kOne=[MedicalKnowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
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
    else if ([segue.identifier isEqualToString:@"MedicalDetail"]) {
        
        //  NSMutableDictionary *dict ;
        NSIndexPath *indexPath;
        
        indexPath=[_rightTable indexPathForSelectedRow];
        //        NSLog(@"%ld",(long)indexPath.section);
        MedicalKnowledge * knowledge = _mKnowledgeArray[indexPath.section];
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

- (IBAction)update:(id)sender {
    
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }
    else{
        double version = [[UIDevice currentDevice].systemVersion doubleValue];
        if (version<8.0) {
            
        
        
    
            MedicalTableViewCell * cell = (MedicalTableViewCell *)[[[sender superview]superview]superview];
            
            //        NSLog(@"%@",cell.lb);
            
            MedicalKnowledge *kOne=[MedicalKnowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
            //        NSLog(@"%@",kOne.hasdownload);
            int index1 =[cell.ib.text intValue];
            cell.update2.hidden = YES;
            cell.act2.hidden=NO;
            
            kOne.hasdownload=@"2";
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            
            
            
            [cell.act2 startAnimation];
            
            //下载
            dispatch_queue_t queue = dispatch_get_global_queue(
                                                               DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                cell.update2.hidden = YES;
                NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
                NSString*string=[url objectForKey:@"string"];
                NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/yxfiles/%@.zip",string,cell.lb.text]];
                NSError *error = nil;
                NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
                
                if(!error)
                {
                    /*
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                     NSString *path = [paths objectAtIndex:0];
                     
                     NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path, @"14"];
                     BOOL isDir = NO;
                     NSFileManager *fileManager = [NSFileManager defaultManager];
                     BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
                     
                     NSLog(@"%@",imageDir);
                     NSLog(@"%hhd",isDir);
                     if ( !(isDir == YES ) )
                     {
                     [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
                     }
                     
                     
                     */
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                    NSString *path = [paths objectAtIndex:0];
                    
                    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *path2 = [paths2 objectAtIndex:0];
                    
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    
                    NSString * zipstr = [ NSString stringWithFormat:@"mkonFile_mknfiles_%@",cell.lb.text];
                    NSString *testDirectory = [path stringByAppendingPathComponent:@"mkonFile"];
                    NSString *testDirectory2 = [path2 stringByAppendingPathComponent:@"mkonFile"];
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
                            
                            
                            
                            
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                
                                
                                kOne.hasdownload = @"1";
                                [[NSManagedObjectContext MR_defaultContext] MR_save];
                                
                                _mKnowledgeArray[index1]=kOne;
                                [_rightTable reloadData];
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
        else {
            
            MedicalTableViewCell * cell = (MedicalTableViewCell *)[[sender superview]superview];
            
            //        NSLog(@"%@",cell.lb);
            
            MedicalKnowledge *kOne=[MedicalKnowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
            //        NSLog(@"%@",kOne.hasdownload);
            int index1 =[cell.ib.text intValue];
            cell.update2.hidden = YES;
            cell.act2.hidden=NO;
            
            kOne.hasdownload=@"2";
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            
            
            
            [cell.act2 startAnimation];
            
            //下载
            dispatch_queue_t queue = dispatch_get_global_queue(
                                                               DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                cell.update2.hidden = YES;
                NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
                NSString*string=[url objectForKey:@"string"];
                NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/yxfiles/%@.zip",string,cell.lb.text]];
                NSError *error = nil;
                NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
                
                if(!error)
                {
                    /*
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                     NSString *path = [paths objectAtIndex:0];
                     
                     NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path, @"14"];
                     BOOL isDir = NO;
                     NSFileManager *fileManager = [NSFileManager defaultManager];
                     BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
                     
                     NSLog(@"%@",imageDir);
                     NSLog(@"%hhd",isDir);
                     if ( !(isDir == YES ) )
                     {
                     [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
                     }
                     
                     
                     */
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                    NSString *path = [paths objectAtIndex:0];
                    
                    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *path2 = [paths2 objectAtIndex:0];
                    
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    
                    NSString * zipstr = [ NSString stringWithFormat:@"mkonFile_mknfiles_%@",cell.lb.text];
                    NSString *testDirectory = [path stringByAppendingPathComponent:@"mkonFile"];
                    NSString *testDirectory2 = [path2 stringByAppendingPathComponent:@"mkonFile"];
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

                            
                            
                            
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                              
                            
                                kOne.hasdownload = @"1";
                                [[NSManagedObjectContext MR_defaultContext] MR_save];
                                
                                _mKnowledgeArray[index1]=kOne;
                                 [_rightTable reloadData];
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
//    SDPieLoopProgressView * p =(SDPieLoopProgressView *)[(MedicalTableViewCell *)[timer userInfo] viewWithTag:109];
//    p.progress+=0.01;
//    if(p.progress>0.99)
//    {
//        [timer invalidate];
//    }
//    
//}
//
//-(void)progressSimulation2:(NSTimer *)timer2
//{
//    //    (KnowledgeTableViewCell *) cell1 = (KnowledgeTableViewCell *)[timer userInfo];
//    MedicalTableViewCell * cell = [timer2 userInfo];
//    SDPieLoopProgressView * p =(SDPieLoopProgressView *)[(MedicalTableViewCell *)[timer2 userInfo] viewWithTag:109];
//    p.progress+=0.01;
//    if(p.progress>1)
//    {
//        [timer2 invalidate];
//        cell.update.hidden = NO;
//    }
//    
//}
#pragma UISearchDisplayDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    //    _mySearchBar.text;
    
    
//    NSString * sestr = [NSString stringWithFormat:@"name LIKE[cd] '*%@*'",_mySearch.text];
//    NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
//    
//    _mKnowledgeArray = [NSMutableArray arrayWithArray:[MedicalKnowledge MR_findAllWithPredicate:predicate]];
//    [_rightTable reloadData];
//    int theCount = [MedicalKnowledge MR_countOfEntitiesWithPredicate:predicate];
//    NSLog(@"%d",theCount);
//    
//    [searchBar setShowsCancelButton:NO animated:YES];
//    [searchBar resignFirstResponder];
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    NSString * sestr = [NSString stringWithFormat:@"name LIKE[cd] '*%@*'",_mySearch.text];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"])
    {
        sestr = [NSString stringWithFormat:@"hasdownload=1 AND name LIKE[cd] '*%@*'", _mySearch.text];
    }
    
    //    NSString * sestr = [NSString stringWithFormat:@"name LIKE[cd] '*%@*'",_mySearchBar.text];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
    
    _mKnowledgeArray = [NSMutableArray arrayWithArray:[MedicalKnowledge MR_findAllWithPredicate:predicate]];
    [_rightTable reloadData];
    //    int theCount = [Knowledge MR_countOfEntitiesWithPredicate:predicate];
    //    NSLog(@"%d",theCount);
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}


- (IBAction)sendMessage:(id)sender {
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
        
    }
    else{
        double version = [[UIDevice currentDevice].systemVersion doubleValue];
        if (version<8.0) {
        

    MedicalTableViewCell * cell = (MedicalTableViewCell *)[[[sender superview] superview]superview];
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
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createpemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if([[responseObject objectForKey:@"ok"] intValue]==0)
        {
            
            [cell.act stopAnimating];
            cell.act.hidden=YES;
            
            
            UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
        }
        
        if([[responseObject objectForKey:@"ok"] intValue]==1){
            
            [cell.act stopAnimating];
            cell.act.hidden=YES;
            UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
        }
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
        }else{
            
            MedicalTableViewCell * cell = (MedicalTableViewCell *)[[sender superview] superview];
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
            [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createpemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                if([[responseObject objectForKey:@"ok"] intValue]==0)
                {
                    
                    
                    [cell.act stopAnimating];
                    cell.act.hidden=YES;
                    
                    UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                    
                    
                    [alert show];
                }
                
                if([[responseObject objectForKey:@"ok"] intValue]==1){
                    
                    [cell.act stopAnimating];
                    cell.act.hidden=YES;
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
