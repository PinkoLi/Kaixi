//
//  UserInfo.h
//  Kaixi
//
//  Created by ck on 15-4-13.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSNumber * areaRanking;
@property (nonatomic, retain) NSNumber * countryRanking;
@property (nonatomic, retain) NSNumber * fuhuo;
@property (nonatomic, retain) NSNumber * highScore;
@property (nonatomic, retain) NSString * interactionVersion;
@property (nonatomic, retain) NSString * large;
@property (nonatomic, retain) NSString * medicalVersion;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * offpw;
@property (nonatomic, retain) NSString * pkVersion;
@property (nonatomic, retain) NSString * policyVersion;
@property (nonatomic, retain) NSString * registrationID;
@property (nonatomic, retain) NSNumber * surplusScore;
@property (nonatomic, retain) NSString * noticeTag;

@end
