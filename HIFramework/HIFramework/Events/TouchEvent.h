//
//  TouchEvent.h
//  HIFramework
//
//  Created by He JiaBin on 12-6-22.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UNTOUCH 1
#define TOUCH   2
#define MOVE    3


@interface TouchEvent : NSObject
{
    //TODO 
}

@property (nonatomic, readwrite) int _type;
@property (nonatomic, readwrite) int _x;
@property (nonatomic, readwrite) int _y;

@end
