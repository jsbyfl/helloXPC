//
//  ViewController.m
//  HelloXPC
//
//  Created by lpc on 2018/7/18.
//  Copyright © 2018年 lpc. All rights reserved.
//

#import "ViewController.h"
#import "XPCHelperProtocol.h"
#import "XPCHelper.h"

@implementation ViewController{
    XPCHelper *helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSButton *connectXPCBtn = [[NSButton alloc] initWithFrame:NSMakeRect(50, 50, 150, 100)];
    [connectXPCBtn setTitle:@"Connect XPC Service"];
    connectXPCBtn.target = self;
    connectXPCBtn.action = @selector(connectXPC:);
    [self.view addSubview:connectXPCBtn];

    
    NSButton *downloadBtn = [[NSButton alloc] initWithFrame:NSMakeRect(250, 50, 150, 100)];
    [downloadBtn setTitle:@"test"];
    downloadBtn.target = self;
    downloadBtn.action = @selector(testAct:);
    [self.view addSubview:downloadBtn];
    
    
    NSXPCInterface *myCookieInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCHelperProtocol)];
    NSXPCConnection *myConnection = [[NSXPCConnection alloc] initWithServiceName:@"com.lpc.XPCHelper"];
    
    myConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCToProjProtoc)];
    myConnection.exportedObject = self;
    myConnection.remoteObjectInterface = myCookieInterface;
    helper = [myConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    [myConnection resume];
}

- (void)connectXPC:(id)sender {
    [helper projToXpcEvent];
    
}

- (void)testAct:(id)sender {
    
}



- (void)XPCToProjEvent
{
    NSLog(@"[1-0]---XPCToProjEvent>>--%@,%@",[self className],NSStringFromSelector(_cmd));
}

@end
