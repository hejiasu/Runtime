//
//  ForwardInvocationA.h
//  RunTime
//
//  Created by xiaoyi on 17/3/24.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForwardInvocationB.h"

@interface ForwardInvocationA : NSObject
@property(strong, nonatomic)ForwardInvocationB *objectB;//接受转发消息的对象

@end
