//
//  ViewController.m
//  JPushTest
//
//  Created by rocky on 16/1/29.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "JPUSHService.h"
@interface ViewController ()
@property (nonatomic, strong) UILabel *notification;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 点击清除服务器角标
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearBadge:)];
    [self.view addGestureRecognizer:tap];
    
    
    // 获取自定义消息推送内容
    // 只有在前端运行的时候才能收到自定义消息的推送
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    
    self.notification = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 250, 30)];
    self.notification.textColor = [UIColor blackColor];
    self.notification.backgroundColor = [UIColor grayColor];
    self.notification.text = self.noti;
    [self.view addSubview:_notification];
}

// 获取自定义消息回调方法
- (void)networkDidReceiveMessage:(NSNotification *)notification{
    NSDictionary * userInfo = [notification userInfo];
    //    NSString *content = [userInfo valueForKey:@"content"];
    //    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"自定义消息 %@",userInfo);
    
    self.notification.text = [userInfo valueForKey:@"content"];
}


- (void)clearBadge:(UITapGestureRecognizer *)tap{
//    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
}

@end
