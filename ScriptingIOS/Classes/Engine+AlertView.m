//
//  Engine+AlertView.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 29/05/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "Engine+AlertView.h"

@implementation Engine (AlertView)

- (void) initAlertView {
    [self.js createFunction:@"alert" callback:^id(NSUInteger argc, NSArray *argv) {
        if(argc) {
            NSString* alert = [argv objectAtIndex:0];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                              message:alert
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
        return @"";
    }];
}

@end
