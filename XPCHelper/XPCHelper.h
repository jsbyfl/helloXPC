//
//  XPCHelper.h
//  XPCHelper
//
//  Created by lpc on 2018/7/18.
//  Copyright © 2018年 lpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCHelperProtocol.h"
#import "XPCToProjProtoc.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XPCHelper : NSObject <XPCHelperProtocol>

@property (nonatomic,strong) NSObject<XPCToProjProtoc> *projObj;

@end
