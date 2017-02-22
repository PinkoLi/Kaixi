//
//  UserInfoViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/5.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "RespForWeChatViewController.h"
@protocol sendMsgToWeChatViewDelegate <NSObject>


@end
@interface UserInfoViewController : UIViewController<WXApiDelegate,sendMsgToWeChatViewDelegate,RespForWeChatViewDelegate>{
 enum WXScene _scene;
}
- (void) sendImageContent;
- (void) changeScene:(NSInteger)scene;


@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *account;
@property (strong, nonatomic) IBOutlet UILabel *large;
@property (strong, nonatomic) IBOutlet UILabel *area;
@property (strong, nonatomic) IBOutlet UILabel * highScore;
@property (strong, nonatomic) IBOutlet UILabel *surplusScore;
@property (strong, nonatomic) IBOutlet UILabel *countryRanking;
@property (strong, nonatomic) IBOutlet UILabel *areaRanking;
- (IBAction)xuanyao:(id)sender;

@end
