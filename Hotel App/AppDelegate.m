//
//  AppDelegate.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "AppDelegate.h"
#import "LockscreenViewController.h"
#import "LandingViewController.h"

@implementation AppDelegate {
    
    NSTimer * clockTimer;
    NSDateFormatter * clockFormater;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Clock
    clockFormater = [[NSDateFormatter alloc] init];
    [clockFormater setDateFormat:@"H:mm"];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LandingViewController * landing = [[LandingViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:landing];
    [nav setNavigationBarHidden:YES];
    
    UIImageView * imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape.png"]];
    [nav.view addSubview:imgv];
    [nav.view sendSubviewToBack:imgv];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    LockscreenViewController * lvc = [[LockscreenViewController alloc] init];
    [landing presentViewController:lvc animated:NO completion:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [clockTimer invalidate];
    clockTimer = nil;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if (!self.window.rootViewController.presentedViewController) {
        
        LockscreenViewController * lvc = [[LockscreenViewController alloc] init];
        [self.window.rootViewController presentViewController:lvc animated:NO completion:nil];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSTimeInterval todayInterval = [[NSDate date] timeIntervalSince1970]; //Today in seconds
    int remainingForMinute  = 60 - ((int)todayInterval % 60);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(remainingForMinute * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [clockTimer invalidate];
        clockTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(deliverTimeToApp) userInfo:nil repeats:YES];
        [self deliverTimeToApp];
        
    });
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
-(void)deliverTimeToApp {
    
    UIViewController * controller = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
    
    SEL setTimeSelector = NSSelectorFromString(@"setTime:");
    if ([controller respondsToSelector:setTimeSelector]) {
        [controller performSelector:setTimeSelector withObject:[self currentTime]];
    }
    
    controller = self.window.rootViewController.presentedViewController;
    if (controller) {
        if ([controller respondsToSelector:setTimeSelector]) {
            [controller performSelector:setTimeSelector withObject:[self currentTime]];
        }
    }
}
#pragma clang diagnostic pop

-(NSString *)currentTime {
    
    return [clockFormater stringFromDate:[NSDate date]];
}

@end
