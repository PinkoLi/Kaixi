//
//  StudyAndTestViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "StudyAndTestViewController.h"
#import "Kind.h"
#import "Knowledge.h"
#import "Product.h"
#import "KnowledgeTableViewCell.h"
#import "ZipArchive.h"
#import "StudyImageViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserInfo.h"
#import "LXF_OpenUDID.h"

#import "GPLoadingView.h"





@interface StudyAndTestViewController ()

@end

@implementation StudyAndTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
//    //[online setObject:@"1" forKey:@"online"];
//    if ([[online objectForKey:@"online"]isEqualToString:@"1"]) {
//     UserInfo* onlineUser=   [UserInfo MR_findFirst];
//        //onlineUser.pkVersion;
//        
//        //get 版本号
//        
//        //获取版本号 赋值给：pkversionOfWeb;
//        
//        NSString * pkversionOfWeb = @"2015030500";
//        if([pkversionOfWeb isEqualToString:onlineUser.pkVersion])
//        {
//            //最新版本  不需要更新
//            
//        }else
//            //需要更新
//        {
//            
//        }
//    }
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    
//    //并给文件起个文件名
//    NSString *imageDir = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"163"];
//
//    NSLog(@"%@", [ isExistsFile:imageDir]);

   
   
    self.navigationController.navigationBarHidden = YES;
    
    
   
    _tag2=@"1";
    
    
    _tableViewKind.backgroundColor=[UIColor clearColor];
    _tableKnowledge.backgroundColor=[UIColor clearColor];
    _knowledgeArray= [[NSMutableArray alloc]init];
    _images= [[NSMutableArray alloc]init];
    
                Product *person1 = [Product MR_createEntity];
                person1.id= [NSNumber numberWithInt:1] ;
                person1.name = @"固尔苏";
    
                Product *person2 = [Product MR_createEntity];
                person2.id= [NSNumber numberWithInt:2] ;
                person2.name = @"倍优诺";
    
    
    
    
    
    
    
                Kind *person21 = [Kind MR_createEntity];
                person21.id= [NSNumber numberWithInt:1] ;
                person21.name = @"说明书";
    
                Kind *person22 = [Kind MR_createEntity];
                person22.id= [NSNumber numberWithInt:2] ;
                person22.name = @"DA";
    
                Kind *person23 = [Kind MR_createEntity];
                person23.id= [NSNumber numberWithInt:3] ;
                person23.name = @"科室会";
    
                Kind *person24 = [Kind MR_createEntity];
                person24.id= [NSNumber numberWithInt:4] ;
                person24.name = @"文献解读";
    
                Kind *person25 = [Kind MR_createEntity];
                person25.id= [NSNumber numberWithInt:5] ;
                person25.name = @"其他";
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    //zaixian
    if ([[online objectForKey:@"online"]isEqualToString:@"1"])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
        NSString*string=[url objectForKey:@"string"];
        [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=knowledge/knowledgelist"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //        NSLog(@"JSON: %@", responseObject);
            //        _knowledgeArray = responseObject;
            
            for (NSDictionary*k in responseObject) {
                
                Knowledge *kOne=[Knowledge MR_findFirstByAttribute:@"id" withValue:[k objectForKey:@"id"]];
                if (kOne) {
                    kOne.pid=[NSNumber numberWithInt:[[k objectForKey:@"pid"]intValue]];
                    kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                    kOne.pages=[k objectForKey:@"pages"];
                    
                    kOne.name=[k objectForKey:@"title"];
                    [[NSManagedObjectContext MR_defaultContext] MR_save];
                    
                }
                else{
                    kOne = [Knowledge MR_createEntity];
                    kOne.id=[NSNumber numberWithInt:[[k objectForKey:@"id"]intValue]];
                    kOne.pid=[NSNumber numberWithInt:[[k objectForKey:@"pid"]intValue]];
                    kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                    kOne.hasdownload = @"0";
                    kOne.pages=[k objectForKey:@"pages"];
                    kOne.name=[k objectForKey:@"title"];
                    [[NSManagedObjectContext MR_defaultContext] MR_save];
                }
                
                
            }
            
            _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAll]];
            
            [_tableKnowledge reloadData];
            
            
            //[Knowledge MR_numberOfEntities];
            //        NSLog(@"%@", [Knowledge MR_numberOfEntities]);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    //不在线
    else
    {
        NSString * sestr = @"hasdownload=1";
        NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
        _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAllWithPredicate:predicate]];
        
    }
    
    
    
   
    
    
    
    
    
    _kindArray=[NSMutableArray arrayWithObjects:@"按产品分类",@"按类型分类" ,nil];
    
    
    
    
    [self loadModel];
    _tableViewKind.separatorColor = [UIColor clearColor];
    _tableViewKind.backgroundColor = [UIColor clearColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (void)loadModel{
    _currentRow =-1;
    _headViewArray = [[NSMutableArray alloc]init ];
    //_kindArray =[NSMutableArray arrayWithArray:[Kind MR_findAll]];
    
    
    for(int i = 0;i< _kindArray.count ;i++)
    {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        //       Knowledge * knowledge = _knowledgeArray[indexPath.row];
        //Kind *kindone= _kindArray[i];
        [headview.backBtn setTitle:_kindArray[i] forState:UIControlStateNormal];
        [headview.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        headview.backBtn.titleLabel.font=[UIFont systemFontOfSize: 24.0];
        UIImageView * imgone =[[UIImageView alloc] initWithFrame:CGRectMake(215, 22 ,35,35)];
        UIImageView * imgone2 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 75  ,850,1)];
        [imgone2 setImage:[UIImage imageNamed:@"横线-短.png"]];
        imgone.tag = 100+i;
        
        [imgone setImage:[UIImage imageNamed:@"箭头2.png"]];
      
        
        [headview addSubview:imgone];
          [headview addSubview:imgone2];
        
        [self.headViewArray addObject:headview];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableViewdelegate&&TableViewdataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_tableViewKind]) {
        HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
        
        return headView.open?60:0;
    }
    return 118;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_tableViewKind]) {
        return 70;
    }
    return -1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:_tableViewKind]) {
        return 0.1;
    }
    return -1;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_tableViewKind]) {
        return [self.headViewArray objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_tableViewKind]) {
        
        int i=0;
        if (section==0) {
             i=2;
        }
        else if (section==1){
        
            i =5;
        
        }
        HeadView* headView = [self.headViewArray objectAtIndex:section];
        return headView.open?i:0;
    }
    else if ([tableView isEqual:_tableKnowledge]) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_tableViewKind]){
        return [self.headViewArray count];
        
    }else if ([tableView isEqual:_tableKnowledge]) {
        
        return [_knowledgeArray count];
    }
    
    return [self.knowledgeArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableViewKind]){
        
        static NSString *indentifier = @"kindCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] ;
            UIButton* backBtn=  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 340, 45)];
            backBtn.tag = 20000;
           // [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_on"] forState:UIControlStateHighlighted];
            backBtn.userInteractionEnabled = NO;
            [cell.contentView addSubview:backBtn];
            
            
            UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 340, 1)];
           line.backgroundColor = [UIColor grayColor];
        
            [cell.contentView addSubview:line];
            
            
        }
        UIButton* backBtn = (UIButton*)[cell.contentView viewWithTag:20000];
        HeadView* view = [self.headViewArray objectAtIndex:indexPath.section];
        //[backBtn setBackgroundImage:[UIImage imageNamed:@"btn_2_nomal"] forState:UIControlStateNormal];
        
        if (view.open) {
            if (indexPath.row == _currentRow) {
              
               // [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            }
        }
        
        
        if(indexPath.section==1)
        {
            
            Kind *kindone=[Kind MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLong:indexPath.row+1]];
            cell.textLabel.text= kindone.name;
            cell.textLabel.font=[UIFont systemFontOfSize:20];
            cell.textLabel.textAlignment= UITextAlignmentCenter;
            
            
        }
        else if(indexPath.section==0){
            Product *productone=[Product MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithLong:indexPath.row+1]];
            cell.textLabel.text= productone.name;
            cell.textLabel.font=[UIFont systemFontOfSize:20];
             cell.textLabel.textAlignment= UITextAlignmentCenter;
            
        }
        
        //    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
       
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor=[UIColor clearColor];
        
        
        return cell;
    }
    else if ([tableView isEqual:_tableKnowledge]) {
        
        
        NSDictionary * kindarr = [NSDictionary dictionaryWithObjectsAndKeys:@"说明书",@"1",@"DA",@"2",@"科室会",@"3",@"文献解读",@"4",@"其他",@"5", nil];
        
        NSDictionary * productarr = [NSDictionary dictionaryWithObjectsAndKeys:@"固尔苏",@"1",@"倍优诺",@"2", nil];
        
        static NSString *CellIdentifier = @"KnowledgeCell";
        KnowledgeTableViewCell *cell = (KnowledgeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[KnowledgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
      
    
        
        Knowledge * knowledge = _knowledgeArray[indexPath.section];
        
        
//        NSLog(@"%ld",(long)indexPath.section);
//        NSLog(@"%@",knowledge.kid);
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//
        

            cell.ib.text =[NSString stringWithFormat:@"%ld",(long)indexPath.section];
        cell.ib.hidden = YES;
      //      NSLog(@"=================||||||||||");
//        }
        
        cell.knowledgeText.text = knowledge.name;
        cell.lb.text = [NSString stringWithFormat:@"%@",knowledge.id];
        
        cell.lb.hidden = YES;
        
        cell.kindText.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.kid] ];
        cell.prodect.text= [productarr objectForKey: [numberFormatter stringFromNumber:knowledge.pid] ];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.act.hidden=YES;
        
//     cell.loop = [SDRotationLoopProgressView progressView];
//        
//        cell.loop.frame =CGRectMake(458, 19,68, 79);
//        cell.loop.hidden=YES;
//        
//       // data.length; // 加载进度，当加载完成后会自动隐藏
//        
//        [cell.contentView addSubview:cell.loop];
        if([knowledge.hasdownload isEqualToString:@"1"])
        {
            cell.update.hidden=NO;
            cell.update2.hidden=YES;
            cell.act2.hidden=YES;
            NSLog(@"%@--1>%ld",cell.lb.text,(long)indexPath.section+1);
        }
        else if([knowledge.hasdownload isEqualToString:@"0"])
        {
            cell.update2.hidden=NO;
            cell.update.hidden=YES;
            cell.act2.hidden=YES;
            NSLog(@"%@--0>%ld",cell.lb.text,(long)indexPath.section+1);
        }else
        {
            cell.update2.hidden=YES;
            cell.update.hidden=YES;
            cell.act2.hidden=NO;
            
            [cell.act2 startAnimation];
            NSLog(@"%@--2>%ld",cell.lb.text,(long)indexPath.section+1);
        }
     
        
             return cell;
    }
    


    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_tableViewKind]){
        
         NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
        if(indexPath.section==1)
        {
            
           
            if ([[online objectForKey:@"online"]isEqualToString:@"1"])
            {
                NSArray *kid   = [Knowledge MR_findByAttribute:@"kid" withValue:[NSNumber numberWithLong:indexPath.row+1]];
                _knowledgeArray= [NSMutableArray arrayWithArray:kid];
            }
            else
            {
                NSString * sestr = [NSString stringWithFormat:@"hasdownload=1 AND kid=%ld", indexPath.row+1];
                NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
                _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAllWithPredicate:predicate]];
            }
            
            
            
            
            
            

            
            
        }
        else if(indexPath.section==0){
            
            if ([[online objectForKey:@"online"]isEqualToString:@"1"])
            {
                NSArray *kid   = [Knowledge MR_findByAttribute:@"pid" withValue:[NSNumber numberWithLong:indexPath.row+1]];
                _knowledgeArray= [NSMutableArray arrayWithArray:kid];
            }
            else
            {
                NSString * sestr = [NSString stringWithFormat:@"hasdownload=1 AND pid=%ld", indexPath.row+1];
                NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
                _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAllWithPredicate:predicate]];
            }
