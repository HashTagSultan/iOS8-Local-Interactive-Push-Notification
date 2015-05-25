//
//  ViewController.m
//  iOS8-Interactive-Push-Notification
//
//  Created by Sultan Sultan on 5/25/15.
//  Copyright (c) 2015 com.elerris. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------------------------------------
//scheduleANotification - The notification will be fired after 5 min
//------------------------------------------------------------------------------------------------------------

- (IBAction)scheduleANotification:(id)sender {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", [NSDate date]];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.category = @"ACTIONABLE";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


@end
