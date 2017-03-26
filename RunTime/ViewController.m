//
//  ViewController.m
//  RunTime
//
//  Created by xiaoyi on 17/3/23.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//




#import "ViewController.h"
#import "AddMethod.h"
#import "NSString+AddProperty.h"

#import "ForwardInvocationA.h"
#import "ForwardInvocationB.h"

#import "PersonEncode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //动态添加方法
    //创建Addmethod的实例，并调用不存在的方法
    AddMethod *addmethod = [[AddMethod alloc]init];
    //调用实例方法
    [addmethod performSelector:@selector(test)];
    [addmethod performSelector:@selector(eat)];
    //调用类方法
    [AddMethod performSelector:@selector(read)];

    //**************************************
    
    //动态添加属性
    
    // 给系统NSString类动态添加属性name
    NSString *str = [[NSString alloc]init];
    str.name = @"动态添加属性";
    NSLog(@"动态添加属性---%@",str.name);

    //**************************************

    //消息转发
    ForwardInvocationA *f =[[ForwardInvocationA alloc]init];
    f.objectB = [[ForwardInvocationB alloc]init];
    [f performSelector:@selector(learnOC)];
    
    //**************************************
    
    //方法交换----检测url是否为空
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/中文"];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    //**************************************

    //归档
    PersonEncode *per = [[PersonEncode alloc]init];
    per.name = @"XY";
    per.age = 12;
    
    NSString *temp = NSTemporaryDirectory();
    NSString *filepath = [temp stringByAppendingPathComponent:@"xy.xy"];
    [NSKeyedArchiver archiveRootObject:per toFile:filepath];
    
    
    //反归档并输出
    PersonEncode *per1 =[NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    NSLog(@"%@---%d",per1.name,per1.age);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






















@end
