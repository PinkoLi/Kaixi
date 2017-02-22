//
//  SetPassWordViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPassWordViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UITextField *passWord2;
- (IBAction)login:(id)sender;
@end
