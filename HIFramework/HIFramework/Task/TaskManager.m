//
//  TaskManager.m
//  HIFramework
//
//  Created by He jia bin on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskManager.h"

@implementation TaskManager

static TaskManager* m_instance;


/**
 * @desc    return the singleton of this class
 * @para    none
 * @return  the singleton
 */
+ (TaskManager*)sharedInstance
{
    if( m_instance == nil )
    {
        m_instance = [[TaskManager alloc] init];
    }
    
    return  m_instance;
}


@end
