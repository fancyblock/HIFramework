//
//  UIWidget.m
//  HIFramework
//
//  Created by He jia bin on 7/13/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "UIWidget.h"

@implementation UIWidget


/**
 * @desc    constructor
 * @para    none
 * @return  self
 */
- (id)init
{
    [super init];
    
    m_children = [[NSMutableArray alloc] init];
    m_parent = nil;
    m_isEnable = YES;
    m_isShow = YES;
    m_isUnBlockEvent = NO;
    
    return self;
}


/**
 * @desc    deconstructor
 * @para    none
 * @return  none
 */
- (void)dealloc
{
    [m_children removeAllObjects];
    [m_children release];
    
    [super dealloc];
}


/**
 * @desc    property getter
 */
- (float)POS_X { return m_x; }
- (float)POS_Y { return m_y; }
- (float)SCREEN_POS_X { return m_screenX; }
- (float)SCREEN_POS_Y { return m_screenY; }
- (float)WIDTH { return m_width; }
- (float)HEIGHT { return m_height; }
- (NSArray*)CHILDREN { return m_children; }


/**
 * @desc    property getter & setter
 */
- (BOOL)SHOW { return m_isShow; }
- (BOOL)ENABLE { return m_isEnable; }
- (BOOL)UNBLOCK_EVENT { return m_isUnBlockEvent; }
- (void)setSHOW:(BOOL)SHOW { m_isShow = SHOW; }
- (void)setENABLE:(BOOL)ENABLE { m_isEnable = ENABLE; }
- (void)setUNBLOCK_EVENT:(BOOL)BLOCK_EVENT { m_isUnBlockEvent = BLOCK_EVENT; }


/**
 * @desc    frame update
 * @para    elapse
 * @return  none
 */
- (void)onUIFrame:(float)elapse
{
    if( m_parent != nil )
    {
        m_screenX = m_parent.SCREEN_POS_X + m_x;
        m_screenY = m_parent.SCREEN_POS_Y + m_y;
    }
    
    [self uiMain:elapse];
    
    UIWidget* child;
    int len = [m_children count];
    for( int i = 0; i < len; i++ )
    {
        child = [m_children objectAtIndex:i];
        [child onUIFrame:elapse];
    }
    
}


/**
 * @desc    render update
 * @para    none
 * @return  none
 */
- (void)onUIDraw
{
    if( m_isShow == NO )
    {
        return;
    }
    
    [self uiDraw];
    
    UIWidget* child;
    int len = [m_children count];
    for( int i = 0; i < len; i++ )
    {
        child = [m_children objectAtIndex:i];
        [child onUIDraw];
    }
    
    [self uiDrawFG];
    
}


/**
 * @desc    event handle
 * @para    events  
 * @return  if any widget handle the event
 */
- (BOOL)onUIEvents:(NSArray*)events
{
    if( m_isEnable == NO || m_isShow == NO )
    {
        return NO;
    }
    
    UIWidget* child;
    int len = [m_children count];
    for( int i = 0; i < len; i++ )
    {
        child = [m_children objectAtIndex:i];
        if( [child onUIEvents:events] == YES )
        {
            return YES;
        }
    }
    
    BOOL process = [self uiEvent:events];
    if( m_isUnBlockEvent == YES )
    {
        return NO;
    }
    
    return process;
}


/**
 * @desc    set parents
 * @para    parent
 * @return  none
 */
- (void)SetParent:(UIWidget*)parent
{
    if( m_parent == parent )
    {
        return;
    }
    
    if( m_parent != nil )
    {
        [m_parent RemoveChild:self];
    }
    
    m_parent = parent;
    
    if( m_parent != nil )
    {
        [m_parent.CHILDREN addObject:self];
    }
}


/**
 * @desc    set region
 * @para    region
 * @return  none
 */
- (void)SetRegion:(CGRect)region
{
    m_x = region.origin.x;
    m_y = region.origin.y;
    
    m_width = region.size.width;
    m_height = region.size.height;
}


/**
 * @desc    set screen region
 * @para    region
 * @return  none
 */
- (void)SetScreenRegion:(CGRect)region
{
    m_screenX = region.origin.x;
    m_screenY = region.origin.y;
    
    m_width = region.size.width;
    m_height = region.size.height;
}


/**
 * @desc    remove all child
 * @para    none
 * @return  none
 */
- (void)RemoveAllChild
{
    UIWidget* child;
    int len = [m_children count];
    for( int i = 0; i < len; i++ )
    {
        child = [m_children objectAtIndex:i];
        [child SetParent:nil];
    }
}


/**
 * @desc    remove child
 * @para    child   
 * @return  none
 */
- (void)RemoveChild:(UIWidget*)child
{
    [child SetParent:nil];
}


//------------------------ be implement ------------------------

- (void)uiMain:(float)elapse {}
- (void)uiDraw {}
- (void)uiDrawFG {}
- (BOOL)uiEvent:(NSArray*)events { return NO; }

//---------------------- private function ----------------------

// judge if this point is in widget's area or not
- (BOOL)isInArea:(CGPoint)point
{
    if( point.x >= m_screenY && point.x <= ( m_screenX + m_width ) &&
        point.y >= m_screenY && point.y <= ( m_screenY + m_height ) )
    {
        return YES;
    }
    
    return NO;
}


@end
