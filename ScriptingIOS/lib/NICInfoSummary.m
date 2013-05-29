#import "NICInfoSummary.h"

@implementation NICInfoSummary

@synthesize nicInfos;

// performance of nic info when alloc/dealloc 1000 times
//  iPhone 4 : 1.525310s
//  iPod Touch 1G : 2.533612s
- (void)dealloc
{
    if(_nicInfos != nil)
        [_nicInfos release];
    [super dealloc];
}

static NICInfoSummary *_shared;
+ (NICInfoSummary *)shared
{
    @synchronized(_shared)
    {
        if(nil == _shared)
            _shared = [[NICInfoSummary alloc] init];
    }
    return _shared;
}

+ (NICInfoSummary *)refresh
{
    @synchronized(_shared)
    {
        if(nil != _shared)
        {
            [_shared release];
            _shared = nil;
        }
    }
    return [NICInfoSummary shared];
}

- (NSArray *)nicInfos
{
    if(_nicInfos == nil)
        _nicInfos = [[NICInfo nicInfos] retain];
    return _nicInfos;
}

- (NICInfo *)findNICInfo:(NSString*)interface_name
{
    for(int i=0; i<self.nicInfos.count; i++)
    {
        NICInfo* nic_info = [self.nicInfos objectAtIndex:i];
        if([nic_info.interfaceName isEqualToString:interface_name])
            return nic_info;
    }
    return nil;
}

- (NICInfo *)anyAvailableNicInfo
{
    for (NICInfo *nic in [self nicInfos]) {
        for(NICIPInfo *ipInfo in [nic nicIPInfos])
        {
            if([ipInfo.ip isEqualToString:@"127.0.0.1"] || [ipInfo.ip isEqualToString:@"0.0.0.0"])
                continue;
            else
                return nic;
        }            
    }
    return nil;
}

- (NSString *)anyAvailableIPv4
{
    for (NICInfo *nic in [self nicInfos]) {
        for(NICIPInfo *ipInfo in [nic nicIPInfos])
        {
            if([ipInfo.ip isEqualToString:@"127.0.0.1"] || [ipInfo.ip isEqualToString:@"0.0.0.0"])
                continue;
            else
                return ipInfo.ip;
        }            
    }
    return nil;
}

- (NSArray *)availableNicInfos
{
    NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
    for (NICInfo *nic in [self nicInfos]) {
        for(NICIPInfo *ipInfo in [nic nicIPInfos])
        {
            if([ipInfo.ip isEqualToString:@"127.0.0.1"] || [ipInfo.ip isEqualToString:@"0.0.0.0"])
                continue;
            else
                [tempArray addObject:nic];
        }            
    }
    if(tempArray.count == 0)
        return nil;
    return tempArray;
}

- (NSArray *)availableIPInfov4
{
    NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
    for (NICInfo *nic in [self nicInfos]) {
        for(NICIPInfo *ipInfo in [nic nicIPInfos])
        {
            if([ipInfo.ip isEqualToString:@"127.0.0.1"] || [ipInfo.ip isEqualToString:@"0.0.0.0"])
                continue;
            else
                [tempArray addObject:ipInfo];
        }            
    }
    if(tempArray.count == 0)
        return nil;
    return tempArray;
}


#pragma mark SERVICE METHODS (target to MAC OS X)

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
- (bool)isWifiConnected
{
    NICInfo* nic_info = nil;
    
    // In order to check 'available ethernet network'
    for (nic_info in [self nicInfos]) {
        // start with 'en' and have more than one IP!
        if([[nic_info interfaceName] rangeOfString:@"en"].location == 0
           && nic_info.nicIPInfos.count > 0
           )
            return YES;
    }
    return NO;
}

- (bool)isWifiConnectedToNAT
{
    NICInfo* nic_info = nil;
    for (nic_info in [self nicInfos]) {
        // start with 'en' and have more than one IP!
        if([[nic_info interfaceName] rangeOfString:@"en"].location == 0
           && nic_info.nicIPInfos.count > 0
           )
        {
            for (NICIPInfo* ip_info in nic_info.nicIPInfos)
            {
                if([ip_info.ip rangeOfString:@"192.168."].location == 0 ||
                   [ip_info.ip rangeOfString:@"10."].location == 0)                   
                    return YES;
            }
        }
    }
    return NO;
}

