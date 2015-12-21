//
//  AppDelegate.m
//  ConstraintFormat
//
//  Created by Stephan Müller on 17/12/15.
//  Copyright © 2015 Stephan Müller. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // embedd ViewController into UINavigationController to show top- and bottom bar
    UINavigationController *nc = (UINavigationController *)self.window.rootViewController;
    [nc pushViewController:[[ViewController alloc] init] animated:NO];
    return YES;
}

@end
