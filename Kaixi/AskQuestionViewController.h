//
//  AskQuestionViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/13.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"
#import "LMContainsLMComboxScrollView.h"
#import "DropDownChooseProtocol.h"
@interface AskQuestionViewController : UIViewController<LMComBoxViewDelegate,DropDownChooseDelegate,DropDownChooseDataSource,UITextViewDelegate>{

    LMContainsLMComboxScrollView *bgScrollView;
    LMComBoxView *comBox;

}
@property (strong, nonatomic) NSString *renshi;
@property(strong ,nonatomic )NSMutableArray*chooseArray;


- (IBAction)post:(id)sender;
@property (strong, nonatomic)  UIImageView *image;
@property (strong, nonatomic)UITextView*textView;
@end
