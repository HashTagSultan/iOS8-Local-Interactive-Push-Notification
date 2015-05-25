//
//  AppDelegate.m
//  iOS8-Interactive-Push-Notification
//
//  Created by Sultan Sultan on 5/25/15.
//  Copyright (c) 2015 com.elerris. All rights reserved.
//

#import "AppDelegate.h"

static NSString *const NotificationCategoryIdent = @"ACTIONABLE";
static NSString *const NotificationActionOneIdent = @"First Action";
static NSString *const NotificationActionTwoIdent = @"Second Action";

@interface AppDelegate ()

@end

@implementation AppDelegate

//------------------------------------------------------------------------------------------------------------
// didFinishLaunchingWithOptions -
//------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.

  // Register for the interactive notifications
  [self registerForNotificationsWithActions];
  return YES;
}

//------------------------------------------------------------------------------------------------------------
// didReceiveLocalNotification - Received when application was in background or
// foreground
//------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application
    didReceiveLocalNotification:(UILocalNotification *)notification {
  NSLog(@"Received Local Notification:%@", notification);

  if ([UIApplication sharedApplication].applicationState ==
      UIApplicationStateActive) {
    // Display a UIAlertView (that will pose as a notification alert)
    UIAlertView *alertView = [[UIAlertView alloc]
            initWithTitle:@"Local Notification Recieved"
                  message:@"This is called when the app is in the foreground."
                 delegate:nil
        cancelButtonTitle:@"Okay"
        otherButtonTitles:nil];
    [alertView show];
  }
}

/**
 Handle the tap actions from interactive notifications (these are happening when
 the
 application is in background (i.e. they don't launch the application
 */

//------------------------------------------------------------------------------------------------------------
// handleActionWithIdentifier - Handle the tap actions from interactive
// notifications (these are happening when the
//                                  application is in background (i.e. they
//                                  don't launch the application
//------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application
    handleActionWithIdentifier:(NSString *)identifier
          forLocalNotification:(NSDictionary *)userInfo
             completionHandler:(void (^)())completionHandler {
  if ([identifier isEqualToString:NotificationActionOneIdent]) {
    NSLog(@"You chose action 1.");
  } else if ([identifier isEqualToString:NotificationActionTwoIdent]) {
    NSLog(@"You chose action 2.");
  }
  if (completionHandler) {
    completionHandler();
  }
}

//------------------------------------------------------------------------------------------------------------
// registerForNotificationsWithActions - Received when application was in
// background or foreground
//------------------------------------------------------------------------------------------------------------
- (void)registerForNotificationsWithActions {
  // Action 1
  UIMutableUserNotificationAction *action1;
  action1 = [[UIMutableUserNotificationAction alloc] init];
  [action1 setActivationMode:UIUserNotificationActivationModeBackground];
  [action1 setTitle:@"Open"];
  [action1 setIdentifier:NotificationActionOneIdent];
  [action1 setDestructive:NO];
  [action1 setAuthenticationRequired:NO];

  // Action 2
  UIMutableUserNotificationAction *action2;
  action2 = [[UIMutableUserNotificationAction alloc] init];
  [action2 setActivationMode:UIUserNotificationActivationModeBackground];
  [action2 setTitle:@"Close"];
  [action2 setIdentifier:NotificationActionTwoIdent];
  [action2 setDestructive:YES];
  [action2 setAuthenticationRequired:NO];

  // Create a category with actions
  UIMutableUserNotificationCategory *actionCategory;
  actionCategory = [[UIMutableUserNotificationCategory alloc] init];
  [actionCategory setIdentifier:NotificationCategoryIdent];
  [actionCategory setActions:@[ action1, action2 ]
                  forContext:UIUserNotificationActionContextDefault];
  NSSet *categories = [NSSet setWithObject:actionCategory];

  // Register the notification
  UIUserNotificationType types =
      (UIUserNotificationTypeAlert | UIUserNotificationTypeSound |
       UIUserNotificationTypeBadge);
  UIUserNotificationSettings *settings =
      [UIUserNotificationSettings settingsForTypes:types categories:categories];
  [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

//------------------------------------------------------------------------------------------------------------
// applicationWillResignActive -
//------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down
  // OpenGL ES frame rates. Games should use this method to pause the game.
}

//------------------------------------------------------------------------------------------------------------
// applicationDidEnterBackground -
//------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

//------------------------------------------------------------------------------------------------------------
// applicationWillEnterForeground -
//------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.
}

//------------------------------------------------------------------------------------------------------------
// applicationDidBecomeActive -
//------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

//------------------------------------------------------------------------------------------------------------
// applicationWillTerminate -
//------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

@end
