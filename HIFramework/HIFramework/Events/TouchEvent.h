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

@property (nonatomic, readwrite) int TOUCH_TYPE;
@property (nonatomic, readwrite) float X;
@property (nonatomic, readwrite) float Y;

@end
