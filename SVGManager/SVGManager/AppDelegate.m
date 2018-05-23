//
//  AppDelegate.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "AppDelegate.h"

#import "ThemeManage.h"
#import "UIView+ThemeChange.h"
#import "LeftViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "W20WebVC.h"
#import "TLPhotoPicker.h"


NSString *const clientKey = @"fWv9fBxGPpfFUpnctBVudGfc";
NSString *const className = @"Joke";
NSString *const ApplicationId = @"WxhrgNaDieb6GvnfSuAvBGPj-gzGzoHsz";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initWindow];
    return YES;
    

}

- (void)initWindow {
    
    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self goVC2];
    [AVOSCloud setApplicationId:ApplicationId clientKey:clientKey];
    [AVOSCloud setAllLogsEnabled:YES];
    AVQuery *query = [AVQuery queryWithClassName:className];
    query.limit = 1;
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if (! error) {
            NSString *url = [object objectForKey:@"url"];
            if (url.length) {
                [self goVC1:url];
            }else{
                [self goVC2];
            }
        }else{
            [self goVC2];
        }
    }];
    

    
}

- (void)goVC1:(NSString *)url {
    W20WebVC *webVC = [[W20WebVC alloc] init];
    webVC.url = url;
    self.window.rootViewController = webVC;
}

- (void)goVC2 {
    self.centerVC = [[ITXPageViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.centerVC];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    UINavigationController *navLeftVC = [[UINavigationController alloc] initWithRootViewController:leftVC];
    //使用DrawController
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:navLeftVC];
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 200.0;
    self.drawerController.maximumRightDrawerWidth = 200.0;
    [self.window setRootViewController:self.drawerController];
}


@end
