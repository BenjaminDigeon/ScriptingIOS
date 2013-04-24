//
//  Engine.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "Engine.h"

@interface Engine ()

@end

@implementation Engine

@synthesize js;

- (id)init {
    self.js = [[EvalJS alloc] init];
    return [super init];
}

- (NSString*) executeString:(NSString*) input {
    
    id result = [self.js eval:input];
    
    if(result == nil) {
        //If result is equal to null return empty string
        return @"";
    } else {
        // Else cast to NSString
        return (NSString*)result;
    }
}

- (NSString*) executeScript:(NSString*)path {
    NSString* script = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    return [self executeString:script];
}

@end
