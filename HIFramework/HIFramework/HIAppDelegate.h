//
//  HIAppDelegate.h
//  HIFramework
//
//  Created by He JiaBin on 12-5-16.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HIViewController;

@interface HIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HIViewController *viewController;

@end
