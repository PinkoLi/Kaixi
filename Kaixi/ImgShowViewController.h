//
//  ImgShowViewController.h
//
//  图片展示控件
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyImageViewController.h"

#import "WXApiObject.h"
#import "WXApi.h"
@protocol sendMsgToWeChatViewDelegate <NSObject>
@end
@interface ImgShowViewController : UIViewController<WXApiDelegate,sendMsgToWeChatViewDelegate>{
    enum WXScene _scene;
}
- (void) sendImageContent;
- (void) changeScene:(NSInteger)scene;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
@property(nonatomic ,assign)NSInteger index;
@property(nonatomic ,retain)NSMutableArray *data;
@property(nonatomic ,retain)NSString*tag;
@property(nonatomic ,retain)StudyImageViewController *data1;



- (id)initWithSourceData:(NSMutableArray *)data withIndex:(NSInteger)index;

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
