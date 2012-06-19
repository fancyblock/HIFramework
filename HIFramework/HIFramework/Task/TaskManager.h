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
    //TODO 
}

+ (TaskManager*)sharedInstance;


- (BOOL)AddTask:(Task*)task;

- (BOOL)StartTask:(Task*)task;

- (BOOL)StopTask:(Task*)task;

@end
