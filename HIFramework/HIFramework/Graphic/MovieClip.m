//
//  MovieClip.m
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 FancyBlockGames. All rights reserved.
//

#import "MovieClip.h"
#import "GraphicFactory.h"

@implementation frameInfo

@synthesize U1;
@synthesize V1;
@synthesize U2;
@synthesize V2;
@synthesize ANCHOR_X;
@synthesize ANCHOR_Y;

@end


@implementation MovieClip

@synthesize INTERVAL;

/**
 * @desc    property setter & getter
 */
- (void)setTEXTURE:(NSString*)imgName
{
    m_texImgName = imgName;
    
    m_sprite = [[GraphicFactory sharedInstance] CreateSprite:imgName];
    m_frameList = [[NSMutableArray alloc] init];
    
    m_times = 0.0f;
}

- (NSString*)TEXTURE
{
    return m_texImgName;
}


/**
 * @desc    deconstructor
 * @para    none
 * @return  none
 */
- (void)dealloc
{
    [super dealloc];
    
    [m_frameList removeAllObjects];
    [m_frameList release];
}


/**
 * @desc    add a frame
 * @para    region
 * @para    anchor
 * @return  none
 */
- (void)AddFrame:(CGRect)region withAnchor:(CGPoint)anchor
{
    frameInfo* frame = [[frameInfo alloc] init];
    
    frame.U1 = region.origin.x;
    frame.V1 = region.origin.y;
    frame.U2 = region.origin.x + region.size.width;
    frame.V2 = region.origin.y + region.size.height;
    
    [m_frameList addObject:frame];
    [frame release];
}


/**
 * @desc    update the animation
 * @para    elapsed
 * @return  none
 */
- (void)Update:(float)elapsed
{
    m_times += elapsed;
}


/**
 * @desc    render
 * @para    none
 * @return  none
 */
- (void)Draw
{
    int frameIndex = (int)( m_times / self.INTERVAL );
    
    frameIndex = frameIndex % [m_frameList count];
    
    frameInfo* info = [m_frameList objectAtIndex:frameIndex];
    [m_sprite SetUVFrom:CGPointMake( info.U1, info.V1 ) to:CGPointMake( info.U2, info.V2 )];
    [m_sprite SetAnchor:CGPointMake( info.ANCHOR_X, info.ANCHOR_Y )];
    
    [m_sprite DrawAt:CGPointMake( m_x, m_y )];
}


/**
 * @desc    reset the animation
 * @para    none
 * @return  none
 */
- (void)Reset
{
    m_times = 0.0f;
}


/**
 * @desc    set the position of the MovieClip
 * @para    position
 * @return  none
 */
- (void)SetPosition:(CGPoint)position
{
    m_x = position.x;
    m_y = position.y;
}


@end
