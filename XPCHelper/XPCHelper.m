//
//  XPCHelper.m
//  XPCHelper
//
//  Created by lpc on 2018/7/18.
//  Copyright © 2018年 lpc. All rights reserved.
//

#import "XPCHelper.h"

@implementation XPCHelper

- (void)projToXpcEvent
{
    NSLog(@"[0-1]---projToXpcEvent>>--%@,%@",[self className],NSStringFromSelector(_cmd));
    if (self.projObj) {
        [self.projObj XPCToProjEvent];
    }
}

@end
