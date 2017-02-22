//
//  MedicalKnowledge.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/28.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MedicalKnowledge : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * mkid;
@property (nonatomic, retain) NSNumber * mpid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * hasdownload;
@property (nonatomic, retain) NSString * pages;

@end
