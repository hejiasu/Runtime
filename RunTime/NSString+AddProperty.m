//
//  NSString+AddProperty.m
//  RunTime
//
//  Created by xiaoyi on 17/3/24.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import "NSString+AddProperty.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *key = "name";
@implementation NSString (AddProperty)

- (NSString *)name
{
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name
{
    // 参数1：给哪个对象添加属性赋值
    // 参数2：关联的key，通过这个key获取
    // 参数3：关联的value
    // 参数4:关联的策略，下面枚举（手机开发一般都选择NONATOMIC）
//    enum {
//        OBJC_ASSOCIATION_ASSIGN = 0,//assign策略
//        OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,
//        OBJC_ASSOCIATION_COPY_NONATOMIC = 3,
//        OBJC_ASSOCIATION_RETAIN = 01401,// retain策略
//        OBJC_ASSOCIATION_COPY = 01403//copy策略
//    };
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
