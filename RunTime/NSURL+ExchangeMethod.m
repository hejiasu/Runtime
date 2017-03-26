//
//  NSURL+ExchangeMethod.m
//  RunTime
//
//  Created by xiaoyi on 17/3/26.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import "NSURL+ExchangeMethod.h"
#import <objc/objc-runtime.h>
@implementation NSURL (ExchangeMethod)

//当这个类被加载时调用
+(void)load{
    NSLog(@"-------");
    
    //利用runtime交换方法
    
    // 获取方法地址
    Method  urlWithStr = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method  XYURLWithStr = class_getClassMethod([NSURL class], @selector(XYURLWithStr:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(urlWithStr,XYURLWithStr);
}

//不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.


+(instancetype)XYURLWithStr:(NSString*)str{
    
    /**
     1. 此时调用的方法 'XYURLWithStr' 相当于调用系统的 'URLWithString' 方法,原因是在load方法中进行了方法交换.
     2. 注意:此处并没有递归操作.
     */
    NSURL *url = [NSURL XYURLWithStr:str];//调用系统方法实现
    if (url == nil){
        NSLog(@"自定义url为nil");
    }
    return url;
}


















@end
