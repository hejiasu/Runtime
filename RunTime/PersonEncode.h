//
//  PersonEncode.h
//  RunTime
//
//  Created by xiaoyi on 17/3/26.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonEncode : NSObject<NSCoding>
@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)NSInteger age;
@end
