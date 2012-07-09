//
//  Sprite.m
//  HIFramework
//
//  Created by He JiaBin on 12-7-1.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "Sprite.h"
#import "RenderCore.h"

@implementation Sprite

@synthesize U1;
@synthesize V1;
@synthesize U2;
@synthesize V2;

@synthesize X1;
@synthesize Y1;
@synthesize X2;
@synthesize Y2;
@synthesize X3;
@synthesize Y3;
@synthesize X4;
@synthesize Y4;

@synthesize COLOR_R;
@synthesize COLOR_G;
@synthesize COLOR_B;
@synthesize COLOR_A;
@synthesize TEXTURE_INDEX;
@synthesize TEXTURE_NAME;



/**
 * @desc    constructor
 * @para    none
 * @return  id  self
 */
- (id)init
{
    [super init];
    
    self.COLOR_R = 1.0f;
    self.COLOR_G = 1.0f;
    self.COLOR_B = 1.0f;
    self.COLOR_A = 1.0f;
    
    m_anchorX = 0.0f;
    m_anchorY = 0.0f;
    
    return self;
}


/**
 * @desc    draw the sprite
 * @para    none
 * @return  none
 */
- (void)Draw
{
    self.X1 = m_x - m_anchorX;
    self.Y1 = m_y - m_anchorX;
    
    self.X3 = self.X1 + m_width;
    self.Y3 = self.Y1 + m_height;
    
    self.X2 = self.X3;
    self.Y2 = self.Y1;
    
    self.X4 = self.X1;
    self.Y4 = self.Y3;
    
    [[RenderCore sharedInstance] AddSprite:self];
}


/**
 * @desc    draw the sprite at pt position
 * @para    pt
 * @return  none
 */
- (void)DrawAt:(CGPoint)pt
{
    self.X1 = pt.x - m_anchorX;
    self.Y1 = pt.y - m_anchorX;
    
    self.X3 = self.X1 + m_width;
    self.Y3 = self.Y1 + m_height;
    
    self.X2 = self.X3;
    self.Y2 = self.Y1;
    
    self.X4 = self.X1;
    self.Y4 = self.Y3;
    
    [[RenderCore sharedInstance] AddSprite:self];
}


//TODO


/**
 * @desc    set anchor
 * @para    anchor
 * @return  none
 */
- (void)SetAnchor:(CGPoint)anchor
{
    m_anchorX = anchor.x;
    m_anchorY = anchor.y;
}


/**
 * @desc    set uv
 * @para    uvLeftTop
 * @para    uvRightDown
 * @return  none
 */
- (void)SetUVFrom:(CGPoint)uvLeftTop to:(CGPoint)uvRightDown
{
    self.U1 = uvLeftTop.x;
    self.V1 = uvLeftTop.y;
    
    self.U2 = uvRightDown.x;
    self.V2 = uvRightDown.y;
}


/**
 * @desc    set uv
 * @para    uvLeftTop
 * @para    size
 * @return  none
 */
- (void)SetUVAt:(CGPoint)uvLeftTop withSize:(CGPoint)size
{
    m_width = size.x;
    m_height = size.y;
    
    TextureInfo* info = [[RenderCore sharedInstance] GetTextureInfo:self.TEXTURE_NAME];
    
    float texWid = (float)info.WIDTH;
    float texHei = (float)info.HEIGHT;
    
    self.U1 = uvLeftTop.x / texWid;
    self.V1 = uvLeftTop.y / texHei;
    
    self.U2 = ( uvLeftTop.x + size.x ) / texWid;
    self.V2 = ( uvLeftTop.y + size.y ) / texHei;
    
}


/**
 * @desc    set size
 * @para    size
 * @return  none
 */
- (void)SetSize:(CGPoint)size
{
    m_width = size.x;
    m_height = size.y;
}


@end
