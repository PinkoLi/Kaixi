//
//  ViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/7.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *CMR;

@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) UIAlertView *alert;
- (IBAction)login:(id)sender;
- (IBAction)zhaohui:(id)sender;

- (IBAction)offLogin:(id)sender;
- (IBAction)packUp:(id)sender;
- (IBAction)backView:(id)sender;

- (IBAction)pwAction:(id)sender;
@property (strong, nonatomic)NSMutableDictionary*dict;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (strong, nonatomic) IBOutlet UIButton *rePW;
@property (strong, nonatomic) IBOutlet UIButton *forgetPW;
- (IBAction)forget:(id)sender;
- (IBAction)remerb:(id)sender;

@end

