//
//  UIWidget.h
//  HIFramework
//
//  Created by He jia bin on 7/13/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWidget : NSObject
{
    NSMutableArray* m_children;
}

- (void)onUIFrame:(float)elapse;

- (void)onUIDraw:(float)elapse;

- (void)onUIEvents:(NSArray*)events;

- (void)SetParent:(UIWidget*)parent;

- (void)SetRegion:(CGRect)region;

//TODO 

@end
