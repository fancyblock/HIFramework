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
    UIWidget* m_parent;
    NSMutableArray* m_children;
    
    float m_x;
    float m_y;
    float m_screenX;
    float m_screenY;
    float m_width;
    float m_height;
    
    BOOL m_isShow;
    BOOL m_isEnable;
    BOOL m_isUnBlockEvent;
}

// readonly property
@property (nonatomic, readonly) float POS_X;
@property (nonatomic, readonly) float POS_Y;
@property (nonatomic, readonly) float SCREEN_POS_X;
@property (nonatomic, readonly) float SCREEN_POS_Y;
@property (nonatomic, readonly) float WIDTH;
@property (nonatomic, readonly) float HEIGHT;

@property (nonatomic, readonly) NSMutableSet* CHILDREN;

// setable property
@property (nonatomic, readwrite) BOOL SHOW;
@property (nonatomic, readwrite) BOOL ENABLE;
@property (nonatomic, readwrite) BOOL UNBLOCK_EVENT;


- (void)onUIFrame:(float)elapse;

- (void)onUIDraw;

- (BOOL)onUIEvents:(NSArray*)events;

- (void)SetParent:(UIWidget*)parent;

- (void)SetRegion:(CGRect)region;

- (void)SetScreenRegion:(CGRect)region;

- (void)RemoveAllChild;

- (void)RemoveChild:(UIWidget*)child;


- (void)uiMain:(float)elapse;
- (void)uiDraw;
- (void)uiDrawFG;
- (BOOL)uiEvent:(NSArray*)events;

- (BOOL)isInArea:(CGPoint)point;


@end
