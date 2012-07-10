//
//  TestTask.m
//  HIFramework
//
//  Created by He JiaBin on 12-7-10.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "TestTask.h"

@implementation TestTask

- (void)onBegin
{
    m_spr = [[GraphicFactory sharedInstance] CreateSprite:@"nackm.png"];
    [m_spr SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    [m_spr SetSize:CGPointMake(100, 100)];
    
    
}

- (void)onEnd{}

- (void)onFrame:(float)elapse
{
}

- (void)onDraw:(float)elapse
{    
    [m_spr SetAnchor:CGPointMake(0.5f, 0.5f)];

    [m_spr DrawAt:CGPointMake(150, 150) withSize:CGPointMake(200, 200) andAngle:3.14f];
}


- (BOOL)onTouchEvent:(NSArray*)events{ return NO; }
- (void)onDestory{}

@end
