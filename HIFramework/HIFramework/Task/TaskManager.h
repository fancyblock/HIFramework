//
//  TaskManager.h
//  HIFramework
//
//  Created by He jia bin on 6/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskManager : NSObject
{
    NSMutableArray* m_taskList;
    NSMutableArray* m_pendingTasks;
    NSMutableArray* m_runningTasks;
}

+ (TaskManager*)sharedInstance;


- (BOOL)AddTask:(Task*)task;

- (BOOL)StartTask:(Task*)task;

- (BOOL)StopTask:(Task*)task;

- (void)Main:(float)elapsed;

- (void)Draw:(float)elapsed;

- (void)ProcessPending;

- (void)RemoveAllTasks;

- (void)onTouchEvent:(NSArray*)events;

@end
