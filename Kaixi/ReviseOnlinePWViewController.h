//
//  ReviseOnlinePWViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/5.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviseOnlinePWViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *oldPW;
@property (strong, nonatomic) IBOutlet UITextField *freshPW;
@property (strong, nonatomic) IBOutlet UITextField *surePW;
- (IBAction)save:(id)sender;

@end
