//
//  MedicalKnowledgeLearningViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/14.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import <MessageUI/MessageUI.h>
@interface MedicalKnowledgeLearningViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate,MFMailComposeViewControllerDelegate,UISearchBarDelegate>{
    
    NSInteger _currentSection;
    NSInteger _currentRow;
}
@property (strong, nonatomic) IBOutlet UITableView *leftTable;
@property (strong, nonatomic) IBOutlet UITableView *rightTable;

@property(nonatomic, strong) NSMutableArray* leftArray;
@property(nonatomic, strong) NSMutableArray* headViewArray;
@property(nonatomic, strong)NSString*tag2;
@property(nonatomic, strong) NSMutableArray* mKindArray;
@property(nonatomic, strong) NSMutableArray* mProducteArray;
@property(nonatomic, strong) NSMutableArray* mKnowledgeArray;
- (IBAction)update:(id)sender;
@property(nonatomic, strong)UIImageView*jiantou;

- (IBAction)sendMessage:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearch;
@property(nonatomic, strong)NSMutableArray *images;
@end
