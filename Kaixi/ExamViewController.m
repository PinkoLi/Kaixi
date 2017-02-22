//
//  ExamViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/3.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "ExamViewController.h"
#import "UIImage+WaterMark.h"
#import "wiUIImage+Category.h"
#import "wiUIImageView+Category.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserInfo.h"
#import "LXF_OpenUDID.h"
@interface ExamViewController ()

@end

@implementation ExamViewController
@synthesize delegate = _delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    _fen.text=_fent;
    _totalnum.text=_totalnumt;
    _paiming.text=_paimingt;
     NSLog(@"%@%@%@",_fent,_totalnumt,_paimingt);
    NSLog(@"%@%@%@",_fen.text,_totalnum.text,_paiming.text);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        
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
}


- (void) sendImageContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"res5thumb.png"]];
    
    WXImageObject *ext = [WXImageObject object];
   // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"考试通过" ofType:@"png"];
   
   
    
    UIImage* image = [UIImage imageNamed:@"考试通过.png"];
     image = [image imageWithStringWaterMark:_totalnum.text atPoint:CGPointMake(218,303) color:[UIColor redColor] font:[UIFont systemFontOfSize:34]];
    image = [image imageWithStringWaterMark:_paiming.text atPoint:CGPointMake(305,368) color:[UIColor redColor] font:[UIFont systemFontOfSize:34]];
    image = [image imageWithStringWaterMark:[_fen.text stringByAppendingString:@"分"] atPoint:CGPointMake(230,130) color:[UIColor redColor] font:[UIFont systemFontOfSize:70]];
  //  UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
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

- (IBAction)share:(id)sender {
    
    [self sendImageContent];
     //[_delegate changeScene:WXSceneTimeline];
  
   // [_delegate changeScene:WXSceneTimeline];
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
            
            NSLog(@"增加分数咯！！！");
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        
        NSLog(@"Error: %@", error);
    }];

}

@end