- (bool)isBluetoothConnected
{
//    NICInfo* nic_info = nil;
//    nic_info = [self findNICInfo:@"en2"];
//    if(nic_info != nil)
//    {
//        if(nic_info.nicIPInfos.count > 0)
//            return YES;
//    }
    // not applied to OS X
    return NO;
}

- (bool)isPersonalHotspotActivated
{
//    NICInfo* nic_info = nil;
//    nic_info = [self findNICInfo:@"bridge0"];
//    if(nic_info != nil)
//    {
//        if(nic_info.nicIPInfos.count > 0)
//            return YES;
//    }
    // not applied to OS X
    return NO;
}

- (bool)is3GConnected
{
//    NICInfo* nic_info = nil;
//    nic_info = [self findNICInfo:@"pdp_ip0"];
//    if(nic_info != nil)
//    {
//        if(nic_info.nicIPInfos.count > 0)
//            return YES;
//    }
    // not applied to OS X
    return NO;
}

// return all broadcast ip, except 127.0.01
- (NSArray *)broadcastIPs
{
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    if(self.nicInfos != nil)
    {
        for(NICInfo *nic in self.nicInfos)
        {
            if(nic.nicIPInfos != nil)
            {
                for(NICIPInfo *ipInfo in nic.nicIPInfos)
                {
                    if(![ipInfo.ip isEqualToString:@"127.0.0.1"] &&
                       ![ipInfo.ip isEqualToString:ipInfo.broadcastIP])
                        [array addObject:ipInfo.broadcastIP];
                }
            }        
        }   
    }
    return array;
}


#pragma mark SERVICE METHODS (target to iOS)
#else
- (bool)isWifiConnected
{
    NICInfo* nic_info = nil;
    // code only compiled when targeting iOS    
    nic_info = [self findNICInfo:@"en0"];
    if(nic_info != nil)
    {
        if(nic_info.nicIPInfos.count > 0)
            return YES;
    }
    return NO;
}

- (bool)isWifiConnectedToNAT
{
    NICInfo* nic_info = nil;
    // code only compiled when targeting iOS    
    nic_info = [self findNICInfo:@"en0"];
    if(nic_info != nil)
    {
        for(int i=0; i<nic_info.nicIPInfos.count; i++)
        {
            NICIPInfo* ip_info = [nic_info.nicIPInfos objectAtIndex:i];
            if([ip_info.ip rangeOfString:@"192.168."].location == 0 ||
               [ip_info.ip rangeOfString:@"10."].location == 0)                   
                return YES;
        }
    }
    return NO;
}

- (bool)isBluetoothConnected
{
    NICInfo* nic_info = nil;
    nic_info = [self findNICInfo:@"en2"];
    if(nic_info != nil)
    {
        if(nic_info.nicIPInfos.count > 0)
            return YES;
    }
    return NO;
}

- (bool)isPersonalHotspotActivated
{
    NICInfo* nic_info = nil;
    nic_info = [self findNICInfo:@"bridge0"];
    if(nic_info != nil)
    {
        if(nic_info.nicIPInfos.count > 0)
            return YES;
    }
    return NO;
}

- (bool)is3GConnected
{
    NICInfo* nic_info = nil;
    nic_info = [self findNICInfo:@"pdp_ip0"];
    if(nic_info != nil)
    {
        if(nic_info.nicIPInfos.count > 0)
            return YES;
    }
    return NO;
}

// return all broadcast ip, except 127.0.01
- (NSArray *)broadcastIPs
{
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    if(self.nicInfos != nil)
    {
        for(NICInfo *nic in self.nicInfos)
        {
            if(nic.nicIPInfos != nil)
            {
                for(NICIPInfo *ipInfo in nic.nicIPInfos)
                {
                    if(![ipInfo.ip isEqualToString:@"127.0.0.1"] &&
                       ![ipInfo.ip isEqualToString:ipInfo.broadcastIP])
                        [array addObject:ipInfo.broadcastIP];
                }
            }        
        }   
    }
    return array;
}

#endif     // __MAC_OS_X_VERSION_MAX_ALLOWED


@end
