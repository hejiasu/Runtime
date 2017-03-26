//
//  ForwardInvocationA.m
//  RunTime
//
//  Created by xiaoyi on 17/3/24.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

#import "ForwardInvocationA.h"

@implementation ForwardInvocationA

//第二层---当第一层没有添加动态方法就会进入第二层
#pragma maerk-将消息转给某对象
-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    NSLog(@"myObject---%@",NSStringFromSelector(_cmd));
    
    if ([self.objectB respondsToSelector:aSelector]){
        return nil ;
    }
    return [super forwardingTargetForSelector:aSelector];
}

//第三层---当第二层返回值为self或nil就会进入第三层
#pragma maerk-得到方法名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    if(aSelector == @selector(learnOC)){
        return [self.objectB methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}
#pragma maerk-实现消息转发
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    if (anInvocation.selector == @selector(learnOC)){
        
        [anInvocation invokeWithTarget:self.objectB];
    }
}

@end
