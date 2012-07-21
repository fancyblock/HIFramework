//
//  UIManager.m
//  HIFramework
//
//  Created by He jia bin on 7/11/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "UIManager.h"

@implementation UIManager

static UIManager* m_instance;
static BOOL m_saftFlag = NO;


/**
 * @desc    return the singleton of this class
 * @para    none
 * @return  the singleton
 */
+ (UIManager*)sharedInstance
{
    if( m_instance == nil )
    {
        m_saftFlag = YES;
        m_instance = [[UIManager alloc] init];
        m_saftFlag = NO;
    }
    
    return  m_instance;
}


/**
 * @desc    constructor
 * @para    none
 * @return  self
 */
+ (id)alloc
{
    if( m_saftFlag == NO )
    {
        NSException* exception = [NSException exceptionWithName:@"Alloc Error" reason:@"UIManager is a singleton , can not be alloc directly" userInfo:nil];
        @throw exception;
        
        return nil;
    }
    
    return [super alloc];
}


/**
 * @desc    initial
 * @para    none
 * @return  self
 */
- (id)init
{
    [super init];
    
    m_root = [[UIWidget alloc] init];
    
    return self;
}


/**
 * @desc    add a widget to the ui root
 * @para    widget
 * @return  none
 */
- (void)AddToRoot:(UIWidget*)widget
{
    [widget SetParent:m_root];
}


/**
 * @desc    remove all the ui
 * @para    none
 * @return  none
 */
- (void)CleanWidget
{
    [m_root RemoveAllChild];
}


/**
 * @desc    ui main
 * @para    elapsed
 * @return  none
 */
- (void)UIMain:(float)elapsed
{
    [m_root onUIFrame:elapsed];
}


/**
 * @desc    ui draw
 * @para    elapsed
 * @return  none
 */
- (void)UIDraw:(float)elapsed
{
    [m_root onUIDraw];
}


/**
 * @desc    inject the events to the ui system
 * @para    events
 * @return  return YES if any ui widget get the event
 */
- (BOOL)onTouchEvent:(NSArray*)events
{
    return [m_root onUIEvents:events];
}


@end
