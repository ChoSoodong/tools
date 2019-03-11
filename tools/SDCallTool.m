//
//  SDCallTool.m
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import "SDCallTool.h"

@implementation SDCallTool

+(void)callNumber:(NSString* )phoneNumber{
    
    if (phoneNumber != nil) {
        [[UIApplication sharedApplication] openURL: [[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]];
        

    }
}


@end
