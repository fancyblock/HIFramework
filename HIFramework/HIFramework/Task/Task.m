//
//  Task.m
//  HIFramework
//
//  Created by He jia bin on 6/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "Task.h"
#import "TaskManager.h"

@implementation Task

@synthesize STATUS;


/**
 * @desc    init function
 * @para    none
 * @return  self
 */
- (id)init
{
    [super init];
    
    self.STATUS = TASK_STATUS_IDLE;
    [[TaskManager sharedInstance] AddTask:self];
    
    return self;
}


/**
 * @desc    start
 * @para    none
 * @return  none
 */
- (void)Start
{
    [[TaskManager sharedInstance] StartTask:self];
}


/**
 * @desc    stop
 * @para    none
 * @return  none
 */
- (void)Stop
{
    [[TaskManager sharedInstance] StopTask:self];
}


/**
 * @desc    callback functions , must be implemented by subclass
 */
- (void)onBegin{}
- (void)onEnd{}
- (void)onFrame:(float)elapse{}
- (void)onDraw:(float)elapse{}
- (BOOL)onTouchEvent:(NSArray*)events{ return NO; }
- (void)onDestory{}


@end
