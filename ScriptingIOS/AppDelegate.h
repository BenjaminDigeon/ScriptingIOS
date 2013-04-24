//
//  AppDelegate.h
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 15/03/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//UI
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController* navController;

@end
