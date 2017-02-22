//
//  NoticeHistoryViewController.m
//  Kaixi
//
//  Created by ck on 15-4-1.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "NoticeHistoryViewController.h"
#import "NoticeHistoryTableViewCell.h"
#import "NSInfoViewController.h"

#import "LXF_OpenUDID.h"

#import "AFHTTPRequestOperationManager.h"
@interface NoticeHistoryViewController ()

@end

@implementation NoticeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nhArray=[[NSMutableArray alloc]init];
    _table.backgroundColor=[UIColor clearColor];
     _table.separatorColor = [UIColor clearColor];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=notice/getall"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
        
        //_nhArray=[responseObject objectForKey:@"title"];
       
            _nhArray=responseObject;
       
        
        NSLog(@"==========%@",_nhArray);
                
        
            
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _nhArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    static NSString *CellIdentifier = @"Cell";
    NoticeHistoryTableViewCell *cell = (NoticeHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NoticeHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
   
    //
   
    cell.title.text = [_nhArray[indexPath.section]objectForKey:@"title" ];
   cell.time.text = [_nhArray[indexPath.section]objectForKey:@"time" ];
    // cell.prodect.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.kid] ];
    //cell.kidLb.text= [productarr objectForKey: [numberFormatter stringFromNumber:knowledge.mpid] ];
    cell.backgroundColor=[UIColor clearColor];
    
    
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
        view.time = [_nhArray[indexPath.section]objectForKey:@"time" ];
        
        //        view.imageArray=_images;
        // NSLog(@"--------------%@",view.data);
        
        
        
    }
    
    
    
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

@end
