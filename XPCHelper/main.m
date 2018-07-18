//
//  main.m
//  XPCHelper
//
//  Created by lpc on 2018/7/18.
//  Copyright © 2018年 lpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCHelper.h"
#import "XPCToProjProtoc.h"

@interface ServiceDelegate : NSObject <NSXPCListenerDelegate>
@end

@implementation ServiceDelegate

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
{
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCHelperProtocol)];
    newConnection.remoteObjectInterface =  [NSXPCInterface interfaceWithProtocol:@protocol(XPCToProjProtoc)];
    
    XPCHelper *exportedObject = [XPCHelper new];
    newConnection.exportedObject = exportedObject;
    
    exportedObject.projObj = [newConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        NSLog(@" xpc service remote obj error = %@",error);
    }];
    
    
    [newConnection resume];
    
    return YES;
}

@end

int main(int argc, const char *argv[])
{
    // Create the delegate for the service.
    ServiceDelegate *delegate = [ServiceDelegate new];
    
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;
    
    // Resuming the serviceListener starts this service. This method does not return.
    [listener resume];
    return 0;
}
