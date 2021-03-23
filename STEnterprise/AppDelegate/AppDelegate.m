//
//  AppDelegate.m
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import "AppDelegate.h"
#import "STTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     
    self.window.rootViewController = [STTabBarController new];
 
    [self.window makeKeyAndVisible];
    return YES;
}



@end
