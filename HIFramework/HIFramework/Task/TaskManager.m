//
//  TaskManager.m
//  HIFramework
//
//  Created by He jia bin on 6/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "TaskManager.h"

@implementation TaskManager

static TaskManager* m_instance;
static BOOL m_saftFlag = NO;


/**
 * @desc    return the singleton of this class
 * @para    none
 * @return  the singleton
 */
+ (TaskManager*)sharedInstance
{
    if( m_instance == nil )
    {
        m_saftFlag = YES;
        m_instance = [[TaskManager alloc] init];
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
        NSException* exception = [NSException exceptionWithName:@"Alloc Error" reason:@"TaskManager is a singleton , can not be alloc directly" userInfo:nil];
        @throw exception;
        
        return nil;
    }
    
    return [super alloc];
}


/**
 * @desc    add a new task to the taskManager
 * @para    task
 * @return  success or fail
 **/
- (BOOL)AddTask:(Task*)task
{
    //TODO
    
    return YES;
}


/**
 * @desc    start a task
 * @para    task
 * @return  success or fail
 */
- (BOOL)StartTask:(Task*)task
{
    //TODO 
    
    return YES;
}


/**
 * @desc    stop a task
 * @para    task
 * @return  success or fail
 */
- (BOOL)StopTask:(Task*)task
{
    //TODO 
    
    return YES;
}


//TODO 


@end
