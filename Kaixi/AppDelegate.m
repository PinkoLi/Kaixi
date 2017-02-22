//
//  AppDelegate.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInfo.h"
#import "APService.h"
#import "AFHTTPRequestOperationManager.h"
#import "LXF_OpenUDID.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
    
    

    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
//    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//    
//   
////    NSDictionary *parameters =@{@"udid":openUDID,@"registrationID":userInfo.registrationID};
//    
//    
//   
//    [manager GET:@"http://kx.naturews.com/getvison.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        if (![[responseObject objectForKey:@"version"]isEqualToString:@"1.1"]) {
//            
//            _plistName=[responseObject objectForKey:@"plistname"];
//            
//            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新只需1分钟。强烈建议您立即进行更新，如不更新将影响相关功能使用。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//            alertView.tag=1;
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//        
//        NSLog(@"Error: %@", error);
//    }];
//    
    
 
    

    [self checkvision];



   




    // Override point for customization after application launch.
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model.sqlite"];
    
    [WXApi registerApp:@"wx772c69a86596af01"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//   
    if (![UserInfo MR_countOfEntities]) {
        id view = [storyboard instantiateViewControllerWithIdentifier:@"FirstLoginViewController"];
         self.window.rootViewController = view;
          }
    else{
        id view = [storyboard instantiateViewControllerWithIdentifier:@"SecondLoginViewController"];
        self.window.rootViewController = view;
    
    }
    
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:)name:kJPFNetworkDidRegisterNotification object:nil];

    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==1) {
        if (buttonIndex==0) {
            NSString *urlString = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=https://dn-kxnaturews.qbox.me/%@", _plistName];
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }

}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSDictionary * userInfo = [notification userInfo];
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    NSLog(@"%@",extra);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString* noticeTag=[extra objectForKey:@"noticeTag"];
    
    switch ([noticeTag intValue]) {
    case 1:
        [defaults setObject:@"1" forKey:@"noticeTag1"];
        break;
    case 2:
        [defaults setObject:@"1" forKey:@"noticeTag2"];
        break;
    case 3:
        [defaults setObject:@"1" forKey:@"noticeTag3"];
        break;
    case 4:
        [defaults setObject:@"1" forKey:@"noticeTag4"];
        break;
    case 5:
        [defaults setObject:@"1" forKey:@"noticeTag5"];
        break;
    case 6:
        [defaults setObject:@"1" forKey:@"noticeTag6"];
        break;
    case 7:
        [defaults setObject:@"1" forKey:@"noticeTag7"];
        break;
    case 8:
        [defaults setObject:@"1" forKey:@"noticeTag8"];
        break;
            
    default:
        NSLog(@"expression=default");
        break;
    }
    
    
}

- (void)networkDidRegister:(NSNotification *)notification {
    
    //[[notification userInfo] valueForKey:@"RegistrationID"];
      NSLog(@"%@", [[notification userInfo] valueForKey:@"RegistrationID"]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
    NSLog(@"dfsfsdfs");
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
    NSLog(@"dfdsfsdfsd");
}

//-(void) onResp:(BaseResp*)resp
//{
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//          }
//    NSLog(@"hhhhhhhhh");
//}
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
        NSMutableString* cardStr = [[NSMutableString alloc] init];
        for (WXCardItem* cardItem in temp.cardAry) {
            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%lu\n",cardItem.cardId,cardItem.extMsg,cardItem.cardState]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
       
    }
}

