//
//  StudyAndTestViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import <MessageUI/MessageUI.h>


@interface StudyAndTestViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,HeadViewDelegate,MFMailComposeViewControllerDelegate,UISearchBarDelegate,NSURLConnectionDataDelegate>{

    NSInteger _currentSection;
    NSInteger _currentRow;
     NSMutableArray *searchResults;
}



@property (strong, nonatomic) IBOutlet UITableView *tableViewKind;
@property(nonatomic, strong) NSMutableArray* headViewArray;
@property (strong, nonatomic) IBOutlet UITableView *tableKnowledge;
@property(nonatomic, strong) NSMutableArray* kindArray;
@property(nonatomic, strong) NSMutableArray* producteArray;
@property(nonatomic, strong) NSMutableArray* knowledgeArray;
@property(nonatomic, strong)UIButton*update;
@property(nonatomic, strong)NSMutableArray *images;
@property(nonatomic, strong)NSString*tag2;
@property(nonatomic, strong)UIImageView*jiantou;
@property(nonatomic, strong)UIImageView*jiantou2;

- (IBAction)update:(id)sender;

- (IBAction)sendMessage:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;


@end
