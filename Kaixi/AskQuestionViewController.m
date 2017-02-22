//
//  AskQuestionViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/13.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "AskQuestionViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "DropDownListView.h"
#import "LXF_OpenUDID.h"
@interface AskQuestionViewController ()

@end

@implementation AskQuestionViewController
#define kDropDownListTag 1000
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,1024, 768)];
    [_image setImage:[UIImage imageNamed: @"互动与交流2.jpg"]];
    [self.view addSubview:_image];
    
   
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(248, 320,600, 304)];
    _textView.delegate=self;
    _textView.layer.borderColor = UIColor.grayColor.CGColor;
    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 6;
    _textView.layer.masksToBounds = NO;
      _textView.font=[UIFont systemFontOfSize:20];
    
    
    [self.view addSubview:_textView];
    
    bgScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(260,150,180, 120)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    
   
    
   // _chooseArray=[[NSMutableArray alloc]init];
    _chooseArray=[NSMutableArray arrayWithObjects:@"学术信息",@"凯西政策",nil];
      _renshi = @"学术信息";
    
    //defaultIndex
    
    //    NSInteger i=0;
    comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
    comBox.backgroundColor = [UIColor whiteColor];
    comBox.arrowImgName = @"xialak-01.jpg";
    NSMutableArray *itemsArray =_chooseArray;
    
    comBox.titlesList = itemsArray;
    comBox.delegate = self;
    comBox.supView = bgScrollView;
    [comBox defaultSettings];
    comBox.tag = kDropDownListTag + 0;
    [bgScrollView addSubview:comBox];
    [self.view addSubview:bgScrollView];
    //[_image addSubview:comBox];
   
    
  
  
   
    
    

}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version<8.0){
        if(self.interfaceOrientation==UIDeviceOrientationLandscapeLeft){
            self.view.frame = CGRectMake(self.view.frame.origin.x+210, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
            
        }  else{
            self.view.frame = CGRectMake(self.view.frame.origin.x-210, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }else{
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-210 , self.view.frame.size.width, self.view.frame.size.height);
    }
    //设置动画结束
    [UIView commitAnimations];
}
//在UITextField 编辑完成调用方法
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    //    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    //    if(version<8.0){
    //        self.view.frame = CGRectMake(self.view.frame.origin.x+215, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version<8.0){
        if(self.interfaceOrientation==UIDeviceOrientationLandscapeLeft){
            self.view.frame = CGRectMake(self.view.frame.origin.x-210, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
            
        }  else{
            self.view.frame = CGRectMake(self.view.frame.origin.x+210, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }
    else{
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+210 , self.view.frame.size.width, self.view.frame.size.height);
    }
    //设置动画结束
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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



- (IBAction)post:(id)sender {
    NSLog(@"%ld", comBox.defaultIndex2);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *openUDID = [LXF_OpenUDID value];
    
    
    NSDictionary *parameters =@{@"udid":openUDID,@"tag":[NSString stringWithFormat:@"%ld",comBox.defaultIndex2]  ,@"content":_textView.text};
    
    NSLog(@"%@",parameters);
    NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
    NSString*string=[url objectForKey:@"string"];
    
    NSLog(@"parm =  %@",parameters);
    [manager POST:[string stringByAppendingString: @"/kaixi/index.php?r=jh/postjh"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSLog(@"===================%@",responseObject);
        
        if ([_textView.text length] == 0) {
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的问题" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            
            
            [alert show];
        }
        else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的问题已提交后台，待审批通过后，将会进行发布。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        
        
        [alert show];
        _textView.text=NO;
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
@end
