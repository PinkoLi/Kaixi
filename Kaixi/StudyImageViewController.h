//
//  StudyImageViewController.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/12.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyImageViewController :  UIViewController <UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *imgList;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSMutableDictionary *dictSelect;
@property (nonatomic, strong) NSString *pages;
@property (nonatomic, strong) NSString *theid;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *tag2;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic ,retain)NSString * name;

@property(nonatomic ,strong)NSNumber * num;

- (IBAction)fullAction:(id)sender;

- (IBAction)allPhoto:(id)sender;
- (IBAction)notPhoto:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *allPhoto;
@property (strong, nonatomic) IBOutlet UIButton *notPhoto;

@property (strong, nonatomic) IBOutlet UILabel *biaoti;

- (IBAction)goBack:(id)sender;

@end
