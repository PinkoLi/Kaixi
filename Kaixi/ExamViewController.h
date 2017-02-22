//
//  ExamViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/3.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"
@protocol sendMsgToWeChatViewDelegate <NSObject>

@end
@interface ExamViewController : UIViewController<WXApiDelegate,sendMsgToWeChatViewDelegate>
{
    enum WXScene _scene;
}
- (void) sendImageContent;
- (void) changeScene:(NSInteger)scene;


@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;

- (IBAction)share:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *fen;
@property (strong, nonatomic) IBOutlet UILabel *totalnum;
@property (strong, nonatomic) IBOutlet UILabel *paiming;
@property (strong, nonatomic)NSString*fent;
@property (strong, nonatomic)NSString*totalnumt;
@property (strong, nonatomic)NSString*paimingt;

@end