-(void) checkvision{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    
    //    NSDictionary *parameters =@{@"udid":openUDID,@"registrationID":userInfo.registrationID};
    
    
    
    [manager GET:@"http://kx.naturews.com/getvison.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (![[responseObject objectForKey:@"version"]isEqualToString:@"1.170222"]) {
                
            _plistName=[responseObject objectForKey:@"plistname"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新只需1分钟。强烈建议您立即进行更新，如不更新将影响相关功能使用。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            alertView.tag=1;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        NSLog(@"Error: %@", error);
    }];

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
//    if (application.applicationState == UIApplicationStateActive ) {
//        // 程序在运行过程中受到推送通知
//        UILocalNotification *reminder = [[UILocalNotification alloc] init];
//        [reminder setFireDate:[NSDate date]];
//        [reminder setTimeZone:[NSTimeZone localTimeZone]];
//        [reminder setHasAction:YES];
//        [reminder setAlertAction:@"Show"];
//        [reminder setSoundName:UILocalNotificationDefaultSoundName];
//        [reminder setAlertBody:@"message"];
//        [[UIApplication sharedApplication] scheduleLocalNotification:reminder];
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"myapp" message:@"message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show]; 
//        
//    } else {
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    NSString * noticeTag = [userInfo valueForKey:@"noticeTag"];
    NSMutableString * pagename = [[NSMutableString alloc]init];
    
    
    switch ([noticeTag intValue]) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            pagename = [NSMutableString stringWithFormat:@"MenuViewController"];
            break;
        case 6:
        case 7:
        case 8:
            pagename = [NSMutableString stringWithFormat:@"ListViewController"];
            break;
        case 9:
            pagename = [NSMutableString stringWithFormat:@"ViewController"];
            [self checkvision];
            
            break;
            
        default:
            pagename = [NSMutableString stringWithFormat:@"MenuViewController"];
            break;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id view = [storyboard instantiateViewControllerWithIdentifier:pagename];
    self.window.rootViewController = view;
    
    // 取得自定义字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"];
//      NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    NSLog(@"%@",userInfo);
    [APService handleRemoteNotification:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"registrationID============%@",[APService registrationID]);
    // IOS 7 Support Required
    
    if (application.applicationState == UIApplicationStateActive ) {
        // 程序在运行过程中受到推送通知

//        if (![UserInfo MR_countOfEntities]) {
//            
//          //
//        
//        }else{
//        
//            UserInfo * userInfo = [UserInfo MR_findFirst];
//            NSLog(@"%@",userInfo);
//            
//            if([userInfo.registrationID isEqualToString:[APService registrationID]])
//            {
//                
//            }else
//            {
//                userInfo.registrationID=[APService registrationID];
//                
//                [[NSManagedObjectContext MR_defaultContext] MR_save];
//                
//                
//                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//                //NSLog(@"%@%@",self.textView.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneId"]);
//                //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//                
//                NSString *openUDID = [LXF_OpenUDID value];
//                NSDictionary *parameters =@{@"udid":openUDID,@"registrationID":userInfo.registrationID};
//                
//                
//                NSLog(@"parm =  %@",parameters);
//                NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
//                NSString*string=[url objectForKey:@"string"];
//                NSLog(@"%@",string);
//                [manager POST:[string stringByAppendingString:@"/kaixi/index.php?r=user/ridchange"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                    
//
//                    NSLog(@"%@",responseObject);
//                    
//                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    
//
//                    
//                    NSLog(@"Error: %@", error);
//                }];
//                
//                
//                
//                
//            }
//        
//        }
        
    } else {
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    NSString * noticeTag = [userInfo valueForKey:@"noticeTag"];
    NSMutableString * pagename = [[NSMutableString alloc]init];
    
    
    switch ([noticeTag intValue]) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            pagename = [NSMutableString stringWithFormat:@"MenuViewController"];
            break;
        case 6:
        case 7:
        case 8:
            pagename = [NSMutableString stringWithFormat:@"ListViewController"];
            break;
        case 9:
            pagename = [NSMutableString stringWithFormat:@"ViewController"];
            [self checkvision];
            
            break;

        default:
            pagename = [NSMutableString stringWithFormat:@"ViewController"];
            break;
    }
    NSLog(@"%@",pagename);
    
    
    

    //
    // 取得自定义字段内容
    //    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"];
    //      NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    NSLog(@"%@",userInfo);
    [APService handleRemoteNotification:userInfo];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   id view = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@", pagename]];
    //id view = [storyboard instantiateViewControllerWithIdentifier:@"SecondLoginViewController"];
    self.window.rootViewController = view;
    completionHandler(UIBackgroundFetchResultNewData);
    }
}
@end
