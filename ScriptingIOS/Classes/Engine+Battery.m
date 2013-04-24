//
//  Engine+Battery.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "Engine+Battery.h"

@implementation Engine (Battery)

- (void) initBattery {
    [self.js createFunction:@"getBatteryInfo" callback:^id(NSUInteger argc, NSArray *argv) {
        UIDevice* device = [[UIDevice alloc] init];
        float level = [device batteryLevel];
        NSString* state = @"";
        switch ([device batteryState]) {
            case UIDeviceBatteryStateUnplugged:
                state = @"Unplugged";
                break;
            case UIDeviceBatteryStateCharging:
                state = @"Charging";
                break;
            case UIDeviceBatteryStateFull:
                state = @"Full";
                break;
            default:
                state = @"Unknown";
                break;
        }
        return [NSString stringWithFormat:@"{'level':'%f','state':'%@'}",level,state];
    }];
}
@end
