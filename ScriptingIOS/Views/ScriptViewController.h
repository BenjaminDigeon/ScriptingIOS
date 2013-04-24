//
//  ScriptViewController.h
//  ScriptingIOS
//
//  Created by Benjamin Digeon on 24/04/13.
//  Copyright (c) 2013 Benjamin Digeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScriptViewController : UIViewController

    @property(nonatomic, retain) NSString* path;
    @property (weak, nonatomic) IBOutlet UITextView *output;

@end
