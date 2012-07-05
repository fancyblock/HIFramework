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
 * @desc    initial
 * @para    none
 * @return  self
 */
- (id)init
{
    [super init];
    
    m_pendingTasks = [[NSMutableArray alloc] init];
    m_runningTasks = [[NSMutableArray alloc] init];
    m_taskList = [[NSMutableArray alloc] init];
    
    return self;
}


/**
 * @desc    add a new task to the taskManager
 * @para    task
 * @return  success or fail
 **/
- (BOOL)AddTask:(Task*)task
{
    if( task == nil )
    {
        return NO;
    }
    
    [m_taskList addObject:task];
    task.STATUS = TASK_STATUS_IDLE;
    
    return YES;
}


/**
 * @desc    start a task
 * @para    task
 * @return  success or fail
 */
- (BOOL)StartTask:(Task*)task
{
    if( task.STATUS != TASK_STATUS_IDLE )
    {
        return NO;
    }
    
    task.STATUS = TASK_STATUS_ADDING;
    [m_pendingTasks addObject:task];
    
    return YES;
}


/**
 * @desc    stop a task
 * @para    task
 * @return  success or fail
 */
- (BOOL)StopTask:(Task*)task
{
    if( task.STATUS != TASK_STATUS_RUNNING )
    {
        return NO;
    }
    
    task.STATUS = TASK_STATUS_REMOVING;
    [m_pendingTasks addObject:task];
    
    return YES;
}


/**
 * @desc    main loop , process all the task
 * @para    elapsed
 * @return  none
 */
- (void)Main:(float)elapsed
{
    int i;
    int count;
    Task* task;
    
    count = [m_runningTasks count];
    for( i = 0; i < count; i++ )
    {
        task = [m_runningTasks objectAtIndex:i];
        [task onFrame:elapsed];
    }
}


/**
 * @desc    render process, invoke all the render part of the task
 * @para    elapsed
 * @return  none
 */
- (void)Draw:(float)elapsed
{
    int i;
    int count;
    Task* task;
    
    count = [m_runningTasks count];
    for( i = 0; i < count; i++ )
    {
        task = [m_runningTasks objectAtIndex:i];
        [task onDraw:elapsed];
    }
}


/**
 * @desc    process pending tasks
 * @para    none
 * @return  none
 */
- (void)ProcessPending
{
    int i;
    int count;
    Task* task;
    NSException* exception;
    
    count = [m_pendingTasks count];
    for( i = 0; i < count; i++ )
    {
        task = [m_pendingTasks objectAtIndex:i];
        
        if( task.STATUS == TASK_STATUS_ADDING )
        {
            [task onBegin];
            task.STATUS = TASK_STATUS_RUNNING;
            [m_runningTasks addObject:task];
        }
        else if( task.STATUS == TASK_STATUS_REMOVING )
        {
            if( [m_runningTasks containsObject:task] == YES )
            {
                [task onEnd];
                task.STATUS = TASK_STATUS_IDLE;
                [m_runningTasks removeObject:task];
            }
            else 
            {
                exception = [NSException exceptionWithName:@"Removing task error" 
                                                    reason:@"The removed task no contain in the running task list" 
                                                  userInfo:nil];
                @throw exception;
            }
        }
        else 
        {
            exception = [NSException exceptionWithName:@"Wrong pending task" 
                                                reason:@"The status of the pending task must be ADDING or REMOVING" 
                                              userInfo:nil];
            @throw exception;
        }
    }
    
    [m_pendingTasks removeAllObjects];
}


/**
 * @desc    inject the touch event to the game
 * @para    events
 * @return  none
 */
- (void)onTouchEvent:(NSArray*)events
{
    int i;
    int count;
    Task* task;
    
    count = [m_runningTasks count];
    for( i = 0; i < count; i++ )
    {
        task = [m_runningTasks objectAtIndex:i];
        
        if( task.STATUS == TASK_STATUS_RUNNING )
        {
            if( [task onTouchEvent:events] == YES )
            {
                return;
            }
        }
    }
}


/**
 * @desc    remove & clean all the tasks
 * @para    none
 * @return  none
 */
- (void)RemoveAllTasks
{
    int i;
    int count;
    Task* task;
    
    count = [m_runningTasks count];
    for( i = 0; i < count; i++ )
    {
        task = [m_runningTasks objectAtIndex:i];
        [task onEnd];
    }
    
    [m_runningTasks removeAllObjects];
    [m_pendingTasks removeAllObjects];
    
    count = [m_taskList count];
    for( i = 0; i < count; i++ )
    {
        task = [m_taskList objectAtIndex:i];
        [task onDestory];
    }
    
    [m_taskList removeAllObjects];
}


@end
