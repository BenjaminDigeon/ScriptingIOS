//
//  ScriptViewController.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "ScriptViewController.h"
#import "Engine.h"
#import "Engine+GPS.h"
#import "Engine+Battery.h"

@interface ScriptViewController ()

@end

@implementation ScriptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.path lastPathComponent];
    
    Engine* engine = [[Engine alloc] init];
    [engine initGPS];
    [engine initBattery];
    
    self.output.text = [engine executeScript:self.path];
}

- (void)viewDidUnload {
    [self setOutput:nil];
    [super viewDidUnload];
}
@end
