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
- (BOOL)BLOCK_EVENT { return m_isBlockEvent; }
- (void)setSHOW:(BOOL)SHOW { m_isShow = SHOW; }
- (void)setENABLE:(BOOL)ENABLE { m_isEnable = ENABLE; }
- (void)setBLOCK_EVENT:(BOOL)BLOCK_EVENT { m_isBlockEvent = BLOCK_EVENT; }


/**
 * @desc    frame update
 * @para    elapse
 * @return  none
 */
- (void)onUIFrame:(float)elapse
{
    //TODO  
}


/**
 * @desc    render update
 * @para    elapse
 * @return  none
 */
- (void)onUIDraw:(float)elapse
{
    //TODO 
}


/**
 * @desc    event handle
 * @para    events  
 * @return  if any widget handle the event
 */
- (BOOL)onUIEvents:(NSArray*)events
{
    //TODO 
    
    return NO;
}


/**
 * @desc    set parents
 * @para    parent
 * @return  none
 */
- (void)SetParent:(UIWidget*)parent
{
    //TODO 
}


/**
 * @desc    set region
 * @para    region
 * @return  none
 */
- (void)SetRegion:(CGRect)region
{
    //TODO 
}


/**
 * @desc    set screen region
 * @para    region
 * @return  none
 */
- (void)SetScreenRegion:(CGRect)region
{
    //TODO 
}


/**
 * @desc    remove all child
 * @para    none
 * @return  none
 */
- (void)RemoveAllChild
{
    //TODO 
}


/**
 * @desc    remove child
 * @para    child   
 * @return  none
 */
- (void)RemoveChild:(UIWidget*)child
{
    //TODO 
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
    //TODO 
    
    return NO;
}


@end
