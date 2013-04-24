//
//  Engine+GPS.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "Engine+GPS.h"

@implementation Engine (GPS)

- (void) initGPS {
    //Creation de la fonction synchrone
    [self.js createFunction:@"getLocation" callback:^id(NSUInteger argc, NSArray *argv) {
        CLLocationManager * locationManager = [[CLLocationManager alloc] init];
        CLLocation *location = [locationManager location];
        CLLocationCoordinate2D coordinate = [location coordinate];
        NSString* gpsLat = [NSString stringWithFormat:@"%f", coordinate.latitude * 1000000];
        NSString* gpsLon = [NSString stringWithFormat:@"%f", coordinate.longitude * 1000000];
        return [NSString stringWithFormat:@"{'lat':'%@','lon':'%@'}",gpsLat,gpsLon];
    }];
}

@end
