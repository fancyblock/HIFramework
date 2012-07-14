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
    m_spr = [[GraphicFactory sharedInstance] CreateSprite:@"snake.png"];
    [m_spr SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    [m_spr SetSize:CGPointMake(100, 100)];
    
    m_spr2 = [[GraphicFactory sharedInstance] CreateSprite:@"05.png"];
    [m_spr2 SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    [m_spr2 SetSize:CGPointMake(230, 230)];
    
    m_spr3 = [[GraphicFactory sharedInstance] CreateSprite:@"nackm.png"];
    [m_spr3 SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    [m_spr3 SetSize:CGPointMake(50, 50)];
    [m_spr3 SetAnchor:CGPointMake(0.5f, 0.5f)];
}

- (void)onEnd
{
    [m_spr release];
    [m_spr2 release];
}

- (void)onFrame:(float)elapse
{
}

- (void)onDraw:(float)elapse
{
    [m_spr2 SetAnchor:CGPointMake(0.5f, 0.5f)];
    [m_spr2 DrawAt:CGPointMake(160, 240)];
    
    //[m_spr SetColorR:1.0f andG:0.5f andB:0.25f andAlpha:1.0f];
    [m_spr SetAnchor:CGPointMake(0.5f, 0.5f)];
    [m_spr DrawAt:CGPointMake(150, 150) withSize:CGPointMake(200, 200) andAngle:0.0f];
    
    [m_spr3 DrawAt:CGPointMake(200, 200)];
}


- (BOOL)onTouchEvent:(NSArray*)events
{
    if( [events count] > 0 )
    {
        NSLog( @"Touch Cnt: %d", [events count] );
    }
    
    for( int i = 0; i < [events count]; i++ )
    {
        TouchEvent* evt = [events objectAtIndex:i];
        
        NSLog( @"%.2f , %.2f", evt.X, evt.Y );
    }
    
    return NO; 
}


- (void)onDestory{}

@end
