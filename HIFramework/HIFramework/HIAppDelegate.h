//
//  HIAppDelegate.h
//  HIFramework
//
//  Created by He JiaBin on 12-5-16.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIApp/HIApp.h"

@interface HIAppDelegate : UIResponder <UIApplicationDelegate, HIAppDelegate>
{
    HIApp* m_gameApp;
    
    //TODO 
}

@property (strong, nonatomic) UIWindow *window;

@end
