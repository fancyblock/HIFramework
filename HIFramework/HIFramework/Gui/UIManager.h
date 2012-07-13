//
//  UIManager.h
//  HIFramework
//
//  Created by He jia bin on 7/11/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWidget.h"

@interface UIManager : NSObject
{
    UIWidget* m_root;
}

+ (UIManager*)sharedInstance;


- (void)AddToRoot:(UIWidget*)widget;

- (void)CleanWidget;

- (void)UIMain:(float)elapsed;

- (void)UIDraw:(float)elapsed;

- (BOOL)onTouchEvent:(NSArray*)events;


@end
