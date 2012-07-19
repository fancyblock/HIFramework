//
//  SoundManager.m
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "SoundManager.h"
#import "PlayerController.h"
#import <AVFoundation/AVAudioPlayer.h>


@implementation SoundManager

static SoundManager* m_instance;
static BOOL m_saftFlag = NO;


/**
 * @desc    return the singleton of this class
 * @para    none
 * @return  the singleton
 */
+ (SoundManager*)sharedInstance
{
    if( m_instance == nil )
    {
        m_saftFlag = YES;
        m_instance = [[SoundManager alloc] init];
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
        NSException* exception = [NSException exceptionWithName:@"Alloc Error" reason:@"SoundManager is a singleton , can not be alloc directly" userInfo:nil];
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
    
    m_soundList = [[NSMutableArray alloc] init];
    
    return self;
}


/**
 * @desc    load sound
 * @para    fileName
 * @return  sound id
 */
- (int)LoadSound:(NSString*)fileName
{
    int soundId = NONE_SOUND_ID;
    
    NSRange range = [fileName rangeOfString:@"." options:NSBackwardsSearch];
    NSInteger strLen = [fileName length];
    NSInteger pointPos = range.location;
    
    range.location = 0;
    range.length = pointPos;
    NSString* mainName = [fileName substringWithRange:range];
    
    range.location = pointPos + 1;
    range.length = strLen - pointPos - 1;
    NSString* extName = [fileName substringWithRange:range];
    
    NSURL* fileURL = [[NSBundle mainBundle] URLForResource:mainName withExtension:extName];
    
    NSError* errorInfo = [[NSError alloc] init];
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&errorInfo];
    
    // load sound resource fail
    if( errorInfo != nil )
    {
        NSException* exception = [NSException exceptionWithName:@"SoundLoad Error" reason:[errorInfo localizedDescription]  userInfo:nil];
        @throw exception;
        
        [errorInfo release];
        
        return soundId;
    }
    
    [errorInfo release];
    
    PlayerController* controller = [[PlayerController alloc] init];
    player.delegate = controller;
    
    [m_soundList addObject:player];
    soundId = [m_soundList count] - 1;
    
    [player release];
    
    return soundId;
}


/**
 * @desc    play sound
 * @para    soundId
 * @para    times   loop times
 * @return  none
 */
- (void)PlaySound:(int)soundId withLoop:(int)times
{
    if( soundId == NONE_SOUND_ID )
    {
        return;
    }
    
    AVAudioPlayer* player = [m_soundList objectAtIndex:soundId];
    
    PlayerController* controller = (PlayerController*)player.delegate;
    
    if( times > 0 )
    {
        times--;
    }
    
    controller.LOOP_TIMES = times;
    
    [player play];
}


/**
 * @desc    stop sound
 * @desc    soundId
 * @return  none
 */
- (void)StopSound:(int)soundId
{
    if( soundId == NONE_SOUND_ID )
    {
        return;
    }
    
    AVAudioPlayer* player = [m_soundList objectAtIndex:soundId];
    
    [player stop];
    
}


@end
