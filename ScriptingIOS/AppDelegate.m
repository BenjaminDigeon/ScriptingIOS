//
//  AppDelegate.m
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 15/03/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import "AppDelegate.h"

//#import "ViewController.h"
#import "ScriptsListViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ScriptsListViewController* mainView = [[ScriptsListViewController alloc] initWithNibName:@"ScriptsListViewController" bundle:nil];

    self.navController = [[UINavigationController alloc] initWithRootViewController:mainView];
    self.navController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
