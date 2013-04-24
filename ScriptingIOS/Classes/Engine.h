//
//  Engine.h
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EvalJS.h>

@interface Engine : NSObject

/**
 * EvalJS
 */
@property (nonatomic, retain) EvalJS* js;

- (NSString*) executeString:(NSString*) input;
- (NSString*) executeScript:(NSString*) path;

@end
