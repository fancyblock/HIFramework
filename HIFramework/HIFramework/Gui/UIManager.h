//
//  UIManager.h
//  HIFramework
//
//  Created by He jia bin on 7/11/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIManager : NSObject
{
    //TODO 
}

+ (UIManager*)sharedInstance;


- (BOOL)onTouchEvent:(NSArray*)events;


@end
