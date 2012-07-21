//
//  GUICheckBox.m
//  HIFramework
//
//  Created by He JiaBin on 12-7-21.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "GUICheckBox.h"
#import "GraphicFactory.h"
#import "TouchEvent.h"


@implementation GUICheckBox

@synthesize CHECKED = m_isChecked;


/**
 * @desc    constructor
 * @para    imgName
 * @return  self
 */
- (id)initWithRes:(NSString*)imgName
{
    [super init];
    
    m_callback = nil;
    m_isChecked = NO;
    
    m_imgChecked = [[GraphicFactory sharedInstance] CreateSprite:imgName];
    m_imgUnChecked = [[GraphicFactory sharedInstance] CreateSprite:imgName];
    
    return self;
}


/**
 * @desc    deconstructor
 * @para    none
 * @return  none
 */
- (void)dealloc
{
    [m_imgChecked release];
    [m_imgUnChecked release];
    
    [super dealloc];
}


/**
 * @desc    set the checked image for checkbox
 * @para    uvLeftTop
 * @para    uvRightDown
 * @return  none
 */
- (void)SetCheckedUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown
{
    [m_imgChecked SetUVFrom:uvLeftTop to:uvRightDown];
}


/**
 * @desc    set the unchecked image for checkbox
 * @para    uvLeftTop
 * @para    uvRightDown
 * @return  none
 */
- (void)SetUnCheckedUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown
{
    [m_imgUnChecked SetUVFrom:uvLeftTop to:uvRightDown];
}


/**
 * @desc    set the callback of this button
 * @para    callback
 * @return  none
 */
- (void)SetCallback:(id<ICheckBoxCallback>)callback
{
    m_callback = callback;
}


// draw the controller
- (void)uiDraw 
{
    if( m_isEnable == YES )
    {
        if( m_isChecked == YES )
        {
            [m_imgChecked DrawAt:CGPointMake(m_screenX, m_screenY) withSize:CGPointMake(m_width, m_height)];
        }
        else
        {
            [m_imgUnChecked DrawAt:CGPointMake(m_screenX, m_screenY) withSize:CGPointMake(m_width, m_height)];
        }
    }
    else
    {
        [m_imgUnChecked DrawAt:CGPointMake(m_screenX, m_screenY) withSize:CGPointMake(m_width, m_height)];
    }
}


// handle the ui event
- (BOOL)uiEvent:(NSArray*)events 
{ 
    TouchEvent* evt = [events objectAtIndex:0];
    
    switch( evt.TOUCH_TYPE )
    {
        case TOUCH:
            if( [self isInArea:CGPointMake( evt.X, evt.Y )] == YES )
            {
                m_isChecked = !m_isChecked;
                if( m_callback != nil )
                {
                    [m_callback onCheckBoxCheck:self];
                }
                
                return true;
            }
            break;
        case UNTOUCH:
            break;
        case MOVE:
            break;
        default:
            break;
    }
    
    return NO; 
}

@end
