//
//  PersonEncode.m
//  RunTime
//
//  Created by xiaoyi on 17/3/26.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import "PersonEncode.h"
#import <objc/runtime.h>

@implementation PersonEncode
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //定义一个实例变量的个数
    unsigned int ivarCount = 0;
    //首先获取这个类的实例变量列表
    /*
     *C语言中，如果传基本数据类型的指针，那么一般都是需要在函数内部改变他的值
     */
    Ivar *vars = class_copyIvarList([self class], &ivarCount);
    
    //遍历实例变量列表
    for (int i = 0; i< ivarCount; i++) {
        
        //获取实例变量名
        NSString *strName = [NSString stringWithUTF8String:ivar_getName(vars[i])];
        //通过KVC获取实例变量值
        id value = [self valueForKey:strName];
        //以实例变量名作为key进行归档
        [aCoder encodeObject:value forKey:strName];
    }
    //在C语言中，凡是看到new，creat，copy函数需要释放指针
    //释放内存
    free(vars);
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [self init]){
        
        //首先获取这个类的实例变量列表
        //定义一个实例变量的个数
        unsigned int ivarCount = 0;
        Ivar *vars = class_copyIvarList([self class], &ivarCount);
        
        //遍历实例变量列表
        for (int i = 0; i< ivarCount; i++) {
            
            //获取实例变量名
            NSString *strName = [NSString stringWithUTF8String:ivar_getName(vars[i])];
            //以实例变量的名字作为key进行反归档
            id value = [aDecoder decodeObjectForKey:strName];
            
            //通过KVC对实例变量进行赋值
            [self setValue:value forKey:strName];
        }
        //在C语言中，凡是看到new，creat，copy函数需要释放指针
        //释放内存
        free(vars);
    }
    
    return self;
}
@end
