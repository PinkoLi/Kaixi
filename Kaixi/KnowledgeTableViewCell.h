//
//  KnowledgeTableViewCell.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/9.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDProgressView.h"
#import "MRActivityIndicatorView.h"
#import "GPLoadingView.h"
@interface KnowledgeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *knowledgeText;
@property (strong, nonatomic) IBOutlet UIButton *update;
@property (strong, nonatomic) IBOutlet UIButton *sendBth;
@property (strong, nonatomic) IBOutlet UILabel *kindText;
@property (strong, nonatomic) IBOutlet UILabel *prodect;
@property (strong, nonatomic) IBOutlet UILabel *lb;
@property (strong, nonatomic) IBOutlet UIButton *update2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;

@property (strong, nonatomic) IBOutlet GPLoadingView *act2;
@property (strong, nonatomic) IBOutlet UILabel *ib;

//@property (strong, nonatomic)MRActivityIndicatorView*act2;
//@property (weak, nonatomic) IBOutlet MRActivityIndicatorView *act2;
@property (strong, nonatomic)SDRotationLoopProgressView*loop;
@end
