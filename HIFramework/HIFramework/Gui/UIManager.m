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
    
    //TODO 
    
    return self;
}


/**
 * @desc    inject the events to the ui system
 * @para    events
 * @return  return YES if any ui widget get the event
 */
- (BOOL)onTouchEvent:(NSArray*)events
{
    //TODO 
    
    return NO;
}


@end
