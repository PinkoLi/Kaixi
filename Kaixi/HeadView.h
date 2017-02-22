//
//  HeadView.h
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeadViewDelegate; 

@interface HeadView : UIView{
    id<HeadViewDelegate> _delegate;//代理
    NSInteger section;
    UIButton* backBtn;
    BOOL open;
}
@property(nonatomic, strong) id<HeadViewDelegate> delegate;
@property(nonatomic, assign) NSInteger section;
@property(nonatomic, assign) BOOL open;
@property(nonatomic, strong) UIButton* backBtn;
@end

@protocol HeadViewDelegate <NSObject>
-(void)selectedWith:(HeadView *)view;
@end
