//
//  Sprite.h
//  HIFramework
//
//  Created by He JiaBin on 12-7-1.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sprite : NSObject
{
    NSString* m_textureName;
    int m_textureIndex;
    
    float m_width;
    float m_height;
    
    float m_anchorX;
    float m_anchorY;
    
    float m_x;
    float m_y;
}

@property (nonatomic, readwrite) float U1;
@property (nonatomic, readwrite) float V1;
@property (nonatomic, readwrite) float U2;
@property (nonatomic, readwrite) float V2;

@property (nonatomic, readwrite) float X1;
@property (nonatomic, readwrite) float Y1;
@property (nonatomic, readwrite) float X2;
@property (nonatomic, readwrite) float Y2;
@property (nonatomic, readwrite) float X3;
@property (nonatomic, readwrite) float Y3;
@property (nonatomic, readwrite) float X4;
@property (nonatomic, readwrite) float Y4;

@property (nonatomic, readwrite) float COLOR_R;
@property (nonatomic, readwrite) float COLOR_G;
@property (nonatomic, readwrite) float COLOR_B;
@property (nonatomic, readwrite) float COLOR_A;


//TODO 


@end
