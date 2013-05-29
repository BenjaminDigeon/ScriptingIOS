//
//  Engine+NetworkInformations.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 29/05/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "Engine+NetworkInformations.h"
#import "NICInfo.h"
#import "NICInfoSummary.h"

@implementation Engine (NetworkInformations)

-(void) initNetworkInformation {
    [self.js createFunction:@"networkInformation" callback:^id(NSUInteger argc, NSArray *argv) {
        NSMutableString* result = [[NSMutableString alloc]init];
        NICInfoSummary* summary = [[NICInfoSummary alloc] init];
        NSArray *nic_array = summary.nicInfos;
        
        for(int i=0; i<nic_array.count; i++)
        {
            NICInfo* nic_info = [nic_array objectAtIndex:i];
            [result appendString:[NSString stringWithFormat:@"interface : %@\r\n", nic_info.interfaceName]];
            if(nic_info.macAddress != nil)
                [result appendString:[NSString stringWithFormat:@" - MAC : %@\r\n", [nic_info getMacAddressWithSeparator:@"-"]]];
            
            // ip can be multiple
            if(nic_info.nicIPInfos.count > 0)
            {
                [result appendString:@" - IPv4 :\r\n"];
                for(int j=0; j<nic_info.nicIPInfos.count; j++)
                {
                    NICIPInfo* ip_info = [nic_info.nicIPInfos objectAtIndex:j];
                    [result appendString:[NSString stringWithFormat:@"    IP : %@\r\n    netmask : %@\r\n    broadcast : %@\r\n", ip_info.ip, ip_info.netmask, ip_info.broadcastIP]];
                }
            }
            
            // ipv6 can be multiple, also.
            if(nic_info.nicIPv6Infos.count > 0)
            {
                [result appendString:@" - IPv6 :\r\n"];
                for(int j=0; j<nic_info.nicIPv6Infos.count; j++)
                {
                    NICIPInfo* ipv6_info = [nic_info.nicIPv6Infos objectAtIndex:j];
                    [result appendString:[NSString stringWithFormat:@"    IP : %@\r\n    netmask : %@\r\n    broadcast : %@\r\n"
                          , ipv6_info.ip, ipv6_info.netmask, ipv6_info.broadcastIP]];
                }
            }
        }
        
        // What are those connected?
        [result appendString:[NSString stringWithFormat:@"is3GConnected : %d\r\n", summary.is3GConnected]];
        [result appendString:[NSString stringWithFormat:@"isBluetoothConnected : %d\r\n", summary.isBluetoothConnected]];
        [result appendString:[NSString stringWithFormat:@"isPersonalHotspotActivated : %d\r\n", summary.isPersonalHotspotActivated]];
        [result appendString:[NSString stringWithFormat:@"isWifiConnected : %d\r\n", summary.isWifiConnected]];
        [result appendString:[NSString stringWithFormat:@"isWifiConnectedToNAT : %d\r\n", summary.isWifiConnectedToNAT]];
        return result;
    }];
}

@end
