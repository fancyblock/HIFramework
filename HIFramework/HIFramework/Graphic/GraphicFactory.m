//
//  GraphicFactory.m
//  HIFramework
//
//  Created by He JiaBin on 12-7-3.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "GraphicFactory.h"
#import "RenderCore.h"

@interface GraphicFactory(private)

- (BOOL)createTexture:(NSString*)imgName;

@end

@implementation GraphicFactory

static GraphicFactory* m_instance = nil;
static BOOL m_safeFlag = NO;


/**
 * @desc    return the singleton of this class
 * @para    none
 * @return  the singleton
 */
+ (GraphicFactory*)sharedInstance
{
    if( m_instance == nil )
    {
        m_safeFlag = YES;
        m_instance = [[GraphicFactory alloc] init];
        m_safeFlag = NO;
    }
    
    return m_instance;
}


/**
 * @desc    constructor
 * @para    none
 * @return  self
 */
+ (id)alloc
{
    if( m_safeFlag == NO )
    {
        NSException* exception = [NSException exceptionWithName:@"Alloc Error" reason:@"GraphicFactory is a singleton , can not be alloc directly" userInfo:nil];
        @throw exception;
        
        return nil;
    }
    
    return [super alloc];
}


/**
 * @desc    create sprite
 * @para    imgName
 * @return  sprite
 */
- (Sprite*)CreateSprite:(NSString*)imgName
{
    Sprite* spr = [[Sprite alloc] init];
    
    int texIndex = NO_TEXTURE;
    
    [self createTexture:imgName];
    
    texIndex = [[RenderCore sharedInstance] GetTextureInfo:imgName].INDEX;
    
    spr.TEXTURE_INDEX = texIndex;
    spr.TEXTURE_NAME = imgName;
    
    return spr;
}


/**
 * @desc    create movieclip
 * @para    imgName
 * @para    interval
 * @return  movieClip
 */
- (MovieClip*)CreateMovieClip:(NSString*)imgName withInterval:(float)interval
{
    MovieClip* mc = [[MovieClip alloc] init];
    
    int texIndex = NO_TEXTURE;
    
    [self createTexture:imgName];
    
    texIndex = [[RenderCore sharedInstance] GetTextureInfo:imgName].INDEX;
    
    mc.TEXTURE = imgName;
    mc.INTERVAL = interval;
    
    return mc;
}


//TODO 


//------------------------------------------ private function ------------------------------------------


// create new texture
- (BOOL)createTexture:(NSString*)imgName
{
    if( [[RenderCore sharedInstance] IsTextureExist:imgName] == NO )
    {
        if( [[RenderCore sharedInstance] CreateTexture:imgName] == NO )
        {
            NSException* exception = [NSException exceptionWithName:@"Texture Create Error" reason:@"Create texture fail" userInfo:nil];
            @throw exception;
        }
    }
    
    return YES;
}


@end