//            NSArray *pid   = [Knowledge MR_findByAttribute:@"pid" withValue:[NSNumber numberWithLong:indexPath.row+1]];
//            _knowledgeArray= [NSMutableArray arrayWithArray:pid];
            
        }
        
        //    _currentRow = indexPath.row;
        //    NSArray *personsAgeEuqals25   = [Knowledge MR_findByAttribute:@"kid" withValue:[NSNumber numberWithInt:1]];
        
        
        [_tableKnowledge reloadData];
    }
//    if ([tableView isEqual:_tableKnowledge]) {
//        
//        int i=1;
//        //[online setObject:@"1" forKey:@"online"];
//        
//    }
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"showDetail"])
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
    if ([segue.identifier isEqualToString:@"update"]) {
        
       
        if(version<8.0){

       
         KnowledgeTableViewCell * cell = (KnowledgeTableViewCell *)[[[sender superview] superview] superview];
//        NSLog(@"%@",cell.lb);
        
        Knowledge *kOne=[Knowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
//        Knowledge *name=[Knowledge MR_findFirstByAttribute:@"name" withValue:cell.knowledgeText.text];
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
            
            
            KnowledgeTableViewCell * cell = (KnowledgeTableViewCell *)[[sender superview] superview] ;
            //        NSLog(@"%@",cell.lb);
            
            Knowledge *kOne=[Knowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithFloat:[cell.lb.text floatValue]]];
            //        Knowledge *name=[Knowledge MR_findFirstByAttribute:@"name" withValue:cell.knowledgeText.text];
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
     if([segue.identifier isEqualToString:@"showDetail"]) {

         
      //  NSMutableDictionary *dict ;
        NSIndexPath *indexPath;
        
        indexPath=[_tableKnowledge indexPathForSelectedRow];
//        NSLog(@"%ld",(long)indexPath.section);
        Knowledge * knowledge = _knowledgeArray[indexPath.section];
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
         
      
//         [view setHidesBottomBarWhenPushed:YES];//加上这句就可以把推出的ViewController隐藏Tabbar
//         [self.navigationController pushViewController:view animated:YES];

//        view.imageArray=_images;
       // NSLog(@"--------------%@",view.data);
        
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
        
        [_tableViewKind reloadData];
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
            
//
           // _jiantou=[[UIImageView alloc] initWithFrame:CGRectMake(215, 22 ,35,35)];
            UIImageView * imgone = [head viewWithTag:(100+i)];
            
            [imgone setImage:[UIImage imageNamed:@"箭头1.png"]];

           // [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            
        }else {
           // [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
//            _jiantou2.hidden=YES;
//            _jiantou.hidden=NO;
            UIImageView * imgone = [head viewWithTag:(100+i)];
            
            [imgone setImage:[UIImage imageNamed:@"箭头2.png"]];
//            _jiantou=[[UIImageView alloc] initWithFrame:CGRectMake(215, 22 ,35,35)];
//            [_jiantou2 setImage:[UIImage imageNamed:@"箭头2.png"]];
//           [head addSubview:_jiantou];
            head.open = NO;
        }
        
    }
    [_tableViewKind reloadData];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//下载zip
- (IBAction)update:(id)sender {
    
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    if ([[online objectForKey:@"online"]isEqualToString:@"0"]) {
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请切换在线状态" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        
        
    
    }
    else{

      {
          
          double version = [[UIDevice currentDevice].systemVersion doubleValue];
          if(version<8.0){
              
          
    
              KnowledgeTableViewCell * cell = (KnowledgeTableViewCell *)[[[sender superview] superview] superview];
              
              //NSLog(@"%ld",(long)cell.update.tag);
              
              
              Knowledge *kOne=[Knowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithInt:[cell.lb.text intValue]]];
              //        NSLog(@"%@",kOne.hasdownload);
              
              
              
              
              
              int index1 =[cell.ib.text intValue];
              
              cell.update2.hidden = YES;
              cell.act2.hidden=NO;
              
              kOne.hasdownload=@"2";
              [[NSManagedObjectContext MR_defaultContext] MR_save];
              
              
              
              //                  _knowledgeArray[[cell.ib.text intValue]] =kOne;
              //                  for(int i = 0; i<[_knowledgeArray count];i++)
              //                  {
              //                      Knowledge * kkone = _knowledgeArray[i];
              //                      if([kkone.id intValue]==[cell.lb.text intValue])
              //                      {
              //                          kkone.hasdownload = @"2";
              //                          _knowledgeArray[i]=kkone;
              //                          NSLog(@"=======%d=======>%d",i,[kkone.id intValue]-1);
              //                      }
              //                  }
              
              
              
              
              [cell.act2 startAnimation];
              
              
              //下载
              dispatch_queue_t queue = dispatch_get_global_queue(
                                                                 DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
              
              
              dispatch_async(queue, ^{
                  cell.update2.hidden = YES;
                  NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
                  NSString*string=[url objectForKey:@"string"];
                  NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/knfiles/%@.zip",string,cell.lb.text]];
                  NSError *error = nil;
                  NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
                  // SDPieLoopProgressView * loop2 = (SDPieLoopProgressView *)[cell viewWithTag:109];
                  //
                  ///
                  //
                  //
                  //........
                  //
                  
                  
                  
                  
                  
                  if(!error)
                  {
                      
                      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                      NSString *path = [paths objectAtIndex:0];
                      
                      NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                      NSString *path2 = [paths2 objectAtIndex:0];
                      
                      NSFileManager *fileManager = [NSFileManager defaultManager];
                      
                      NSString * zipstr = [ NSString stringWithFormat:@"konFile_knfiles_%@",cell.lb.text];
                      NSString *testDirectory = [path stringByAppendingPathComponent:@"konFile"];
                      NSString *testDirectory2 = [path2 stringByAppendingPathComponent:@"konFile"];
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
                                  
                                  //                                      [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressSimulation2:) userInfo:cell repeats:YES];
                                  
                                  //下载完成
                                  //                                      cell = [_tableKnowledge cellForRowAtIndexPath:(NSIndexPath *)]
                                  
                                  //                                      cell.act2.hidden=YES;
                                  //                                      [cell.act2 stopAnimation];
                                  //                                      cell.update.hidden=NO;
                                  kOne.hasdownload = @"1";
                                  
                                  _knowledgeArray[index1] =kOne;
                                  
                                  [[NSManagedObjectContext MR_defaultContext] MR_save];
                                  
                                  
                                  [_tableKnowledge reloadData];
                                  [self  wancheng];
                                  
                                  
                                  //                                      _knowledgeArray[[cell.lb.text intValue]-1]=kOne;
                                  
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
          else{
          
              {
                  
                  
                  
                  KnowledgeTableViewCell * cell = (KnowledgeTableViewCell *)[[sender superview] superview];
                  
                  //NSLog(@"%ld",(long)cell.update.tag);
                  
                  
                  Knowledge *kOne=[Knowledge MR_findFirstByAttribute:@"id" withValue:[NSNumber numberWithInt:[cell.lb.text intValue]]];
                  //        NSLog(@"%@",kOne.hasdownload);
                  
                  
                  
                  
                  
                  int index1 =[cell.ib.text intValue];
                  
                  cell.update2.hidden = YES;
                  cell.act2.hidden=NO;
                  
                  kOne.hasdownload=@"2";
                  [[NSManagedObjectContext MR_defaultContext] MR_save];
                  
                  
                  
//                  _knowledgeArray[[cell.ib.text intValue]] =kOne;
//                  for(int i = 0; i<[_knowledgeArray count];i++)
//                  {
//                      Knowledge * kkone = _knowledgeArray[i];
//                      if([kkone.id intValue]==[cell.lb.text intValue])
//                      {
//                          kkone.hasdownload = @"2";
//                          _knowledgeArray[i]=kkone;
//                          NSLog(@"=======%d=======>%d",i,[kkone.id intValue]-1);
//                      }
//                  }
                  
                  
                  
                  
                  [cell.act2 startAnimation];
                  
                  
                  //下载
                  dispatch_queue_t queue = dispatch_get_global_queue(
                                                                     DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                  
                  
                  dispatch_async(queue, ^{
                      cell.update2.hidden = YES;
                      NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
                      NSString*string=[url objectForKey:@"string"];
                      NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat: @"%@/kaixi/knfiles/%@.zip",string,cell.lb.text]];
                      NSError *error = nil;
                      NSData *data = [NSData dataWithContentsOfURL:urls options:0 error:&error];
                      // SDPieLoopProgressView * loop2 = (SDPieLoopProgressView *)[cell viewWithTag:109];
                      //
                      ///
                      //
                      //
                      //........
                      //
                      
                      
                      
                      
                      
                      if(!error)
                      {
                          
                          NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                          NSString *path = [paths objectAtIndex:0];
                          
                          NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                          NSString *path2 = [paths2 objectAtIndex:0];
                          
                          NSFileManager *fileManager = [NSFileManager defaultManager];
                          
                          NSString * zipstr = [ NSString stringWithFormat:@"konFile_knfiles_%@",cell.lb.text];
                          NSString *testDirectory = [path stringByAppendingPathComponent:@"konFile"];
                            NSString *testDirectory2 = [path2 stringByAppendingPathComponent:@"konFile"];
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
                                      
//                                      [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressSimulation2:) userInfo:cell repeats:YES];
                                      
                                      //下载完成
//                                      cell = [_tableKnowledge cellForRowAtIndexPath:(NSIndexPath *)]
                                      
//                                      cell.act2.hidden=YES;
//                                      [cell.act2 stopAnimation];
//                                      cell.update.hidden=NO;
                                      kOne.hasdownload = @"1";
                                      
                                      _knowledgeArray[index1] =kOne;
                                      
                                      [[NSManagedObjectContext MR_defaultContext] MR_save];
                                      
                                      
                                      [_tableKnowledge reloadData];
                                       [self  wancheng];
                                      
//                                      _knowledgeArray[[cell.lb.text intValue]-1]=kOne;
                                      
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
    
}
//发送邮件
}

//-(void)progressSimulation:(NSTimer *)timer
//{
//    
//    SDPieLoopProgressView * p =(SDPieLoopProgressView *)[(KnowledgeTableViewCell *)[timer userInfo] viewWithTag:109];
//        p.progress+=0.01;
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
//    KnowledgeTableViewCell * cell = [timer2 userInfo];
//    SDPieLoopProgressView * p =(SDPieLoopProgressView *)[(KnowledgeTableViewCell *)[timer2 userInfo] viewWithTag:109];
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
        if(version<8.0){

    KnowledgeTableViewCell * cell = (KnowledgeTableViewCell *)[[[sender superview] superview]superview];
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
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createkemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

    
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
        
            KnowledgeTableViewCell * cell = (KnowledgeTableViewCell *)[[sender superview] superview];
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
            [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=email/createkemail"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
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
//-(void)launchMailAppOnDevice
//{
//    NSString *recipients = @"mailto:first@example.com&subject=my email!";
//    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
//    NSString *body = @"&body=email body!";
//    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
//    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
//}
//- (void)mailComposeController:(MFMailComposeViewController *)controller
//          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//{
//    NSString *msg;
//    switch (result)
//    {
//        case MFMailComposeResultCancelled:
//            msg = @"邮件发送取消";
//            break;
//        case MFMailComposeResultSaved:
//            msg = @"邮件保存成功";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        case MFMailComposeResultSent:
//            msg = @"邮件发送成功";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        case MFMailComposeResultFailed:
//            msg = @"邮件发送失败";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        default:
//            break;
//    }
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
//                                                    message:msg
//                                                   delegate:nil
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}

#pragma UISearchDisplayDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
//    _mySearchBar.text;
    
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    NSString * sestr = [NSString stringWithFormat:@"name LIKE[cd] '*%@*'",_mySearchBar.text];
        if ([[online objectForKey:@"online"]isEqualToString:@"0"])
        {
            sestr = [NSString stringWithFormat:@"hasdownload=1 AND name LIKE[cd] '*%@*'", _mySearchBar.text];
        }
    
//    NSString * sestr = [NSString stringWithFormat:@"name LIKE[cd] '*%@*'",_mySearchBar.text];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:sestr];
    
    _knowledgeArray = [NSMutableArray arrayWithArray:[Knowledge MR_findAllWithPredicate:predicate]];
    [_tableKnowledge reloadData];
//    int theCount = [Knowledge MR_countOfEntitiesWithPredicate:predicate];
//    NSLog(@"%d",theCount);
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

//-(void)handleSearchForTerm:(NSString *)searchterm{
//
//    
//}
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
