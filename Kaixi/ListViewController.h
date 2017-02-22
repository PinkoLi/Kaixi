//
//  ListViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/28.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
- (IBAction)letGo:(id)sender;
- (IBAction)kaoshi:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *noticeTag6;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag7;
@property (strong, nonatomic) IBOutlet UIImageView *noticeTag8;
- (IBAction)jidukaoshi:(id)sender;
@end
