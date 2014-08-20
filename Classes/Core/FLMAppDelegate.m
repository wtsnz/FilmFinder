//
//  FLMAppDelegate.m
//  FilmFinder
//
//  Created by Will Townsend on 8/19/14
//  Copyright (c) 2014 wtsnz. All rights reserved.
//

#import "FLMAppDelegate.h"
#import "DebugLog.h"

#import "FLMFilmsTableViewController.h"

@implementation FLMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    FLMFilmsTableViewController *filmsTableViewController = [FLMFilmsTableViewController new];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:filmsTableViewController];
    
    // Configure Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    DLog(@"Hello, World!");
    
    return YES;
}

@end
