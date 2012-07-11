//
//  Task.h
//  HIFramework
//
//  Created by He jia bin on 6/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"


#define TASK_STATUS_IDLE        1
#define TASK_STATUS_ADDING      2
#define TASK_STATUS_REMOVING    3
#define TASK_STATUS_RUNNING     4


@interface Task : NSObject
{
    //TODO 
}

@property (nonatomic, readwrite) int STATUS;


- (void)Start;

- (void)Stop;

- (void)onBegin;

- (void)onEnd;

- (void)onFrame:(float)elapse;

- (void)onDraw:(float)elapse;

- (BOOL)onTouchEvent:(NSArray*)events;

- (void)onDestory;

@end
