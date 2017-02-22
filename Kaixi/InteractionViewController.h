//
//  InteractionViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/23.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import "HeadView.h"
@interface InteractionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,HeadViewDelegate>{

    NSInteger _currentSection;
    NSInteger _currentRow;
}
@property (strong, nonatomic) IBOutlet UITableView *leftTable;
@property(nonatomic, strong) NSMutableArray* headViewArray;
@property (strong, nonatomic) IBOutlet UITableView *rightTable;


@property(nonatomic, strong) NSMutableArray* interactionListArray;
@property(nonatomic, strong) NSMutableArray* interactionInfoArray;

@end
