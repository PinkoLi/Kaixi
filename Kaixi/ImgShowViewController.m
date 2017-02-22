//
//  ImgShowViewController.m
//  Project-Movie
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import "ImgShowViewController.h"
#import "MRImgShowView.h"

@interface ImgShowViewController ()

@end

@implementation ImgShowViewController

- (id)initWithSourceData:(NSMutableArray *)data withIndex:(NSInteger)index{
    
    self = [super init];
    if (self) {
        [self init];
        _data = [data retain];
        _index = index;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc{
    
    [_data release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"图片列表";
    
    //设置导航栏为半透明
    self.navigationController.navigationBar.translucent = YES;
    // 隐藏标签栏
    self.tabBarController.tabBar.hidden = YES;

    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
//    // 添加导航栏退回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
//
   // StudyImageViewController*view;
    
//    NSLog(@"%@",_tag);
     if([_tag isEqualToString:@"3"]) {
         NSLog(@"hhhhhhhhhhhhh");
     }else{
     
         UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"保存至相册" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
         self.navigationItem.rightBarButtonItem = share;
         [share release];
     }
   
    
    [backItem release];
    
    
    [self creatImgShow];
}

// 初始化视图
- (void)creatImgShow{
    
    MRImgShowView *imgShowView = [[MRImgShowView alloc]
                                  initWithFrame:self.view.frame
                                    withSourceData:_data
                                    withIndex:_index];
    imgShowView.tag = 1001;
    // 解决谦让
    [imgShowView requireDoubleGestureRecognizer:[[self.view gestureRecognizers] lastObject]];
    
    
    [self.view addSubview:imgShowView];
}

#pragma mark -UIGestureReconginzer
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 隐藏导航栏
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    }];

}

#pragma mark -NavAction
- (void)backAction{
    
    _data=nil;
    [_data1.imgList removeAllObjects];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"排名1(1)" ofType:@"jpg"];
    NSLog(@"filepath :%@",filePath);
    
   
    MRImgShowView *imgShowView = (MRImgShowView *)[self.view viewWithTag:1001];
    
    
//    ext.imageData = imgShowView.imgSource[imgShowView.curIndex];//[NSData dataWithContentsOfFile:filePath];
//    
//    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
//    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(imgShowView.imgSource[imgShowView.curIndex]);
    
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


-(void)shareAction{
    
    MRImgShowView *imgShowView = (MRImgShowView *)[self.view viewWithTag:1001];
    
    
    
   
  UIImageWriteToSavedPhotosAlbum(imgShowView.imgSource[imgShowView.curIndex], self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);


}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        [alert show];

    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
