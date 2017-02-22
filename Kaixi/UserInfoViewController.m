//
//  UserInfoViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/5.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfo.h"
#import "UIImage+WaterMark.h"
#import "wiUIImage+Category.h"
#import "wiUIImageView+Category.h"
#import "APService.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserInfo.h"
#import "LXF_OpenUDID.h"
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   UserInfo*userInfo=[UserInfo MR_findFirst];
    _name.text=userInfo.name;
    _account.text=userInfo.account;
    _large.text=userInfo.large;
    _area.text=userInfo.area;
    _highScore.text=[NSString stringWithFormat:@"%@",userInfo.highScore];
    _countryRanking.text=[NSString stringWithFormat:@"%@",userInfo.countryRanking];
    _surplusScore.text=[NSString stringWithFormat:@"%@",userInfo.surplusScore];
    _areaRanking.text=[NSString stringWithFormat:@"%@",userInfo.areaRanking];
    
    NSLog(@"%@",userInfo.offpw);
    
      [self getAppKey];
    
    
    
    // Do any additional setup after loading the view.
}
//获取appKey
- (NSString *)getAppKey {
    NSURL *urlPushConfig = [[[NSBundle mainBundle] URLForResource:@"PushConfig"
                                                    withExtension:@"plist"] copy];
    NSDictionary *dictPushConfig =
    [NSDictionary dictionaryWithContentsOfURL:urlPushConfig];
    
    if (!dictPushConfig) {
        return nil;
    }
    
    // appKey
    NSString *strApplicationKey = [dictPushConfig valueForKey:(@"APP_KEY")];
    if (!strApplicationKey) {
        return nil;
    }
    
    return [strApplicationKey lowercaseString];
}


- (void)dealloc {
    [self unObserveAllNotifications];
}

- (void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
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


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
        
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
      
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, msg.thumbData.length, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
      
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
        WXMediaMessage *msg = temp.message;
        
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
     
    }
}
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
     
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        AddCardToWXCardPackageResp* temp = (AddCardToWXCardPackageResp*)resp;
        NSMutableString* cardStr = [[NSMutableString alloc] init] ;
        for (WXCardItem* cardItem in temp.cardAry) {
            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%lu\n",cardItem.cardId,cardItem.extMsg,cardItem.cardState]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}


- (void) sendImageContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *ext = [WXImageObject object];
    //[message setThumbImage:[UIImage imageNamed:@"res5thumb.png"]];
    
//    NSDictionary * imgstr = [NSDictionary dictionaryWithObjectsAndKeys:@"排名1(1).jpg",@"1",@"排名3(1).jpg",@"2",@"排名3(1).jpg",@"3", nil];
    
   // NSArray * imgstr = [NSArray arrayWithObjects:@"排名1(1)",@"排名2(1)",@"排名3(1)", nil];
    
    //int i = (random() % 3);
    
    UIImage* image=[UIImage imageNamed:@"登录界面-14.jpg"];
     UIImage* image2=[UIImage imageNamed:@"登录界面-15.jpg"];
     UIImage* image3=[UIImage imageNamed:@"登录界面-16.jpg"];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:imgstr[i] ofType:@"jpg"];
//    UIImage* image=[UIImage imageNamed:filePath];
    
    
    image = [image imageWithStringWaterMark:_countryRanking.text atPoint:CGPointMake(200,120) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:34]];
     image2 = [image2 imageWithStringWaterMark:_countryRanking.text atPoint:CGPointMake(200,120) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:34]];
    image3 = [image3 imageWithStringWaterMark:_countryRanking.text atPoint:CGPointMake(200,115) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:34]];
   
     int i = (random() % 3);
      NSArray * img = [NSArray arrayWithObjects:image,image2,image3, nil];
    //ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    //UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(img[i]);
    
    //    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    //    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void) changeScene:(NSInteger)scene{
    _scene = scene;
}


- (IBAction)xuanyao:(id)sender {
      [self sendImageContent];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSString *openUDID = [LXF_OpenUDID value];
    NSDictionary *parameters =@{@"udid":openUDID};
    
    
    NSLog(@"parm =  %@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    NSLog(@"%@",string);
    [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/fenxiangwx"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"isok"] intValue]==1) {
            
            //
            //            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已发送邮件至邮箱请查收" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            //
            //
            //           [ alert show];
            
            
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_save];
            
            
            
            NSLog(@"增加分数咯！！！");
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        NSLog(@"Error: %@", error);
    }];

}
@end
