//
//  SoundManager.h
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NONE_SOUND_ID   -1
#define INFINITE_LOOP   -1


@interface SoundManager : NSObject
{
    NSMutableArray* m_soundList;
}

+ (SoundManager*)sharedInstance;


- (int)LoadSound:(NSString*)fileName;

- (void)PlaySound:(int)soundId withLoop:(int)times;

- (void)StopSound:(int)soundId;


@end
