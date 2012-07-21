//
//  GUIButton.m
//  HIFramework
//
//  Created by He JiaBin on 12-7-21.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "GUIButton.h"
#import "TouchEvent.h"

@implementation GUIButton


/**
 * @desc    constructor
 * @para    imgName
 * @return  self
 */
- (id)initWithRes:(NSString *)imgName
{
    [super init];
    
    m_callback = nil;
    m_isDown = NO;
    m_tracking = NO;
    
    m_imgUp = [[GraphicFactory sharedInstance] CreateSprite:imgName];
    m_imgDown = [[GraphicFactory sharedInstance] CreateSprite:imgName];
    m_imgDisable = [[GraphicFactory sharedInstance] CreateSprite:imgName];
    
    return self;
}


/**
 * @desc    deconstructor
 * @para    none
 * @return  none
 */
- (void)dealloc
{
    [m_imgUp release];
    [m_imgDown release];
    [m_imgDisable release];
    
    [super dealloc];
}


/**
 * @desc    getter
 */
- (BOOL)IsDown  { return m_isDown; }


/**
 * @desc    set the up image of button
 * @para    uvLeftTop
 * @para    uvRightDown
 * @return  none
 */
- (void)SetUpUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown
{
    [m_imgUp SetUVFrom:uvLeftTop to:uvRightDown];
}


/**
 * @desc    set the up image of button
 * @para    uvLeftTop
 * @para    uvRightDown
 * @return  none
 */
- (void)SetDownUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown
{
    [m_imgDown SetUVFrom:uvLeftTop to:uvRightDown];
}


/**
 * @desc    set the up image of button
 * @para    uvLeftTop
 * @para    uvRightDown
 * @return  none
 */
- (void)SetDisableUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown
{
    [m_imgDisable SetUVFrom:uvLeftTop to:uvRightDown];
}


/**
 * @desc    set the callback of this button
 * @para    callback
 * @return  none
 */
- (void)SetCallback:(id<IButtonCallback>)callback
{
    m_callback = callback;
}


// draw button
- (void)uiDraw
{
    if( m_isEnable == YES )
    {
        if( m_isDown == YES )
        {
            [m_imgDown DrawAt:CGPointMake(self.SCREEN_POS_X, self.SCREEN_POS_Y) 
                     withSize:CGPointMake(self.WIDTH, self.HEIGHT)];
        }
        else
        {
            [m_imgUp DrawAt:CGPointMake(self.SCREEN_POS_X, self.SCREEN_POS_Y) 
                   withSize:CGPointMake(self.WIDTH, self.HEIGHT)];
        }
    }
    else
    {
        [m_imgDisable DrawAt:CGPointMake(self.SCREEN_POS_X, self.SCREEN_POS_Y) 
                    withSize:CGPointMake(self.WIDTH, self.HEIGHT)];
    }
}


// handle the ui event
- (BOOL)uiEvent:(NSArray*)events
{
    // if the button enable is false, do not process any event
    if( m_isEnable == NO )	return NO;
    
    TouchEvent* evt = [events objectAtIndex:0];
    BOOL btnDown;
    
    switch( evt.TOUCH_TYPE )
    {
        case TOUCH:
            if( [self isInArea:CGPointMake(evt.X, evt.Y)] == YES )
            {
                m_tracking = YES;
                m_isDown = YES;
                if( m_callback != nil )
                {
                    [m_callback onButtonDown:self];
                }
                
                return YES;
            }
            break;
        case UNTOUCH:
            btnDown = m_isDown;
            m_tracking = NO;
            m_isDown = NO;
            if( btnDown == YES && m_callback != nil )
            {
                [m_callback onButtonClick:self];
                [m_callback onButtonUp:self];
                
                return YES;
            }
            break;
        case MOVE:
            if( m_tracking == YES )
            {
                if( [self isInArea:CGPointMake(evt.X, evt.Y)] == YES )
                {
                    m_isDown = YES;
                }
                else
                {
                    if( m_isDown == true && m_callback != nil )
                    {
                        [m_callback onButtonUp:self];
                    }
                    
                    m_isDown = NO;
                }
                
                return YES;
            }
            break;
        default:
            break;
    }
    
    return NO;
}

@end
