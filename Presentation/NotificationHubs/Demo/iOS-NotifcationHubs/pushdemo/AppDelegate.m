//
//  AppDelegate.m
//  pushdemo
//
//  Created by Chris Risner on 5/7/14.
//  Copyright (c) 2014 msted. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                         |UIRemoteNotificationTypeSound
                                                                                         |UIRemoteNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    return YES;
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"%@", notificationSettings);
    [application registerForRemoteNotifications];
}
							
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APN device token: %@", deviceToken);
    NSString *deviceTokenString = [NSString stringWithFormat:@"%@",deviceToken];
    
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    if (self.vc) {
        [self.vc setPushToken:deviceTokenString andData:deviceToken];
    }
}



- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%@", userInfo);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:
                          [[userInfo objectForKey:@"aps"] valueForKey:@"alert"] delegate:nil cancelButtonTitle:
                          @"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
