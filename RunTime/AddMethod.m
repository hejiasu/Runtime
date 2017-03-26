//
//  AddMethod.m
//  RunTime
//
//  Created by xiaoyi on 17/3/24.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import "AddMethod.h"
#import <objc/objc-runtime.h>


@implementation AddMethod

//有俩个隐含参数id、SEL

void test(id self,SEL sel)
{
    NSLog(@"添加test实例方法");
}

void(^writeBlock)(id,SEL) = ^(id objc_self,SEL objc_cmd){
    NSLog(@"添加writeBlock实例方法");
};

void(^readBlock)(id,SEL) = ^(id objc_self,SEL objc_cmd){
    NSLog(@"添加readBlock类方法");
};



#pragma -mark:动态解析实例方法(如果一个实例的方法选择器没有再方法列表里找打就会进入)
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    //可以添加函数指针或block

    //判断若方法名是test则添加，别则不添加
    if (sel == @selector(test)) {
        // 动态添加test方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：方法名
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod([self class], @selector(test), test, "v@:");
    }else{
        //判断若是其他则添加
        class_addMethod([self class], sel, imp_implementationWithBlock(writeBlock), "v@:");
    }
    
    printf("%s\n",sel_getName(sel));

    return [super resolveInstanceMethod:sel];
}


#pragma -mark:动态解析类方法(如果一个类的方法选择器没有再方法列表里找打就会进入)
+(BOOL)resolveClassMethod:(SEL)sel{
    
    //创建类方法的实现
    
    /*为指定类添加方法
     *参数1：需要添加新方法的类
     *参数2：方法名
     *参数3：由编译器生成的、指向实现方法的指针。也就是说，这个指针指向的方法就是我们要添加的方法。
     *参数4：添加的方法的返回值和参数，函数的类型编码（结构为：返回值、第一个参数、第二个参数。。。）
     */
    class_addMethod(object_getClass([self class]), sel, imp_implementationWithBlock(readBlock), "v@:");

    printf("%s\n",sel_getName(sel));
    
    return [super resolveInstanceMethod:sel];;

}







@end
