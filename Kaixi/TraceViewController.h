//
//  TraceViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/2.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

@property(nonatomic, strong)NSMutableArray *images;
@property(nonatomic, strong)NSString*tag2;
@property(nonatomic, strong) NSMutableArray* traceArray;
- (IBAction)update:(id)sender;
- (IBAction)sendMessage:(id)sender;
@end
