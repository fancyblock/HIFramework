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
    self.X1 = m_x - ( m_anchorX * m_width );
    self.Y1 = m_y - ( m_anchorY * m_height );
    
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
    self.X1 = pt.x - ( m_anchorX * m_width );
    self.Y1 = pt.y - ( m_anchorY * m_height );
    
    self.X3 = self.X1 + m_width;
    self.Y3 = self.Y1 + m_height;
    
    self.X2 = self.X3;
    self.Y2 = self.Y1;
    
    self.X4 = self.X1;
    self.Y4 = self.Y3;
    
    [[RenderCore sharedInstance] AddSprite:self];
}


/**
 * @desc    draw the sprite at pt position with specific size
 * @para    pt
 * @para    size
 * @return  none
 */
- (void)DrawAt:(CGPoint)pt withSize:(CGPoint)size
{
    self.X1 = pt.x - ( m_anchorX * size.x );
    self.Y1 = pt.y - ( m_anchorY * size.y );
    
    self.X3 = self.X1 + size.x;
    self.Y3 = self.Y1 + size.y;
    
    self.X2 = self.X3;
    self.Y2 = self.Y1;
    
    self.X4 = self.X1;
    self.Y4 = self.Y3;
    
    [[RenderCore sharedInstance] AddSprite:self];
}


/**
 * @desc    draw the sprite at pt position with angle
 * @para    pt
 * @para    angle
 * @return  none
 */
- (void)DrawAt:(CGPoint)pt withAngle:(float)angle
{
    float anchorX = m_anchorX * m_width;
    float anchorY = m_anchorY * m_height;
    
    self.X1 = -anchorX;
    self.Y1 = -anchorY;
    
    self.X3 = m_width - anchorX;
    self.Y3 = m_height - anchorY;
    
    self.X2 = self.X3;
    self.Y2 = self.Y1;
    
    self.X4 = self.X1;
    self.Y4 = self.Y3;
    
    //rotate
    float cosC = cosf( angle );
    float sinC = sinf( angle );
    float newX;
    float newY;
    newX = self.X1 * cosC - self.Y1 * sinC;
    newY = self.X1 * sinC + self.Y1 * cosC;
    self.X1 = newX;
    self.Y1 = newY;
    newX = self.X2 * cosC - self.Y2 * sinC;
    newY = self.X2 * sinC + self.Y2 * cosC;
    self.X2 = newX;
    self.Y2 = newY;
    newX = self.X3 * cosC - self.Y3 * sinC;
    newY = self.X3 * sinC + self.Y3 * cosC;
    self.X3 = newX;
    self.Y3 = newY;
    newX = self.X4 * cosC - self.Y4 * sinC;
    newY = self.X4 * sinC + self.Y4 * cosC;
    self.X4 = newX;
    self.Y4 = newY;
    
    self.X1 += pt.x;
    self.Y1 += pt.y;
    self.X2 += pt.x;
    self.Y2 += pt.y;
    self.X3 += pt.x;
    self.Y3 += pt.y;
    self.X4 += pt.x;
    self.Y4 += pt.y;
    
    [[RenderCore sharedInstance] AddSprite:self];
}


/**
 * @desc    draw the sprite at pt position with specific size and angle
 * @para    pt
 * @para    size
 * @para    angle
 * @return  none
 */
- (void)DrawAt:(CGPoint)pt withSize:(CGPoint)size andAngle:(float)angle
{
    float anchorX = m_anchorX * size.x;
    float anchorY = m_anchorY * size.y;
    
    self.X1 = -anchorX;
    self.Y1 = -anchorY;
    
    self.X3 = size.x - anchorX;
    self.Y3 = size.y - anchorY;
    
    self.X2 = self.X3;
    self.Y2 = self.Y1;
    
    self.X4 = self.X1;
    self.Y4 = self.Y3;
    
    //rotate
    float cosC = cosf( angle );
    float sinC = sinf( angle );
    float newX;
    float newY;
    newX = self.X1 * cosC - self.Y1 * sinC;
    newY = self.X1 * sinC + self.Y1 * cosC;
    self.X1 = newX;
    self.Y1 = newY;
    newX = self.X2 * cosC - self.Y2 * sinC;
    newY = self.X2 * sinC + self.Y2 * cosC;
    self.X2 = newX;
    self.Y2 = newY;
    newX = self.X3 * cosC - self.Y3 * sinC;
    newY = self.X3 * sinC + self.Y3 * cosC;
    self.X3 = newX;
    self.Y3 = newY;
    newX = self.X4 * cosC - self.Y4 * sinC;
    newY = self.X4 * sinC + self.Y4 * cosC;
    self.X4 = newX;
    self.Y4 = newY;
    
    self.X1 += pt.x;
    self.Y1 += pt.y;
    self.X2 += pt.x;
    self.Y2 += pt.y;
    self.X3 += pt.x;
    self.Y3 += pt.y;
    self.X4 += pt.x;
    self.Y4 += pt.y;
    
    [[RenderCore sharedInstance] AddSprite:self];
}


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


/**
 * @desc    set the tint color
 * @para    r
 * @para    g
 * @para    b
 * @para    alpha
 * @return  none
 */
- (void)SetColorR:(float)r andG:(float)g andB:(float)b andAlpha:(float)alpha
{
    self.COLOR_R = r;
    self.COLOR_G = g;
    self.COLOR_B = b;
    self.COLOR_A = alpha;
}


@end
