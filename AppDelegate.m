//
//  AppDelegate.m
//  TaDaList
//
//  Created by Satheeshkumar Thiyagarajan on 6/9/15.
//  Copyright (c) 2015 Satheeshkumar Thiyagarajan. All rights reserved.
//

#import "AppDelegate.h"
#import "TaDaTableViewController.h"

@interface AppDelegate ()

@property UIInputViewController * viewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    TaDaTableViewController *vc = [[navController viewControllers] objectAtIndex:0];
        if ([vc.dictArray count]) {
        [vc.dictArray writeToFile:@"/tmp/List.plist" atomically:YES];}
   // [(TaDaTableViewController*)[TaDaTableViewController class] saveFinalData];

    

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    TaDaTableViewController *vc = [[navController viewControllers] objectAtIndex:0];
    if ([vc.dictArray count]) {
        [vc.dictArray writeToFile:@"/tmp/List.plist" atomically:YES];}
    NSLog(@"Exit");
    //[self.dataSource saveFinalData];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end