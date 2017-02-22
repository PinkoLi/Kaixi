//
//  ShuoMingShuViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/3/20.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ShuoMingShuViewController.h"
#import "ShuoMing.h"

#import "ShuoMingShuTableViewCell.h"


#import "LXF_OpenUDID.h"
#import "StudyImageViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface ShuoMingShuViewController ()

@end

@implementation ShuoMingShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tag2=@"5";
    _leftTable.backgroundColor=[UIColor clearColor];
    _rightTable.backgroundColor=[UIColor clearColor];
    _rightTable.separatorColor=[UIColor clearColor];
    _leftTable.separatorColor=[UIColor clearColor];
    _policyInfoArray= [[NSMutableArray alloc]init];
    _images= [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    [manager GET:[string stringByAppendingString: @"/kaixi/index.php?r=yxknowledge/xxknowledgelist"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        _knowledgeArray = responseObject;
        
        for (NSDictionary*k in responseObject) {
            
            ShuoMing *kOne=[ShuoMing MR_findFirstByAttribute:@"id" withValue:[k objectForKey:@"id"]];
            if (kOne) {
                //kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                //kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mkid"]intValue]];
                kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
                
            }
            else{
                kOne = [ShuoMing MR_createEntity];
                kOne.id=[NSNumber numberWithInt:[[k objectForKey:@"id"]intValue]];
                //  kOne.mpid=[NSNumber numberWithInt:[[k objectForKey:@"mpid"]intValue]];
                //kOne.kid=[NSNumber numberWithInt:[[k objectForKey:@"kid"]intValue]];
                kOne.hasdownload = @"0";
                kOne.pages=[k objectForKey:@"pages"];
                kOne.name=[k objectForKey:@"title"];
                [[NSManagedObjectContext MR_defaultContext] MR_save];
            }
            
            
        }
        
        _policyInfoArray = [NSMutableArray arrayWithArray:[ShuoMing MR_findAll]];
        [_rightTable reloadData];
        
        
        //[Knowledge MR_numberOfEntities];
        NSLog(@"%@", [ShuoMing MR_numberOfEntities]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
       return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _policyInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
        
        
    
    static NSString *CellIdentifier = @"rightCell";
    ShuoMingShuTableViewCell *cell = (ShuoMingShuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShuoMingShuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    ShuoMing * knowledge = _policyInfoArray[indexPath.section];
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    //
    cell.title.text = knowledge.name;
    cell.lb.text = [NSString stringWithFormat:@"%@",knowledge.id];
    cell.lb.hidden = YES;
   // cell.prodect.text= [kindarr objectForKey:[numberFormatter stringFromNumber:knowledge.kid] ];
    //cell.kidLb.text= [productarr objectForKey: [numberFormatter stringFromNumber:knowledge.mpid] ];
    cell.backgroundColor=[UIColor clearColor];
    
    
    return cell;
    
    
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
        if ([segue.identifier isEqualToString:@"shuoming"]) {
        
        //  NSMutableDictionary *dict ;
        NSIndexPath *indexPath;
        
        indexPath=[_rightTable indexPathForSelectedRow];
        //        NSLog(@"%ld",(long)indexPath.section);
        ShuoMing * knowledge = _policyInfoArray[indexPath.section];
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
