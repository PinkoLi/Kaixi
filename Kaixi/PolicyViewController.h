//
//  PolicyViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/20.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
@interface PolicyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *leftTable;

@property (strong, nonatomic) IBOutlet UITableView *rightTable;


@property(nonatomic, strong) NSMutableArray* policyListArray;
@property(nonatomic, strong) NSMutableArray* policyInfoArray;

@property(nonatomic, strong)NSString*tag2;
- (IBAction)sendMessage:(id)sender;
@property(nonatomic, strong)NSMutableArray *images;
- (IBAction)update:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearch;
@end
