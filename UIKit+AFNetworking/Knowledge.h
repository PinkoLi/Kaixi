//
//  Knowledge.h
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/2/26.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Knowledge : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * kid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pages;
@property (nonatomic, retain) NSNumber * pid;
@property (nonatomic, retain) NSString * hasdownload;

@end
